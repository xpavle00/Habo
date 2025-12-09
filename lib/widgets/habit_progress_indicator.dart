import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/model/habit_data.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';

class HabitProgressIndicator extends StatelessWidget {
  final HabitData habitData;
  final DateTime date;
  final double size;
  final VoidCallback? onTap;

  const HabitProgressIndicator({
    super.key,
    required this.habitData,
    required this.date,
    this.size = 40.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (habitData.isBoolean) {
      return _buildBooleanIndicator(context);
    } else {
      return _buildNumericIndicator(context);
    }
  }

  Widget _buildBooleanIndicator(BuildContext context) {
    final event = habitData.events[date];
    final dayType = event?[0] as DayType?;

    Color backgroundColor;
    Color iconColor = Colors.white;
    IconData icon;

    switch (dayType) {
      case DayType.check:
        backgroundColor = HaboColors.primary;
        icon = Icons.check;
        break;
      case DayType.fail:
        backgroundColor = HaboColors.red;
        icon = Icons.close;
        break;
      case DayType.skip:
        backgroundColor = HaboColors.skip;
        icon = Icons.last_page;
        break;
      case DayType.clear:
      case null:
      default:
        backgroundColor = Colors.grey.shade300;
        iconColor = Colors.grey.shade600;
        icon = Icons.radio_button_unchecked;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.6,
        ),
      ),
    );
  }

  Widget _buildNumericIndicator(BuildContext context) {
    final progress = habitData.getProgressForDate(date);
    final percentage = habitData.getProgressPercentage(date);
    final isCompleted = habitData.isCompletedForDate(date);
    final isExceeded = progress > habitData.targetValue;

    Color progressColor;
    Color backgroundColor = HaboColors.progressBackground;

    final settingsManager =
        Provider.of<SettingsManager>(context, listen: false);

    if (isExceeded) {
      progressColor = settingsManager.checkColor;
    } else if (isCompleted) {
      progressColor = settingsManager.checkColor;
    } else if (progress > 0) {
      progressColor = settingsManager.progressColor;
    } else {
      progressColor = Colors.grey.shade400;
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background circle
            CircularProgressIndicator(
              value: 1.0,
              strokeWidth: size * 0.15,
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
            ),
            // Progress circle
            CircularProgressIndicator(
              value: percentage,
              strokeWidth: size * 0.15,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
            // Center content
            if (isCompleted)
              Icon(
                isExceeded ? Icons.star : Icons.check,
                color: progressColor,
                size: size * 0.5,
              )
            else if (progress > 0)
              Text(
                '${(percentage * 100).round()}%',
                style: TextStyle(
                  fontSize: size * 0.25,
                  fontWeight: FontWeight.bold,
                  color: progressColor,
                ),
              )
            else
              Icon(
                Icons.add,
                color: Colors.grey.shade600,
                size: size * 0.4,
              ),
          ],
        ),
      ),
    );
  }
}

class HabitProgressSummary extends StatelessWidget {
  final HabitData habitData;
  final DateTime date;

  const HabitProgressSummary({
    super.key,
    required this.habitData,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    if (habitData.isBoolean) {
      return const SizedBox.shrink();
    }

    final progress = habitData.getProgressForDate(date);
    final isCompleted = habitData.isCompletedForDate(date);

    if (progress == 0) {
      return Text(
        '0 / ${habitData.targetValue.toStringAsFixed(habitData.targetValue == habitData.targetValue.roundToDouble() ? 0 : 1)} ${habitData.unit}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
            ),
      );
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodySmall,
        children: [
          TextSpan(
            text: progress
                .toStringAsFixed(progress == progress.roundToDouble() ? 0 : 1),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isCompleted ? HaboColors.primary : HaboColors.progress,
            ),
          ),
          TextSpan(
            text:
                ' / ${habitData.targetValue.toStringAsFixed(habitData.targetValue == habitData.targetValue.roundToDouble() ? 0 : 1)} ${habitData.unit}',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          if (isCompleted)
            TextSpan(
              text: ' ✓',
              style: TextStyle(
                color: HaboColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
