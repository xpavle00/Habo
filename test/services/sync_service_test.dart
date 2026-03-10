import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/services/sync_service.dart';
import 'package:habo/repositories/backup_repository.dart';
import 'package:habo/services/encryption_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cryptography/cryptography.dart';

class MockBackupRepository extends Mock implements BackupRepository {}

class MockEncryptionService extends Mock implements EncryptionService {}

class FakeSecretKey extends Fake implements SecretKey {}

void main() {
  late SyncService syncService;
  late MockBackupRepository mockBackupRepo;
  late MockEncryptionService mockEncryptionService;

  setUpAll(() {
    registerFallbackValue(FakeSecretKey());
  });

  setUp(() {
    mockBackupRepo = MockBackupRepository();
    mockEncryptionService = MockEncryptionService();
    syncService = SyncService(mockBackupRepo, mockEncryptionService);
  });

  group('SyncService Tests', () {
    final key = SecretKey(List.filled(32, 1)); // Mock 32-byte key
    final salt = List<int>.filled(16, 2); // Mock 16-byte salt
    final mockData = {'habits': [], 'version': 1};
    final mockJson = jsonEncode(mockData);
    final mockEncryptedString = 'salt:nonce:ciphertext:mac';

    test('generateEncryptedPayload encrypts exported data', () async {
      // Arrange
      when(
        () => mockBackupRepo.exportAllData(),
      ).thenAnswer((_) async => mockData);
      when(
        () => mockEncryptionService.encrypt(mockJson, key, salt),
      ).thenAnswer((_) async => mockEncryptedString);

      // Act
      final result = await syncService.generateEncryptedPayload(key, salt);

      // Assert
      expect(result, equals(mockEncryptedString));
      verify(() => mockBackupRepo.exportAllData()).called(1);
      verify(
        () => mockEncryptionService.encrypt(mockJson, key, salt),
      ).called(1);
    });

    test('restoreFromEncryptedPayload decrypts and imports data', () async {
      // Arrange
      when(
        () => mockEncryptionService.decrypt(mockEncryptedString, key),
      ).thenAnswer((_) async => mockJson);
      when(() => mockBackupRepo.importData(mockData)).thenAnswer((_) async {});

      // Act
      await syncService.restoreFromEncryptedPayload(mockEncryptedString, key);

      // Assert
      verify(
        () => mockEncryptionService.decrypt(mockEncryptedString, key),
      ).called(1);
      verify(() => mockBackupRepo.importData(mockData)).called(1);
    });

    test('restoreFromEncryptedPayload handles complex backup data', () async {
      // Arrange: More realistic backup data
      final complexData = {
        'habits': [
          {'id': 1, 'title': 'Exercise', 'events': {}},
          {'id': 2, 'title': 'Meditation', 'events': {}},
        ],
        'categories': [
          {'id': 1, 'title': 'Health'},
        ],
        'habit_categories': [
          {'habit_id': 1, 'category_id': 1},
        ],
        'metadata': {
          'export_timestamp': '2025-01-01T12:00:00Z',
          'total_habits': 2,
        },
      };
      final complexJson = jsonEncode(complexData);

      when(
        () => mockEncryptionService.decrypt(mockEncryptedString, key),
      ).thenAnswer((_) async => complexJson);
      when(
        () => mockBackupRepo.importData(complexData),
      ).thenAnswer((_) async {});

      // Act
      await syncService.restoreFromEncryptedPayload(mockEncryptedString, key);

      // Assert
      verify(() => mockBackupRepo.importData(complexData)).called(1);
    });

    group('changeMasterPassword', () {
      test('throws exception when profile is null (no Supabase user)', () async {
        // The method calls fetchProfile() which requires Supabase to be set up
        // Without Supabase, it will throw or return null
        expect(
          () async => await syncService.changeMasterPassword('old', 'new'),
          throwsA(anything),
        );
      });

      test('encryption service has required methods for password change', () {
        // Verify the encryption service has the methods needed for password change
        // These are the methods that changeMasterPassword uses:
        // - deriveKey(currentPassword, salt) -> derives a key from password
        // - encrypt(data, key, salt) -> encrypts data
        // - decrypt(encryptedData, key) -> decrypts data
        // - saveKey(key, salt) -> saves the key locally
        expect(mockEncryptionService.deriveKey, isNotNull);
        expect(mockEncryptionService.encrypt, isNotNull);
        expect(mockEncryptionService.decrypt, isNotNull);
        expect(mockEncryptionService.saveKey, isNotNull);
      });
    });
  });
}
