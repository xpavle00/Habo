import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:habo/repositories/backup_repository.dart';
import 'package:habo/services/encryption_service.dart';
import 'package:habo/services/sync_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart'; // For Uint8List

class SyncService {
  final BackupRepository _backupRepository;
  final EncryptionService _encryptionService;

  static const _logName = 'SyncService';

  SyncService(this._backupRepository, this._encryptionService);

  /// Exports all app data, converts to JSON, encrypts it, and returns the encrypted string.
  /// Format: `salt:nonce:ciphertext:mac`
  Future<String> generateEncryptedPayload(SecretKey key, List<int> salt) async {
    final data = await _backupRepository.exportAllData();
    final jsonString = jsonEncode(data);
    return await _encryptionService.encrypt(jsonString, key, salt);
  }

  /// Takes an encrypted payload string, decrypts it, parses JSON, and restores data to the DB.
  Future<void> restoreFromEncryptedPayload(
    String encryptedPayload,
    SecretKey key,
  ) async {
    final jsonString = await _encryptionService.decrypt(encryptedPayload, key);
    final data = jsonDecode(jsonString);
    await _backupRepository.importData(data);
  }

  // --- Profile / Master Password Protocol ---

  /// Fetches the user's profile which contains the [encryption_salt], [verifier_token], and [encrypted_vault_key].
  /// Returns `null` if the profile does not exist or fields are missing.
  ///
  /// Throws [AuthException] if user is not logged in.
  /// Throws [SyncException] if the profile fetch fails.
  Future<Map<String, dynamic>?> fetchProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw HaboAuthException.notLoggedIn();

    try {
      final response = await Supabase.instance.client
          .from('profiles')
          .select('encryption_salt, verifier_token, encrypted_vault_key')
          .eq('id', user.id)
          .maybeSingle();

      return response;
    } on PostgrestException catch (e) {
      throw SyncException.profileError('Failed to fetch encryption profile', e);
    }
  }

  /// Saves the [encryption_salt], [verifier_token], and [encrypted_vault_key] to the user's profile.
  ///
  /// Throws [AuthException] if user is not logged in.
  Future<void> upsertProfile({
    required String saltB64,
    required String verifierTokenB64,
    required String encryptedVaultKeyB64,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw HaboAuthException.notLoggedIn();

    await Supabase.instance.client.from('profiles').upsert({
      'id': user.id,
      'encryption_salt': saltB64,
      'verifier_token': verifierTokenB64,
      'encrypted_vault_key': encryptedVaultKeyB64,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  // --- Master Password Logic ---

  static const _verifierContent = 'habo-valid';

  /// Sets up a new Master Password for the user.
  /// Generates salts, keys, and uploads encrypted artifacts to Supabase.
  /// Also saves the Vault Key locally.
  ///
  /// Throws [AuthException], [EncryptionException], or [SyncException] on failure.
  Future<void> setupMasterPassword(String password) async {
    // 1. Generate new Salt using cryptographically secure random
    final random = Random.secure();
    final salt = List<int>.generate(16, (_) => random.nextInt(256));

    // 2. Derive Master Key (KEK)
    final masterKey = await _encryptionService.deriveKey(password, salt);

    // 3. Create Verifier Token (using Master Key)
    final verifierToken = await _encryptionService.encrypt(
      _verifierContent,
      masterKey,
      salt,
    );

    // 4. Generate Vault Key (DEK)
    final vaultKey = await _encryptionService.generateRandomKey();
    final vaultKeyBytes = await vaultKey.extractBytes();
    final vaultKeyB64 = base64.encode(vaultKeyBytes);

    // 5. Encrypt Vault Key with Master Key
    final encryptedVaultKey = await _encryptionService.encrypt(
      vaultKeyB64,
      masterKey,
      salt,
    );

    // 6. Upload to remote
    await upsertProfile(
      saltB64: base64.encode(salt),
      verifierTokenB64: verifierToken,
      encryptedVaultKeyB64: encryptedVaultKey,
    );

    // 7. Save Vault Key locally
    await _encryptionService.saveKey(vaultKey, salt);
  }

  /// Unlocks the Master Password flow.
  /// Downloads profile, verifies password, decrypts Vault Key and saves it locally.
  ///
  /// Throws [MasterPasswordException] if password is incorrect or profile data is missing.
  /// Throws [EncryptionException] on decryption failures.
  Future<void> unlockMasterPassword(
    String password,
    Map<String, dynamic> remoteProfile,
  ) async {
    // 1. Get Salt & Encrypted Data from remote
    final saltB64 = remoteProfile['encryption_salt'] as String;
    final remoteVerifierToken = remoteProfile['verifier_token'] as String;
    final encryptedVaultKeyB64 =
        remoteProfile['encrypted_vault_key'] as String?;

    final salt = base64.decode(saltB64);

    // 2. Derive Master Key (KEK) using remote salt
    final masterKey = await _encryptionService.deriveKey(password, salt);

    // 3. Verify
    try {
      final decryptedVerifier = await _encryptionService.decrypt(
        remoteVerifierToken,
        masterKey,
      );
      if (decryptedVerifier != _verifierContent) {
        throw MasterPasswordException.incorrect();
      }
    } on MasterPasswordException {
      rethrow;
    } on EncryptionException {
      // Decryption failure means wrong password
      throw MasterPasswordException.incorrect();
    }

    // 4. Unwrap Vault Key (DEK)
    if (encryptedVaultKeyB64 == null) {
      throw MasterPasswordException.vaultKeyMissing();
    }

    final vaultKeyStr = await _encryptionService.decrypt(
      encryptedVaultKeyB64,
      masterKey,
    );
    final vaultKeyBytes = base64.decode(vaultKeyStr);
    final vaultKey = SecretKey(vaultKeyBytes);

    // 5. Save Vault Key locally
    await _encryptionService.saveKey(vaultKey, salt);
  }

  /// Changes the master password.
  /// First verifies the current password, then re-encrypts the vault key with the new password.
  ///
  /// Throws [MasterPasswordException] if the current password is incorrect
  /// or profile data is missing.
  Future<void> changeMasterPassword(
    String currentPassword,
    String newPassword,
  ) async {
    // 1. Fetch current profile
    final profile = await fetchProfile();
    if (profile == null || profile['encryption_salt'] == null) {
      throw MasterPasswordException.profileMissing();
    }

    // 2. Get current salt and data
    final currentSaltB64 = profile['encryption_salt'] as String;
    final currentSalt = base64.decode(currentSaltB64);
    final remoteVerifierToken = profile['verifier_token'] as String?;
    final encryptedVaultKeyB64 = profile['encrypted_vault_key'] as String?;

    // 3. Derive current master key to decrypt the vault key
    final currentMasterKey = await _encryptionService.deriveKey(
      currentPassword,
      currentSalt,
    );

    // 4. Verify current password against verifier token
    if (remoteVerifierToken == null) {
      throw MasterPasswordException.verifierMissing();
    }
    try {
      final decryptedVerifier = await _encryptionService.decrypt(
        remoteVerifierToken,
        currentMasterKey,
      );
      if (decryptedVerifier != _verifierContent) {
        throw MasterPasswordException.incorrect();
      }
    } on MasterPasswordException {
      rethrow;
    } on EncryptionException {
      throw MasterPasswordException.incorrect();
    }

    // 5. Decrypt the vault key with current master key
    if (encryptedVaultKeyB64 == null) {
      throw MasterPasswordException.vaultKeyMissing();
    }
    final vaultKeyStr = await _encryptionService.decrypt(
      encryptedVaultKeyB64,
      currentMasterKey,
    );

    // 6. Generate new salt for the new password
    final random = Random.secure();
    final newSalt = List<int>.generate(16, (_) => random.nextInt(256));

    // 7. Derive new master key from new password
    final newMasterKey = await _encryptionService.deriveKey(
      newPassword,
      newSalt,
    );

    // 8. Create new verifier token with new master key
    final newVerifierToken = await _encryptionService.encrypt(
      _verifierContent,
      newMasterKey,
      newSalt,
    );

    // 9. Re-encrypt vault key with new master key
    final newEncryptedVaultKey = await _encryptionService.encrypt(
      vaultKeyStr,
      newMasterKey,
      newSalt,
    );

    // 10. Update remote profile
    await upsertProfile(
      saltB64: base64.encode(newSalt),
      verifierTokenB64: newVerifierToken,
      encryptedVaultKeyB64: newEncryptedVaultKey,
    );

    // 11. Save vault key locally with new salt
    final vaultKeyBytes = base64.decode(vaultKeyStr);
    final vaultKey = SecretKey(vaultKeyBytes);
    await _encryptionService.saveKey(vaultKey, newSalt);
  }

  // --- Backup Logic ---

  /// Represents a cloud backup entry.
  static const _minBackupIntervalHours = 24;

  /// Checks if a new backup should be created (>24h since last backup).
  Future<bool> shouldCreateBackup() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return false;

    try {
      final response = await Supabase.instance.client
          .from('backups')
          .select('created_at')
          .eq('user_id', user.id)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) return true; // No backups yet

      final lastBackupTime = DateTime.parse(response['created_at'] as String);
      final hoursSinceLastBackup = DateTime.now()
          .difference(lastBackupTime)
          .inHours;

      return hoursSinceLastBackup >= _minBackupIntervalHours;
    } on PostgrestException catch (e) {
      dev.log('Failed to check backup status', name: _logName, error: e);
      return false;
    }
  }

  /// Lists all backups for the current user, ordered by most recent first.
  Future<List<Map<String, dynamic>>> listBackups() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return [];

    try {
      final response = await Supabase.instance.client
          .from('backups')
          .select('id, created_at, habits_count')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      dev.log('Failed to list backups', name: _logName, error: e);
      return [];
    }
  }

  /// Creates a backup by copying the sync payload bytes to a backup path.
  /// Returns the backup ID if successful.
  ///
  /// Throws [BackupException] on failure.
  Future<String?> createBackupFromPayload(
    Uint8List payloadBytes,
    int habitsCount,
  ) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return null;

    try {
      // Use ISO timestamp without colons for filename compatibility
      final timestamp = DateTime.now().toUtc().toIso8601String().replaceAll(
        ':',
        '-',
      );
      final backupPath = '${user.id}/backups/$timestamp.enc';

      // Upload backup blob
      await Supabase.instance.client.storage
          .from('sync-blobs')
          .uploadBinary(backupPath, payloadBytes);

      // Record in backups table (trigger will auto-delete oldest if >5)
      final response = await Supabase.instance.client
          .from('backups')
          .insert({
            'user_id': user.id,
            'blob_path': backupPath,
            'habits_count': habitsCount,
          })
          .select('id')
          .single();

      dev.log(
        'Backup created: $backupPath ($habitsCount habits)',
        name: _logName,
      );
      return response['id'] as String;
    } catch (e) {
      dev.log('Backup creation failed', name: _logName, error: e);
      return null;
    }
  }

  /// Restores data from a specific backup.
  /// Downloads the backup, decrypts it, and imports to local DB.
  ///
  /// Throws [AuthException] if user is not logged in.
  /// Throws [EncryptionException] if no key is found or decryption fails.
  /// Throws [BackupException] if the backup cannot be found or downloaded.
  Future<void> restoreFromBackup(String backupId) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw HaboAuthException.notLoggedIn();

    // 1. Get backup info
    final Map<String, dynamic> backup;
    try {
      backup = await Supabase.instance.client
          .from('backups')
          .select('blob_path')
          .eq('id', backupId)
          .eq('user_id', user.id)
          .single();
    } on PostgrestException {
      throw BackupException.notFound(backupId);
    }

    final blobPath = backup['blob_path'] as String;

    // 2. Load encryption key
    final keyData = await _encryptionService.loadKey();
    if (keyData == null) throw EncryptionException.keyNotFound();

    // 3. Download backup blob
    final Uint8List bytes;
    try {
      bytes = await Supabase.instance.client.storage
          .from('sync-blobs')
          .download(blobPath);
    } catch (e) {
      throw BackupException.restoreFailed(
        'Failed to download backup from storage',
        e,
      );
    }

    final encryptedPayload = utf8.decode(bytes);

    // 4. Decrypt
    final jsonString = await _encryptionService.decrypt(
      encryptedPayload,
      keyData.key,
    );
    final backupData = jsonDecode(jsonString) as Map<String, dynamic>;

    final habitsCount = (backupData['habits'] as List?)?.length ?? 0;
    final categoriesCount = (backupData['categories'] as List?)?.length ?? 0;
    dev.log(
      'Restoring backup: $habitsCount habits, $categoriesCount categories',
      name: _logName,
    );

    // 5. Import data (replace local with backup)
    await _backupRepository.importData(backupData);

    dev.log('Restore completed from: $blobPath', name: _logName);
  }

  // --- Pre-Sync Safety Backup ---

  /// Creates a cloud backup of the current local data before the first pull sync.
  /// This acts as a safety net when a user logs in on a new device that already
  /// has local habits — if the merge produces unexpected results, the user can
  /// restore from this backup.
  Future<void> createPreSyncBackup() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    // 1. Load encryption key
    final keyData = await _encryptionService.loadKey();
    if (keyData == null) return;

    // 2. Export local data
    final data = await _backupRepository.exportAllData();
    final habitsCount = (data['habits'] as List?)?.length ?? 0;

    if (habitsCount == 0) {
      dev.log('Pre-sync backup skipped: no local habits', name: _logName);
      return;
    }

    // 3. Encrypt local data
    data['sync_timestamp'] = DateTime.now().toUtc().toIso8601String();
    final jsonString = jsonEncode(data);
    final encryptedPayload = await _encryptionService.encrypt(
      jsonString,
      keyData.key,
      keyData.salt,
    );
    final bytes = Uint8List.fromList(utf8.encode(encryptedPayload));

    // 4. Upload as backup
    final backupId = await createBackupFromPayload(bytes, habitsCount);
    if (backupId != null) {
      dev.log(
        'Pre-sync safety backup created: $habitsCount habits preserved',
        name: _logName,
      );
    } else {
      dev.log(
        'Pre-sync safety backup failed to upload',
        name: _logName,
        level: 900, // Warning
      );
    }
  }

  // --- Sync Logic ---

  /// Maximum allowed sync payload size (5 MB).
  /// Guards against corrupted DBs or bugs producing oversized uploads that
  /// would hit Supabase Storage / row-size limits with a vague server error.
  static const _maxPayloadBytes = 5 * 1024 * 1024;

  /// Maximum acceptable clock drift in seconds before warning.
  static const clockDriftThresholdSeconds = 60;

  /// Measures the clock drift between this device and the Supabase server.
  ///
  /// Returns the drift in seconds (positive = local ahead, negative = local behind).
  /// Uses the midpoint of the request to approximate network latency.
  /// Returns `null` if the check fails (e.g., no network).
  Future<int?> getClockDriftSeconds() async {
    try {
      final beforeLocal = DateTime.now().toUtc();
      final serverTimeStr =
          await Supabase.instance.client.rpc('get_server_time') as String;
      final afterLocal = DateTime.now().toUtc();

      final serverTime = DateTime.parse(serverTimeStr).toUtc();
      // Use midpoint of before/after to account for network round-trip
      final localMidpoint = beforeLocal.add(
        Duration(
          milliseconds: afterLocal.difference(beforeLocal).inMilliseconds ~/ 2,
        ),
      );

      return localMidpoint.difference(serverTime).inSeconds;
    } catch (e) {
      dev.log('Clock drift check failed', name: _logName, error: e);
      return null;
    }
  }

  /// Checks the remote sync version against local version.
  /// Returns the remote version, or -1 if no remote data exists.
  Future<int> getRemoteSyncVersion() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return -1;

    try {
      final response = await Supabase.instance.client
          .from('profiles')
          .select('sync_version')
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) return -1;
      return (response['sync_version'] as int?) ?? 0;
    } catch (e) {
      return -1;
    }
  }

  /// Pushes local data to Supabase Storage as an encrypted blob.
  ///
  /// Uses an atomic server-side RPC (`push_sync_version`) that increments
  /// `sync_version` only when it still equals [expectedVersion].  If another
  /// device pushed in the meantime the RPC raises `SYNC_VERSION_CONFLICT` and
  /// this method throws [SyncException] so the caller can pull, merge, and retry.
  ///
  /// Also creates a backup if >24 h since the last backup.
  ///
  /// Throws [AuthException] if user is not logged in.
  /// Throws [EncryptionException] if no key is found.
  /// Throws [SyncException] on version conflict or payload size violation.
  Future<int> pushSync({required int expectedVersion}) async {
    dev.log('Push started (expectedVersion=$expectedVersion)', name: _logName);
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw HaboAuthException.notLoggedIn();

    // 1. Load local key
    final keyData = await _encryptionService.loadKey();
    if (keyData == null) throw EncryptionException.keyNotFound();

    final vaultKey = keyData.key;
    final salt = keyData.salt;

    // 2. Export and encrypt data
    final data = await _backupRepository.exportAllData();
    data['sync_timestamp'] = DateTime.now().toUtc().toIso8601String();

    final pushHabits = data['habits'] as List? ?? [];
    final pushCategories = data['categories'] as List? ?? [];
    dev.log(
      'Push: exporting ${pushHabits.length} habits, '
      '${pushCategories.length} categories',
      name: _logName,
    );

    final jsonString = jsonEncode(data);
    final encryptedPayload = await _encryptionService.encrypt(
      jsonString,
      vaultKey,
      salt,
    );

    // 3. Pre-check: verify version hasn't changed before uploading blob.
    //    This prevents overwriting another device's blob when a conflict exists.
    //    The atomic RPC in step 5 remains as a second safety net for the narrow
    //    window between this check and the upload.
    final currentRemoteVersion = await getRemoteSyncVersion();
    if (currentRemoteVersion != expectedVersion) {
      dev.log(
        'Push: version conflict in pre-check '
        '(remote=$currentRemoteVersion, expected=$expectedVersion)',
        name: _logName,
        level: 900,
      );
      throw SyncException.versionConflict();
    }

    // 4. Upload to Storage
    // Use a versioned blob path to prevent CDN caching issues.
    final nextVersion = expectedVersion + 1;
    final blobPath = '${user.id}/sync_v$nextVersion.enc';

    // Remember old blob path so we can clean it up after a successful push.
    String? oldBlobPath;
    try {
      final profile = await Supabase.instance.client
          .from('profiles')
          .select('sync_blob_path')
          .eq('id', user.id)
          .maybeSingle();
      oldBlobPath = profile?['sync_blob_path'] as String?;
    } catch (_) {
      // Non-critical — worst case we leave an orphaned blob.
    }

    final bytes = Uint8List.fromList(utf8.encode(encryptedPayload));

    if (bytes.length > _maxPayloadBytes) {
      throw SyncException.payloadTooLarge(bytes.length, _maxPayloadBytes);
    }

    dev.log(
      'Push: uploading ${(bytes.length / 1024).toStringAsFixed(1)} KB',
      name: _logName,
    );

    await Supabase.instance.client.storage
        .from('sync-blobs')
        .uploadBinary(
          blobPath,
          bytes,
          fileOptions: const FileOptions(
            upsert: true,
            cacheControl: 'no-cache, no-store, must-revalidate',
          ),
        );

    // 5. Atomically increment version (fails if another device pushed first)
    try {
      final newVersion = await Supabase.instance.client.rpc(
        'push_sync_version',
        params: {
          'expected_version': expectedVersion,
          'new_blob_path': blobPath,
        },
      );
      // newVersion is returned as dynamic; cast to int.
      final version = newVersion as int;

      // 6. Clean up old blob (best-effort, non-blocking)
      if (oldBlobPath != null && oldBlobPath != blobPath) {
        try {
          await Supabase.instance.client.storage.from('sync-blobs').remove([
            oldBlobPath,
          ]);
        } catch (e) {
          dev.log(
            'Failed to delete old blob (non-fatal)',
            name: _logName,
            error: e,
          );
        }
      }

      // 7. Create backup if >24h since last backup (reuse same payload)
      final habitsCount = (data['habits'] as List?)?.length ?? 0;
      if (await shouldCreateBackup()) {
        await createBackupFromPayload(bytes, habitsCount);
      }

      dev.log('Push completed (version=$version)', name: _logName);
      return version;
    } on PostgrestException catch (e) {
      if (e.code == 'P0002' || (e.message.contains('SYNC_VERSION_CONFLICT'))) {
        throw SyncException.versionConflict();
      }
      rethrow;
    }
  }

  /// Pulls remote data from Supabase Storage and merges with local.
  /// Uses LWW (Last-Write-Wins) strategy.
  /// Returns the new sync version if updated, or null if no update needed.
  ///
  /// Throws [AuthException] if user is not logged in.
  /// Throws [EncryptionException] if no key is found or decryption fails.
  /// Throws [SyncException] on download/merge failures.
  Future<int?> pullSync(int localVersion) async {
    dev.log('Pull started (localVersion=$localVersion)', name: _logName);
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw HaboAuthException.notLoggedIn();

    // 1. Load local key
    final keyData = await _encryptionService.loadKey();
    if (keyData == null) throw EncryptionException.keyNotFound();

    final vaultKey = keyData.key;

    // 2. Get blob path from profiles
    final profile = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (profile == null || profile['sync_blob_path'] == null) {
      dev.log('Pull: no remote data yet', name: _logName);
      return null;
    }

    final remoteVersion = (profile['sync_version'] as int?) ?? 0;
    dev.log('Pull: remote=$remoteVersion, local=$localVersion', name: _logName);

    if (remoteVersion <= localVersion) {
      dev.log('Pull: already up to date', name: _logName);
      return null;
    }

    final blobPath = profile['sync_blob_path'] as String;

    // 3. Download blob
    final bytes = await Supabase.instance.client.storage
        .from('sync-blobs')
        .download(blobPath);

    final encryptedPayload = utf8.decode(bytes);

    // 4. Decrypt
    final jsonString = await _encryptionService.decrypt(
      encryptedPayload,
      vaultKey,
    );
    final remoteData = jsonDecode(jsonString) as Map<String, dynamic>;

    final pullHabits = remoteData['habits'] as List? ?? [];
    final pullCategories = remoteData['categories'] as List? ?? [];
    dev.log(
      'Pull: received ${pullHabits.length} habits, '
      '${pullCategories.length} categories',
      name: _logName,
    );

    // 5. Merge with local using LWW strategy
    await _backupRepository.mergeData(remoteData);

    dev.log('Pull completed (version=$remoteVersion)', name: _logName);
    return remoteVersion;
  }
}
