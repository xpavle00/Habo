import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habo/services/sync_error.dart';

class EncryptionService {
  final FlutterSecureStorage _storage;

  // Storage Keys
  static const _storageKeyDerived = 'habo_vault_key';
  static const _storageKeySalt = 'habo_key_salt';

  // Crypto algorithms
  final _argon2 = Argon2id(
    parallelism: 1,
    memory: 19456, // 19 MB
    iterations: 2,
    hashLength: 32, // 256-bit key
  );
  final _aes = AesGcm.with256bits();

  EncryptionService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  // --- Core Crypto Operations ---

  /// Generates a random 256-bit SecretKey.
  Future<SecretKey> generateRandomKey() async {
    return await _aes.newSecretKey();
  }

  /// Derives a SecretKey from [password] and [salt] using Argon2id.
  Future<SecretKey> deriveKey(String password, List<int> salt) async {
    return await _argon2.deriveKeyFromPassword(password: password, nonce: salt);
  }

  /// Encrypts [plaintext] using [key].
  /// Returns a formatted string: salt:nonce:ciphertext:mac (all base64)
  Future<String> encrypt(
    String plaintext,
    SecretKey key,
    List<int> salt,
  ) async {
    final nonce = _aes.newNonce(); // 12 bytes standard for GCM
    final secretBox = await _aes.encrypt(
      utf8.encode(plaintext),
      secretKey: key,
      nonce: nonce,
    );

    final saltB64 = base64.encode(salt);
    final nonceB64 = base64.encode(secretBox.nonce);
    final cipherB64 = base64.encode(secretBox.cipherText);
    final macB64 = base64.encode(secretBox.mac.bytes);

    return '$saltB64:$nonceB64:$cipherB64:$macB64';
  }

  /// Decrypts [formattedText] using [key].
  /// [formattedText] must be in format: salt:nonce:ciphertext:mac
  ///
  /// Throws [EncryptionException] with code `ENC_INVALID_FORMAT` if the
  /// format is wrong, or `ENC_DECRYPTION_FAILED` if the key is incorrect
  /// or the data has been tampered with.
  Future<String> decrypt(String formattedText, SecretKey key) async {
    final parts = formattedText.split(':');
    if (parts.length != 4) {
      throw EncryptionException.invalidFormat();
    }

    try {
      final nonce = base64.decode(parts[1]);
      final cipherText = base64.decode(parts[2]);
      final macBytes = base64.decode(parts[3]);

      final secretBox = SecretBox(cipherText, nonce: nonce, mac: Mac(macBytes));
      final clearTextBytes = await _aes.decrypt(secretBox, secretKey: key);

      return utf8.decode(clearTextBytes);
    } on SecretBoxAuthenticationError catch (e) {
      throw EncryptionException.decryptionFailed(e);
    } on FormatException catch (e) {
      throw EncryptionException.invalidFormat(e);
    }
  }

  /// Extracts the salt from a formatted ciphertext without decrypting.
  ///
  /// Throws [EncryptionException] with code `ENC_INVALID_FORMAT` if
  /// the ciphertext is empty or malformed.
  List<int> extractSalt(String formattedText) {
    final parts = formattedText.split(':');
    if (parts.isEmpty || parts[0].isEmpty) {
      throw EncryptionException.invalidFormat();
    }
    try {
      return base64.decode(parts[0]);
    } on FormatException catch (e) {
      throw EncryptionException.invalidFormat(e);
    }
  }

  // --- Secure Storage Operations ---

  /// Saves the encryption key and salt to secure storage.
  ///
  /// Throws [EncryptionException] with code `ENC_STORAGE_ERROR` if
  /// the secure storage write fails.
  Future<void> saveKey(SecretKey key, List<int> salt) async {
    try {
      final keyBytes = await key.extractBytes();
      await _storage.write(
        key: _storageKeyDerived,
        value: base64.encode(keyBytes),
      );
      await _storage.write(key: _storageKeySalt, value: base64.encode(salt));
    } catch (e) {
      if (e is EncryptionException) rethrow;
      dev.log('Secure storage write failed', name: 'EncryptionService', error: e);
      throw EncryptionException.storageError(e);
    }
  }

  /// Generates a new salt, derives key from [password], and saves it.
  Future<({SecretKey key, List<int> salt})> deriveAndSaveKey(
    String password,
  ) async {
    final random = Random.secure();
    final salt = List<int>.generate(16, (_) => random.nextInt(256));
    final key = await deriveKey(password, salt);
    await saveKey(key, salt);
    return (key: key, salt: salt);
  }

  /// Loads the key from secure storage if it exists.
  ///
  /// Returns `null` if no key has been saved yet.
  /// Throws [EncryptionException] with code `ENC_STORAGE_ERROR` if
  /// the secure storage read fails.
  Future<({SecretKey key, List<int> salt})?> loadKey() async {
    try {
      final keyB64 = await _storage.read(key: _storageKeyDerived);
      final saltB64 = await _storage.read(key: _storageKeySalt);

      if (keyB64 == null || saltB64 == null) {
        return null;
      }

      final keyBytes = base64.decode(keyB64);
      final salt = base64.decode(saltB64);

      return (key: SecretKey(keyBytes), salt: salt);
    } catch (e) {
      if (e is EncryptionException) rethrow;
      dev.log('Secure storage read failed', name: 'EncryptionService', error: e);
      throw EncryptionException.storageError(e);
    }
  }

  /// Clears the encryption key and salt from secure storage.
  ///
  /// Throws [EncryptionException] with code `ENC_STORAGE_ERROR` if
  /// the secure storage delete fails.
  Future<void> clearKey() async {
    try {
      await _storage.delete(key: _storageKeyDerived);
      await _storage.delete(key: _storageKeySalt);
    } catch (e) {
      if (e is EncryptionException) rethrow;
      dev.log('Secure storage clear failed', name: 'EncryptionService', error: e);
      throw EncryptionException.storageError(e);
    }
  }
}
