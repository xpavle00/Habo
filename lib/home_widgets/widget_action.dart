/// A tap recorded by a native widget, waiting to be applied by the app.
///
/// [code] is the resulting day state, using the snapshot day codes:
/// `c` check, `.` clear, `p` progress below target, `P` progress at target.
class WidgetAction {
  const WidgetAction({
    required this.seq,
    required this.uuid,
    required this.date,
    required this.code,
    this.value,
    this.target,
    this.tappedAt,
    this.from,
  });

  final int seq;
  final String uuid;

  /// Local calendar date the tap was made for (midnight, local time).
  final DateTime date;
  final String code;
  final double? value;
  final double? target;

  /// When the widget was tapped (UTC), from the entry's `at`; null for
  /// entries written before it was recorded.
  final DateTime? tappedAt;

  /// Day code the widget showed for [date] just before the tap; null for
  /// entries written by widget builds that didn't record it.
  final String? from;

  static const Set<String> _codes = {'c', '.', 'p', 'P'};
  static const Set<String> _dayCodes = {'c', '.', 'f', 's', 'p', 'P'};

  /// Parses one entry of `widget_pending_actions`.
  ///
  /// Throws [FormatException] when the entry is malformed.
  factory WidgetAction.fromJson(Map<String, dynamic> json) {
    final seq = json['seq'];
    final uuid = json['uuid'];
    final date = json['date'];
    final code = json['code'];
    if (seq is! int || uuid is! String || date is! String || code is! String) {
      throw FormatException('Malformed widget action: $json');
    }
    if (!_codes.contains(code)) {
      throw FormatException('Unknown widget action code: $code');
    }
    final parts = date.split('-');
    if (parts.length != 3) {
      throw FormatException('Malformed widget action date: $date');
    }
    return WidgetAction(
      seq: seq,
      uuid: uuid,
      date: DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      ),
      code: code,
      value: (json['value'] as num?)?.toDouble(),
      target: (json['target'] as num?)?.toDouble(),
      tappedAt: _parseTime(json['at']),
      from: _dayCodes.contains(json['from']) ? json['from'] as String : null,
    );
  }

  static DateTime? _parseTime(Object? value) {
    if (value is! String) return null;
    return DateTime.tryParse(value)?.toUtc();
  }
}
