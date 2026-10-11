import 'package:flutter_test/flutter_test.dart';
import 'package:habo/model/settings_data.dart';

void main() {
  group('SettingsData offlineMode', () {
    test('defaults to false when missing from stored json', () {
      final json = SettingsData().toJson()..remove('offlineMode');

      final settings = SettingsData.fromJson(json);

      expect(settings.offlineMode, isFalse);
    });

    test('survives json round trip', () {
      final settings = SettingsData()..offlineMode = true;

      final restored = SettingsData.fromJson(settings.toJson());

      expect(restored.offlineMode, isTrue);
    });

    test('is kept by copyWith', () {
      final settings = SettingsData()..offlineMode = true;

      expect(settings.copyWith(syncVersion: 1).offlineMode, isTrue);
    });
  });
}
