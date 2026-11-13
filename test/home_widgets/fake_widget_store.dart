import 'package:habo/home_widgets/widget_store.dart';

/// In-memory store that records every write, so tests can assert on keys.
class FakeWidgetStore implements WidgetStore {
  final Map<String, Object> values = {};
  final List<String> writes = [];
  final List<List<String>> reloads = [];

  @override
  Future<String?> getString(String key) async => values[key] as String?;

  @override
  Future<int?> getInt(String key) async => values[key] as int?;

  @override
  Future<void> setString(String key, String value) async {
    writes.add(key);
    values[key] = value;
  }

  @override
  Future<void> setInt(String key, int value) async {
    writes.add(key);
    values[key] = value;
  }

  @override
  Future<void> reloadKinds(List<String> iosKinds) async {
    reloads.add(List.of(iosKinds));
  }
}
