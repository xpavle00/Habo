import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/widgets/home_widget_data.dart';
import 'dart:math' as math;

/// A 170x170 home widget that displays today's habit completion progress
class HaboHomeWidget extends StatelessWidget {
  final HomeWidgetData data;
  final Color? backgroundColor;
  final Color? primaryColor;
  final Color? textColor;
  
  const HaboHomeWidget({
    super.key,
    required this.data,
    this.backgroundColor,
    this.primaryColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.transparent;
    final primColor = primaryColor ?? HaboColors.primary;
    final txtColor = textColor ?? Colors.black;

    final todaysHabits = data.completedHabits + data.skippedHabits + data.failedHabits;
    
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Today\'s habits',
            style: TextStyle(
              fontSize: 16,
              color: txtColor,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
          width: 130,
          height: 130,
          child: CustomPaint(
            painter: CircularProgressPainter(
              total: data.totalHabits,
              completed: data.completedHabits,
              skipped: data.skippedHabits,
              failed: data.failedHabits,
              completedColor: primColor.withValues(alpha: 0.75),
              skippedColor: primColor.withValues(alpha: 0.2),
              failedColor: Colors.red,
              remainingColor: Colors.grey.withValues(alpha: 0.3),
            ),
            child: Center(
              child: todaysHabits == data.totalHabits && data.totalHabits > 0
                ? Icon(
                    Icons.check_rounded,
                    size: 80,
                    color: primColor,
                  )
                : Text(
                    '$todaysHabits/${data.totalHabits}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: txtColor,
                    ),
                  ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for circular progress indicator with multiple segments
class CircularProgressPainter extends CustomPainter {
  final int total;
  final int completed;
  final int skipped;
  final int failed;
  final Color completedColor;
  final Color skippedColor;
  final Color failedColor;
  final Color remainingColor;
  
  CircularProgressPainter({
    required this.total,
    required this.completed,
    required this.skipped,
    this.failed = 0,
    required this.completedColor,
    required this.skippedColor,
    required this.failedColor,
    required this.remainingColor,
  });
  
  // Legacy constructor for backward compatibility
  factory CircularProgressPainter.fromPercentage({
    required double percentage,
    required Color primaryColor,
    required Color backgroundColor,
  }) {
    final completed = (percentage / 100 * 10).round();
    return CircularProgressPainter(
      total: 10,
      completed: completed,
      skipped: 0,
      failed: 0,
      completedColor: primaryColor,
      skippedColor: primaryColor.withValues(alpha: 0.3),
      failedColor: Colors.red,
      remainingColor: backgroundColor,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final strokeWidth = 12.0;
    
    if (total == 0) return;
    
    final startAngle = -math.pi / 2; // Start from top
    final segmentAngle = (2 * math.pi) / total;
    
    // Draw background circle first (full circle, no rounded caps)
    final backgroundPaint = Paint()
      ..color = remainingColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;
    
    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);
    
    // Draw overlapping arcs from largest to smallest
    // This creates smooth transitions with rounded caps
    
    // 1. Draw skipped arc (failed + completed + skipped)
    if (skipped > 0) {
      final skippedCount = failed + completed + skipped;
      final skippedPaint = Paint()
        ..color = skippedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        segmentAngle * skippedCount,
        false,
        skippedPaint,
      );
    }
    
    // 2. Draw completed arc on top (failed + completed)
    if (completed > 0) {
      final completedCount = failed + completed;
      final completedPaint = Paint()
        ..color = completedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        segmentAngle * completedCount,
        false,
        completedPaint,
      );
    }
    
    // 3. Draw failed arc on top (failed only)
    if (failed > 0) {
      final failedPaint = Paint()
        ..color = failedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        segmentAngle * failed,
        false,
        failedPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.total != total ||
        oldDelegate.completed != completed ||
        oldDelegate.skipped != skipped ||
        oldDelegate.failed != failed ||
        oldDelegate.completedColor != completedColor ||
        oldDelegate.skippedColor != skippedColor ||
        oldDelegate.failedColor != failedColor ||
        oldDelegate.remainingColor != remainingColor;
  }
}
