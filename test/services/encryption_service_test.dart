import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/services/encryption_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cryptography/cryptography.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late EncryptionService encryptionService;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    encryptionService = EncryptionService(storage: mockStorage);
  });

  group('EncryptionService Tests', () {
    const password = 'test-password';
    final salt = List<int>.filled(16, 1); // Fixed salt for consistency

    test('deriveKey returns a valid SecretKey', () async {
      final key = await encryptionService.deriveKey(password, salt);
      expect(key, isA<SecretKey>());
      final bytes = await key.extractBytes();
      expect(bytes.length, 32); // 256-bit key
    });

    test('Encryption and Decryption roundtrip works', () async {
      const originalText = 'Hello, World!';
      final key = await encryptionService.deriveKey(password, salt);

      // Encrypt
      final encryptedText = await encryptionService.encrypt(
        originalText,
        key,
        salt,
      );

      // Verify format
      final parts = encryptedText.split(':');
      expect(parts.length, 4); // salt:nonce:ciphertext:mac

      // Decrypt
      final decryptedText = await encryptionService.decrypt(encryptedText, key);
      expect(decryptedText, equals(originalText));
    });

    test('extractSalt returns correct salt from formatted string', () {
      // salt is 'AQEBAQEBAQEBAQEBAQEBAQ==' for 16 bytes of 1s
      const formattedText = 'AQEBAQEBAQEBAQEBAQEBAQ==:nonce:cipher:mac';
      final extractedSalt = encryptionService.extractSalt(formattedText);
      expect(extractedSalt, equals(List<int>.filled(16, 1)));
    });

    test('saveKey writes to secure storage', () async {
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      final key = await encryptionService.deriveKey(password, salt);
      await encryptionService.saveKey(key, salt);

      verify(
        () => mockStorage.write(
          key: 'habo_vault_key',
          value: any(named: 'value'),
        ),
      ).called(1);
      verify(
        () => mockStorage.write(
          key: 'habo_key_salt',
          value: any(named: 'value'),
        ),
      ).called(1);
    });

    test('loadKey returns null when storage is empty', () async {
      when(
        () => mockStorage.read(key: any(named: 'key')),
      ).thenAnswer((_) async => null);

      final result = await encryptionService.loadKey();
      expect(result, isNull);
    });

    test('loadKey returns key and salt when storage has data', () async {
      final key = await encryptionService.deriveKey(password, salt);
      final keyBytes = await key.extractBytes();

      when(
        () => mockStorage.read(key: 'habo_vault_key'),
      ).thenAnswer((_) async => base64.encode(keyBytes));
      when(
        () => mockStorage.read(key: 'habo_key_salt'),
      ).thenAnswer((_) async => base64.encode(salt));

      final result = await encryptionService.loadKey();

      expect(result, isNotNull);
      expect(result!.salt, equals(salt));
      final loadedKeyBytes = await result.key.extractBytes();
      expect(loadedKeyBytes, equals(keyBytes));
    });

    test('clearKey deletes from storage', () async {
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async {});

      await encryptionService.clearKey();

      verify(() => mockStorage.delete(key: 'habo_vault_key')).called(1);
      verify(() => mockStorage.delete(key: 'habo_key_salt')).called(1);
    });
  });
}
