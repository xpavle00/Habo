import 'dart:ui';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/services/encryption_service.dart';
import 'package:habo/services/sync_manager.dart';
import 'package:habo/services/sync_service.dart';
import 'package:habo/services/subscription_service.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSyncService extends Mock implements SyncService {}

class MockEncryptionService extends Mock implements EncryptionService {}

class MockSettingsManager extends Mock implements SettingsManager {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

class MockRealtimeChannel extends Mock implements RealtimeChannel {}

class MockSubscriptionService extends Mock implements SubscriptionService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SyncManager syncManager;
  late MockSyncService mockSyncService;
  late MockEncryptionService mockEncryptionService;
  late MockSettingsManager mockSettingsManager;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late MockUser mockUser;
  late MockRealtimeChannel mockRealtimeChannel;
  late MockSubscriptionService mockSubscriptionService;

  // Dummy key for testing
  final dummyKey = SecretKey(List.filled(32, 1));
  final dummySalt = List.filled(16, 2);

  setUp(() {
    mockSyncService = MockSyncService();
    mockEncryptionService = MockEncryptionService();
    mockSettingsManager = MockSettingsManager();
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    mockUser = MockUser();
    mockRealtimeChannel = MockRealtimeChannel();
    mockSubscriptionService = MockSubscriptionService();

    // Reset and set up ServiceLocator with mock subscription service
    ServiceLocator.instance.reset();
    ServiceLocator.instance.setSubscriptionServiceForTesting(
      mockSubscriptionService,
    );
    when(
      () => mockSubscriptionService.isSubscribed(),
    ).thenAnswer((_) async => true);

    registerFallbackValue(
      PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'id',
        value: '',
      ),
    );
    registerFallbackValue(AppLifecycleState.paused);
    registerFallbackValue(PostgresChangeEvent.update);
    registerFallbackValue(mockRealtimeChannel);

    // Setup Supabase Mocks
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
    when(() => mockGoTrueClient.currentUser).thenReturn(mockUser);
    when(
      () => mockGoTrueClient.onAuthStateChange,
    ).thenAnswer((_) => const Stream<AuthState>.empty());
    when(() => mockUser.id).thenReturn('test_user_id');

    // Setup Realtime Mocks
    when(
      () => mockSupabaseClient.channel(any()),
    ).thenReturn(mockRealtimeChannel);
    // Ignore typed arguments for simplicity or use helpers
    when(
      () => mockRealtimeChannel.onPostgresChanges(
        event: any(named: 'event'),
        schema: any(named: 'schema'),
        table: any(named: 'table'),
        filter: any(named: 'filter'),
        callback: any(named: 'callback'),
      ),
    ).thenReturn(mockRealtimeChannel);
    when(() => mockRealtimeChannel.subscribe()).thenReturn(mockRealtimeChannel);
    when(
      () => mockSupabaseClient.removeChannel(any()),
    ).thenAnswer((_) async => 'ok');

    // Default to configured needs mock
    when(
      () => mockEncryptionService.loadKey(),
    ).thenAnswer((_) async => (key: dummyKey, salt: dummySalt));

    // Default settings
    when(() => mockSettingsManager.syncVersion).thenReturn(0);
    when(
      () => mockSettingsManager.setSyncVersion(any()),
    ).thenAnswer((_) async {});
    when(() => mockSettingsManager.hasUnsyncedChanges).thenReturn(false);
    when(
      () => mockSettingsManager.setHasUnsyncedChanges(any()),
    ).thenAnswer((_) async {});
    when(() => mockSettingsManager.isSyncPaused).thenReturn(false);

    // SyncService default behavior
    when(
      () => mockSyncService.pushSync(
        expectedVersion: any(named: 'expectedVersion'),
      ),
    ).thenAnswer((_) async => 1);
    when(() => mockSyncService.pullSync(any())).thenAnswer((_) async => 1);
    when(() => mockSyncService.createPreSyncBackup()).thenAnswer((_) async {});
    when(
      () => mockSyncService.getClockDriftSeconds(),
    ).thenAnswer((_) async => 0);

    // Inject mock client
    syncManager = SyncManager(
      mockSyncService,
      mockEncryptionService,
      mockSettingsManager,
      client: mockSupabaseClient,
    );
  });

  tearDown(() {
    syncManager.dispose();
    ServiceLocator.instance.reset();
  });

  test('SyncManager initializes and checks configuration', () async {
    // Act
    syncManager.initialize();
    await Future.delayed(Duration.zero);

    // Assert
    verify(() => mockEncryptionService.loadKey()).called(2);
    expect(syncManager.status, SyncStatus.synced);
  });

  test('SyncManager scheduleSync sets dirty flag', () async {
    // Arrange
    syncManager.initialize();
    await Future.delayed(Duration.zero); // Wait for config check

    // Act
    syncManager.scheduleSync();

    // Assert
    verify(() => mockSettingsManager.setHasUnsyncedChanges(true)).called(1);
    // We don't wait for timer in this unit test as it requires FakeAsync
    // but verifying the flag set is sufficient to prove logic starts.
  });

  test('SyncManager syncNow triggers immediate pushSync', () async {
    // Arrange
    syncManager.initialize();
    await Future.delayed(Duration.zero);

    // Act
    // We expect 1 call from initialize() already.
    // syncNow() should add another one.

    // Restub what we need override
    when(
      () => mockSyncService.pushSync(
        expectedVersion: any(named: 'expectedVersion'),
      ),
    ).thenAnswer((_) async => 1);
    when(() => mockSyncService.pullSync(any())).thenAnswer((_) async => 0);
    when(
      () => mockSettingsManager.setSyncVersion(any()),
    ).thenAnswer((_) async {});
    // Important: Simulate that we have unsynced changes so push is called
    when(() => mockSettingsManager.hasUnsyncedChanges).thenReturn(true);
    when(
      () => mockSettingsManager.setHasUnsyncedChanges(any()),
    ).thenAnswer((_) async {});

    await syncManager.syncNow();

    // Assert
    // It should call pull then push
    // Total calls: 1 (init) + 1 (syncNow) = 2
    verify(() => mockSyncService.pullSync(any())).called(2);
    // pushSync called once by syncNow (pull now uses scheduleSync instead)
    verify(
      () => mockSyncService.pushSync(
        expectedVersion: any(named: 'expectedVersion'),
      ),
    ).called(1);
    verify(() => mockSettingsManager.setSyncVersion(1)).called(2);
  });

  test('SyncManager pulls data if configured on start', () async {
    // Arrange
    // Re-create manager to test init flow
    syncManager = SyncManager(
      mockSyncService,
      mockEncryptionService,
      mockSettingsManager,
      client: mockSupabaseClient,
    );

    // Act
    syncManager.initialize();
    await Future.delayed(Duration.zero);

    // Assert
    verify(() => mockSyncService.pullSync(0)).called(1);
  });

  test('SyncManager subscribes to Realtime on initialization', () async {
    // Arrange
    syncManager.initialize();
    await Future.delayed(Duration.zero);

    // Assert
    verify(
      () => mockSupabaseClient.channel('public:profiles:test_user_id'),
    ).called(1);
    verify(() => mockRealtimeChannel.subscribe()).called(1);
  });

  test('SyncManager unsubscribes on dispose', () async {
    // Arrange
    syncManager.initialize();
    await Future.delayed(Duration.zero);

    // Act
    syncManager.dispose();

    // Assert
    verify(
      () => mockSupabaseClient.removeChannel(mockRealtimeChannel),
    ).called(1);
  });
  test('pullSync schedules fresh push when hasUnsyncedChanges is true', () async {
    // Arrange
    syncManager.initialize();
    await Future.delayed(Duration.zero);

    // Simulate local changes pending
    when(() => mockSettingsManager.hasUnsyncedChanges).thenReturn(true);
    when(() => mockSyncService.pullSync(any())).thenAnswer((_) async => 2);

    // Act
    await syncManager.pullSync();
    // Allow the scheduleSync triggered at end of pullSync to be called
    await Future.delayed(Duration.zero);

    // Assert: pull completed, scheduleSync was called (which sets up debounced push)
    verify(
      () => mockSyncService.pullSync(any()),
    ).called(2); // 1 init + 1 explicit
    // Note: scheduleSync() is called, not _performPushSync() directly
    // This ensures we push POST-MERGE data, not stale pre-merge data
  });

  group('Pre-sync safety backup', () {
    test('first pull (syncVersion == 0) creates pre-sync backup', () async {
      // Arrange
      when(() => mockSettingsManager.syncVersion).thenReturn(0);
      when(
        () => mockSyncService.createPreSyncBackup(),
      ).thenAnswer((_) async {});
      when(() => mockSyncService.pullSync(any())).thenAnswer((_) async => 1);

      // Constructor runs _checkConfiguration (async), wait for it
      await Future.delayed(Duration.zero);
      // Clear the pull that happened during construction
      clearInteractions(mockSyncService);

      // Re-stub after clear
      when(
        () => mockSyncService.createPreSyncBackup(),
      ).thenAnswer((_) async {});
      when(() => mockSyncService.pullSync(any())).thenAnswer((_) async => 1);

      // Act
      await syncManager.pullSync();

      // Assert
      verify(() => mockSyncService.createPreSyncBackup()).called(1);
      verify(() => mockSyncService.pullSync(0)).called(1);
    });

    test('subsequent pull (syncVersion > 0) skips pre-sync backup', () async {
      // Arrange — let constructor finish first
      await Future.delayed(Duration.zero);
      clearInteractions(mockSyncService);

      // Now simulate version > 0
      when(() => mockSettingsManager.syncVersion).thenReturn(5);
      when(() => mockSyncService.pullSync(any())).thenAnswer((_) async => null);

      // Act
      await syncManager.pullSync();

      // Assert — no backup on subsequent pull
      verifyNever(() => mockSyncService.createPreSyncBackup());
    });

    test('backup failure does not block pull sync', () async {
      // Arrange
      when(() => mockSettingsManager.syncVersion).thenReturn(0);
      when(
        () => mockSyncService.createPreSyncBackup(),
      ).thenThrow(Exception('Network error'));
      when(() => mockSyncService.pullSync(any())).thenAnswer((_) async => 1);

      // Constructor runs _checkConfiguration (async), wait for it
      await Future.delayed(Duration.zero);
      clearInteractions(mockSyncService);

      // Re-stub after clear
      when(
        () => mockSyncService.createPreSyncBackup(),
      ).thenThrow(Exception('Network error'));
      when(() => mockSyncService.pullSync(any())).thenAnswer((_) async => 1);

      // Act
      await syncManager.pullSync();

      // Assert - pullSync still proceeded despite backup failure
      verify(() => mockSyncService.createPreSyncBackup()).called(1);
      verify(() => mockSyncService.pullSync(0)).called(1);
      expect(syncManager.status, SyncStatus.synced);
    });
  });
}
