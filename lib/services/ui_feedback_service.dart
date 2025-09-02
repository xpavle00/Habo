import 'package:flutter/material.dart';
import 'package:habo/constants.dart';

/// Service responsible for providing user interface feedback
/// 
/// Centralizes SnackBar management and provides consistent
/// styling for success, error, and warning messages.
class UIFeedbackService {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey;
  
  UIFeedbackService(this._scaffoldKey);
  
  /// Shows a success message with green styling
  void showSuccess(String message) {
    _showSnackBar(message, HaboColors.primary);
  }
  
  /// Shows an error message with red styling
  void showError(String message) {
    _showSnackBar(message, Colors.red);
  }
  
  /// Shows a warning message with orange styling
  void showWarning(String message) {
    _showSnackBar(message, Colors.orange);
  }
  
  /// Hides the currently displayed message
  void hideCurrentMessage() {
    _scaffoldKey.currentState?.hideCurrentSnackBar();
  }
  
  /// Shows a message with an action button
  void showMessageWithAction({
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    Color backgroundColor = Colors.grey,
  }) {
    _scaffoldKey.currentState?.hideCurrentSnackBar();
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: actionLabel,
          textColor: Colors.white,
          onPressed: onActionPressed,
        ),
      ),
    );
  }
  
  /// Private method to show a standardized SnackBar
  void _showSnackBar(String message, Color backgroundColor) {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
