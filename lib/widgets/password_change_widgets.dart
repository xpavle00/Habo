import 'package:flutter/material.dart';
import 'package:habo/constants.dart';
import 'package:habo/widgets/primary_button.dart';

/// A styled password text field used by both Change Master Password
/// and Change Account Password screens.
class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final VoidCallback? onErrorClear;
  final String? helperText;
  final int? maxLength;

  const PasswordFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.errorText,
    required this.obscureText,
    required this.onToggleVisibility,
    this.onErrorClear,
    this.helperText,
    this.maxLength = 128,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            maxLength: maxLength,
            decoration: InputDecoration(
              counterText: '',
              labelText: label,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: onToggleVisibility,
                tooltip: obscureText ? 'Show password' : 'Hide password',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: errorText != null
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: HaboColors.red),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
              focusedBorder: errorText != null
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: HaboColors.red,
                        width: 2,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: HaboColors.primary,
                        width: 2,
                      ),
                    ),
              filled: true,
              fillColor: Colors.transparent,
            ),
            onChanged: (_) {
              if (errorText != null && onErrorClear != null) {
                onErrorClear!();
              }
            },
          ),
        ),
        if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(
              helperText!,
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(color: HaboColors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

/// Green-glow CTA button used on password change screens.
class PrimaryCTAButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const PrimaryCTAButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: onPressed,
      width: double.infinity,
      child: child,
    );
  }
}

/// Shared input decoration theme for password change screens.
InputDecorationTheme passwordChangeInputDecorationTheme(BuildContext context) {
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
