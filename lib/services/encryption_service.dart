import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  Future<String> decrypt(String formattedText, SecretKey key) async {
    final parts = formattedText.split(':');
    if (parts.length != 4) {
      throw Exception('Invalid format. Expected salt:nonce:ciphertext:mac');
    }

    // parts[0] is salt, but we assume key is already derived correctly using it
    final nonce = base64.decode(parts[1]);
    final cipherText = base64.decode(parts[2]);
    final macBytes = base64.decode(parts[3]);

    final secretBox = SecretBox(cipherText, nonce: nonce, mac: Mac(macBytes));

    final clearTextBytes = await _aes.decrypt(secretBox, secretKey: key);

    return utf8.decode(clearTextBytes);
  }

  /// Extracts the salt from a formatted ciphertext without decrypting.
  List<int> extractSalt(String formattedText) {
    final parts = formattedText.split(':');
    if (parts.isEmpty) {
      throw Exception('Invalid format');
    }
    return base64.decode(parts[0]);
  }

  // --- Secure Storage Operations ---

  Future<void> saveKey(SecretKey key, List<int> salt) async {
    final keyBytes = await key.extractBytes();
    await _storage.write(
      key: _storageKeyDerived,
      value: base64.encode(keyBytes),
    );
    await _storage.write(key: _storageKeySalt, value: base64.encode(salt));
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
  Future<({SecretKey key, List<int> salt})?> loadKey() async {
    final keyB64 = await _storage.read(key: _storageKeyDerived);
    final saltB64 = await _storage.read(key: _storageKeySalt);

    if (keyB64 == null || saltB64 == null) {
      return null;
    }

    final keyBytes = base64.decode(keyB64);
    final salt = base64.decode(saltB64);

    return (key: SecretKey(keyBytes), salt: salt);
  }

  Future<void> clearKey() async {
    await _storage.delete(key: _storageKeyDerived);
    await _storage.delete(key: _storageKeySalt);
  }
}
