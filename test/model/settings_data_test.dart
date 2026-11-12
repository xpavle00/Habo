import 'package:flutter_test/flutter_test.dart';
import 'package:habo/constants.dart';
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

  group('SettingsData widgetTheme', () {
    test('defaults to device when missing or unknown', () {
      final missing = SettingsData().toJson()..remove('widgetTheme');
      expect(SettingsData.fromJson(missing).widgetTheme, WidgetTheme.device);
      final unknown = SettingsData().toJson()..['widgetTheme'] = 'neon';
      expect(SettingsData.fromJson(unknown).widgetTheme, WidgetTheme.device);
    });

    test('round-trips through json', () {
      final settings = SettingsData()..widgetTheme = WidgetTheme.dark;
      final restored = SettingsData.fromJson(settings.toJson());
      expect(restored.widgetTheme, WidgetTheme.dark);
    });
  });
}
