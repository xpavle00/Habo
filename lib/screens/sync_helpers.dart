import 'package:flutter/material.dart';
import 'package:habo/constants.dart';

/// Shared input decoration theme for the sync screen views.
InputDecorationTheme syncInputDecorationTheme(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return InputDecorationTheme(
    filled: true,
    fillColor: isDark
        ? Theme.of(context).colorScheme.primaryContainer
        : Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: HaboColors.primary, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}

final syncErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: HaboColors.red),
);

final syncFocusedErrorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: HaboColors.red, width: 2),
);
