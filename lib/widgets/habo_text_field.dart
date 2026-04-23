import 'package:flutter/material.dart';
import 'package:habo/constants.dart';

class HaboTextField extends StatelessWidget {
  final Widget child;
  final String? label;
  final String? errorText;
  final String? helperText;
  final EdgeInsetsGeometry? padding;

  const HaboTextField({
    super.key,
    required this.child,
    this.label,
    this.errorText,
    this.helperText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          margin: padding,
          decoration: BoxDecoration(
            color: isDark
                ? Theme.of(context).colorScheme.primaryContainer
                : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 4),
                color: isDark
                    ? Colors.black.withValues(alpha: 0.15)
                    : const Color(0x21000000),
              ),
            ],
          ),
          child: child,
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: HaboColors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ] else if (helperText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              helperText!,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }
}
