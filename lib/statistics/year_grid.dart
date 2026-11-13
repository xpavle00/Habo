import 'package:flutter/material.dart';
import 'package:habo/constants.dart';

/// A whole calendar year as a "year in pixels" grid: one row per month, one
/// column per day of the month. Same layout as the iOS and Android year
/// widgets.
class YearGrid extends StatelessWidget {
  const YearGrid({
    super.key,
    required this.year,
    required this.dailyStatus,
    required this.colors,
    required this.monthLabels,
    this.today,
  });

  final int year;

  /// Day status keyed by local midnight. Days missing here are drawn empty.
  final Map<DateTime, DayType> dailyStatus;

  /// Fill colour per status. A status without a colour is drawn empty,
  /// which is how hidden categories drop out.
  final Map<DayType, Color> colors;

  /// Twelve short month labels, January first.
  final List<String> monthLabels;

  /// Defaults to the current day.
  final DateTime? today;

  static const double _labelWidth = 14;

  @override
  Widget build(BuildContext context) {
    final now = today ?? DateTime.now();
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final pitch = (constraints.maxWidth - _labelWidth) / 31;
        return SizedBox(
          width: constraints.maxWidth,
          height: pitch * 12,
          child: CustomPaint(
            painter: YearGridPainter(
              year: year,
              dailyStatus: dailyStatus,
              colors: colors,
              monthLabels: monthLabels,
              today: DateTime(now.year, now.month, now.day),
              emptyColor: Colors.grey,
              outlineColor: theme.colorScheme.onSurface,
              labelStyle: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              labelWidth: _labelWidth,
            ),
          ),
        );
      },
    );
  }
}

class YearGridPainter extends CustomPainter {
  YearGridPainter({
    required this.year,
    required this.dailyStatus,
    required this.colors,
    required this.monthLabels,
    required this.today,
    required this.emptyColor,
    required this.outlineColor,
    required this.labelStyle,
    required this.labelWidth,
  });

  final int year;
  final Map<DateTime, DayType> dailyStatus;
  final Map<DayType, Color> colors;
  final List<String> monthLabels;
  final DateTime today;
  final Color emptyColor;
  final Color outlineColor;
  final TextStyle labelStyle;
  final double labelWidth;

  /// The fill for one day: its status colour, or grey for an unmarked day,
  /// fainter for days that haven't come yet.
  Color colorFor(DateTime day) {
    final color = colors[dailyStatus[day]];
    if (color != null) return color;
    return emptyColor.withValues(alpha: day.isAfter(today) ? 0.12 : 0.28);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pitch = (size.width - labelWidth) / 31;
    final cell = pitch * 0.84;
    final radius = Radius.circular(cell * 0.3);
    final fill = Paint();
    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (cell * 0.16).clamp(1.0, 2.0)
      ..color = outlineColor;

    for (var month = 1; month <= 12; month++) {
      final y = (month - 1) * pitch + (pitch - cell) / 2;

      if (month <= monthLabels.length) {
        final label = TextPainter(
          text: TextSpan(text: monthLabels[month - 1], style: labelStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        label.paint(canvas, Offset(0, y + (cell - label.height) / 2));
      }

      final days = DateUtils.getDaysInMonth(year, month);
      for (var day = 1; day <= days; day++) {
        final date = DateTime(year, month, day);
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(labelWidth + (day - 1) * pitch, y, cell, cell),
          radius,
        );
        canvas.drawRRect(rect, fill..color = colorFor(date));
        if (date == today) canvas.drawRRect(rect, outline);
      }
    }
  }

  @override
  bool shouldRepaint(YearGridPainter old) =>
      old.year != year ||
      old.dailyStatus != dailyStatus ||
      old.today != today ||
      old.emptyColor != emptyColor ||
      old.outlineColor != outlineColor ||
      old.labelStyle != labelStyle ||
      !_sameColors(old.colors, colors) ||
      !_sameLabels(old.monthLabels, monthLabels);

  static bool _sameColors(Map<DayType, Color> a, Map<DayType, Color> b) =>
      a.length == b.length && a.entries.every((e) => b[e.key] == e.value);

  static bool _sameLabels(List<String> a, List<String> b) =>
      a.length == b.length &&
      Iterable<int>.generate(a.length).every((i) => a[i] == b[i]);
}
