import 'package:habo/habits/habit.dart';

/// Result class for backup operations
/// 
/// Provides a structured way to handle backup/restore results
/// with success/failure states and optional error messages.
class BackupResult {
  final bool success;
  final List<Habit>? habits;
  final String? errorMessage;
  
  BackupResult({
    required this.success, 
    this.habits, 
    this.errorMessage
  });
  
  /// Factory constructor for successful backup operations
  factory BackupResult.success(List<Habit> habits) {
    return BackupResult(success: true, habits: habits);
  }
  
  /// Factory constructor for failed backup operations
  factory BackupResult.failure(String errorMessage) {
    return BackupResult(success: false, errorMessage: errorMessage);
  }
  
  /// Factory constructor for user cancellation (silent failure)
  factory BackupResult.cancelled() {
    return BackupResult(success: false, errorMessage: null);
  }
  
  /// Check if the operation was cancelled by the user
  bool get wasCancelled => !success && errorMessage == null;
  
  @override
  String toString() {
    if (success) {
      return 'BackupResult.success(${habits?.length} habits)';
    } else if (wasCancelled) {
      return 'BackupResult.cancelled()';
    } else {
      return 'BackupResult.failure($errorMessage)';
    }
  }
}
