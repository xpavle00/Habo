/// Typed exception hierarchy for sync, encryption, and subscription errors.
///
/// Every exception carries a machine-readable [code] (e.g. `SYNC_PUSH_FAILED`)
/// and a human-readable [message] suitable for logging. An optional [cause]
/// preserves the original error for debugging.

// --- Base ---

/// Base class for all Habo sync-related exceptions.
abstract class HaboSyncException implements Exception {
  /// Machine-readable error code (e.g. `AUTH_NOT_LOGGED_IN`).
  final String code;

  /// Human-readable description of the error.
  final String message;

  /// The original exception/error that caused this, if any.
  final Object? cause;

  const HaboSyncException(this.code, this.message, [this.cause]);

  @override
  String toString() => '$runtimeType($code): $message';
}

// --- Authentication ---

class HaboAuthException extends HaboSyncException {
  const HaboAuthException(super.code, super.message, [super.cause]);

  /// User is not logged in.
  factory HaboAuthException.notLoggedIn() =>
      const HaboAuthException('AUTH_NOT_LOGGED_IN', 'User not logged in');

  /// Auth session has expired.
  factory HaboAuthException.sessionExpired() =>
      const HaboAuthException('AUTH_SESSION_EXPIRED', 'Session has expired');
}

// --- Encryption ---

class EncryptionException extends HaboSyncException {
  const EncryptionException(super.code, super.message, [super.cause]);

  /// Ciphertext format is invalid (not `salt:nonce:ciphertext:mac`).
  factory EncryptionException.invalidFormat([Object? cause]) =>
      EncryptionException(
        'ENC_INVALID_FORMAT',
        'Invalid ciphertext format. Expected salt:nonce:ciphertext:mac',
        cause,
      );

  /// Decryption failed (wrong key, tampered data, etc.).
  factory EncryptionException.decryptionFailed([Object? cause]) =>
      EncryptionException(
        'ENC_DECRYPTION_FAILED',
        'Decryption failed. The key may be incorrect or data may be corrupted',
        cause,
      );

  /// No encryption key found in secure storage.
  factory EncryptionException.keyNotFound() => const EncryptionException(
    'ENC_KEY_NOT_FOUND',
    'No encryption key found in secure storage',
  );

  /// Secure storage read/write failed.
  factory EncryptionException.storageError([Object? cause]) =>
      EncryptionException(
        'ENC_STORAGE_ERROR',
        'Failed to access secure storage',
        cause,
      );
}

// --- Sync ---

class SyncException extends HaboSyncException {
  const SyncException(super.code, super.message, [super.cause]);

  /// Remote sync_version changed since last pull (optimistic locking).
  factory SyncException.versionConflict() => const SyncException(
    'SYNC_VERSION_CONFLICT',
    'Remote sync version changed since last pull',
  );

  /// Encrypted payload exceeds the size limit.
  factory SyncException.payloadTooLarge(int bytes, int maxBytes) =>
      SyncException(
        'SYNC_PAYLOAD_TOO_LARGE',
        'Payload size (${(bytes / 1024 / 1024).toStringAsFixed(1)} MB) '
            'exceeds limit (${(maxBytes / 1024 / 1024).toStringAsFixed(0)} MB)',
      );

  /// Push failed after all retries.
  factory SyncException.pushFailed([Object? cause]) =>
      SyncException('SYNC_PUSH_FAILED', 'Push sync failed', cause);

  /// Pull failed.
  factory SyncException.pullFailed([Object? cause]) =>
      SyncException('SYNC_PULL_FAILED', 'Pull sync failed', cause);

  /// Profile fetch/update failed.
  factory SyncException.profileError(String detail, [Object? cause]) =>
      SyncException('SYNC_PROFILE_ERROR', detail, cause);

  /// Clock drift exceeds threshold.
  factory SyncException.clockDrift(int driftSeconds, int thresholdSeconds) =>
      SyncException(
        'SYNC_CLOCK_DRIFT',
        'Device clock is off by ${driftSeconds}s '
            '(threshold: ${thresholdSeconds}s). '
            'Conflict resolution may produce incorrect results',
      );
}

// --- Backup ---

class BackupException extends HaboSyncException {
  const BackupException(super.code, super.message, [super.cause]);

  /// Backup not found in database.
  factory BackupException.notFound(String backupId) =>
      BackupException('BACKUP_NOT_FOUND', 'Backup not found: $backupId');

  /// Upload to cloud storage failed.
  factory BackupException.uploadFailed([Object? cause]) =>
      BackupException('BACKUP_UPLOAD_FAILED', 'Failed to upload backup', cause);

  /// Restore from backup failed.
  factory BackupException.restoreFailed(String detail, [Object? cause]) =>
      BackupException('BACKUP_RESTORE_FAILED', detail, cause);

  /// Local backup creation failed.
  factory BackupException.createFailed([Object? cause]) =>
      BackupException('BACKUP_CREATE_FAILED', 'Failed to create backup', cause);
}

// --- Subscription ---

class SubscriptionException extends HaboSyncException {
  const SubscriptionException(super.code, super.message, [super.cause]);

  /// No active subscription.
  factory SubscriptionException.notActive() =>
      const SubscriptionException('SUB_NOT_ACTIVE', 'No active subscription');

  /// Subscription status check failed.
  factory SubscriptionException.checkFailed([Object? cause]) =>
      SubscriptionException(
        'SUB_CHECK_FAILED',
        'Failed to check subscription status',
        cause,
      );

  /// RevenueCat SDK initialization failed.
  factory SubscriptionException.initFailed([Object? cause]) =>
      SubscriptionException(
        'SUB_INIT_FAILED',
        'Failed to initialize subscription service',
        cause,
      );

  /// Paywall display failed.
  factory SubscriptionException.paywallFailed([Object? cause]) =>
      SubscriptionException(
        'SUB_PAYWALL_FAILED',
        'Failed to display paywall',
        cause,
      );

  /// Purchase restore failed.
  factory SubscriptionException.restoreFailed([Object? cause]) =>
      SubscriptionException(
        'SUB_RESTORE_FAILED',
        'Failed to restore purchases',
        cause,
      );
}

// --- Master Password ---

class MasterPasswordException extends HaboSyncException {
  const MasterPasswordException(super.code, super.message, [super.cause]);

  /// The entered master password is incorrect.
  factory MasterPasswordException.incorrect() => const MasterPasswordException(
    'MASTER_PW_INCORRECT',
    'Incorrect master password',
  );

  /// Remote profile is missing or has no encryption data.
  factory MasterPasswordException.profileMissing() =>
      const MasterPasswordException(
        'MASTER_PW_PROFILE_MISSING',
        'No encryption profile found. Please set up your master password',
      );

  /// Vault key is missing from the remote profile.
  factory MasterPasswordException.vaultKeyMissing() =>
      const MasterPasswordException(
        'MASTER_PW_VAULT_KEY_MISSING',
        'Vault key missing from profile. Please reset your account',
      );

  /// Verifier token is missing from the remote profile.
  factory MasterPasswordException.verifierMissing() =>
      const MasterPasswordException(
        'MASTER_PW_VERIFIER_MISSING',
        'Verifier token missing from profile',
      );
}
