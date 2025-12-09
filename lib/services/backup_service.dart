import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:habo/habits/habit.dart';
import 'package:habo/model/backup.dart';
import 'package:habo/services/backup_result.dart';
import 'package:habo/services/ui_feedback_service.dart';
import 'package:habo/repositories/backup_repository.dart';
import 'package:habo/generated/l10n.dart';
import 'package:intl/intl.dart';

/// Service responsible for handling backup and restore operations
///
/// Extracts backup functionality from HabitsManager to provide
/// a focused, testable service for backup operations.
/// Now uses BackupRepository for database operations.
class BackupService {
  final UIFeedbackService _uiFeedbackService;
  final BackupRepository _backupRepository;

  BackupService(this._uiFeedbackService, this._backupRepository);

  /// Public getter for backupRepository
  BackupRepository get backupRepository => _backupRepository;

  /// Creates a backup using data from the database via BackupRepository
  ///
  /// Returns true if backup was successfully created and saved by user,
  /// false if user cancelled or an error occurred.
  Future<bool> createDatabaseBackup() async {
    try {
      // Get all data from database via repository
      final backupData = await _backupRepository.exportAllData();

      // Write FULL backup structure to temporary file
      final file = await Backup.writeBackup(backupData);
      final timestamp =
          DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
      final fileName = 'habo_backup_$timestamp.json';

      bool? userSaved = false;

      if (Platform.isAndroid || Platform.isIOS) {
        final params = SaveFileDialogParams(
          sourceFilePath: file.path,
          fileName: fileName,
          mimeTypesFilter: ['application/json'],
        );
        final savedPath = await FlutterFileDialog.saveFile(params: params);
        userSaved = savedPath != null;
      } else {
        final outputFile = await FilePicker.platform.saveFile(
          dialogTitle: '',
          type: FileType.custom,
          allowedExtensions: ['json'],
          fileName: fileName,
        );
        if (outputFile != null) {
          await file.copy(outputFile);
          userSaved = true;
        } else {
          // User cancelled - silently return false, no snackbar
          return false;
        }
      }

      if (userSaved == true) {
        _uiFeedbackService.showSuccess(
          S.current.backupCreatedSuccessfully,
        );
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error creating database backup: $e');
      _uiFeedbackService.showError(
        '${S.current.backupFailed}: ${e.toString()}',
      );
      return false;
    }
  }

  /// Creates a backup of the provided habits
  ///
  /// Returns true if backup was successfully created and saved by user,
  /// false if user cancelled or an error occurred.
  Future<bool> createBackup(List<Habit> habits) async {
    try {
      final file = await Backup.writeBackup(habits);
      final timestamp =
          DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
      final fileName = 'habo_backup_$timestamp.json';

      bool? userSaved = false;

      if (Platform.isAndroid || Platform.isIOS) {
        final params = SaveFileDialogParams(
          sourceFilePath: file.path,
          fileName: fileName,
          mimeTypesFilter: ['application/json'],
        );
        final savedPath = await FlutterFileDialog.saveFile(params: params);
        userSaved = savedPath != null;
      } else {
        final outputFile = await FilePicker.platform.saveFile(
          dialogTitle: '',
          type: FileType.custom,
          allowedExtensions: ['json'],
          fileName: fileName,
        );
        if (outputFile != null) {
          await file.copy(outputFile);
          userSaved = true;
        } else {
          // User cancelled - silently return false, no snackbar
          return false;
        }
      }

      // Show success message if user saved the file
      if (userSaved == true) {
        _uiFeedbackService.showSuccess(
          S.current.backupCreatedSuccessfully,
        );
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Error creating backup: $e');
      _uiFeedbackService.showError(
        '${S.current.backupFailed}: ${e.toString()}',
      );
      return false;
    }
  }

  /// Loads habits from a backup file selected by the user
  ///
  /// Returns BackupResult with success status and habits data,
  /// or failure information if the operation failed.
  Future<BackupResult> loadBackup() async {
    try {
      final String? filePath = await _selectBackupFile();

      // User cancelled file picker - silently return cancelled
      if (filePath == null) {
        return BackupResult.cancelled();
      }

      // Validate file exists and is readable
      final validationResult = await _validateBackupFile(filePath);
      if (!validationResult.success) {
        _uiFeedbackService.showError(validationResult.errorMessage!);
        return validationResult;
      }

      final json = await Backup.readBackup(filePath);

      // Validate and parse JSON structure
      final parseResult = _parseBackupJson(json);
      if (!parseResult.success) {
        _uiFeedbackService.showError(
          '${S.current.invalidBackupFile}: ${parseResult.errorMessage}',
        );
        return parseResult;
      }

      // Success - show success message and return habits
      _uiFeedbackService.showSuccess(
        S.current.restoreCompletedSuccessfully,
      );
      return parseResult;
    } catch (e) {
      debugPrint('Error loading backup: $e');
      final errorMessage = '${S.current.restoreFailed}: ${e.toString()}';
      _uiFeedbackService.showError(errorMessage);
      return BackupResult.failure(errorMessage);
    }
  }

  /// Selects a backup file using platform-appropriate file picker
  /// Returns file path or null if user cancelled
  Future<String?> _selectBackupFile() async {
    if (Platform.isAndroid || Platform.isIOS) {
      const params = OpenFileDialogParams(
        fileExtensionsFilter: ['json'],
        mimeTypesFilter: ['application/json'],
      );
      return await FlutterFileDialog.pickFile(params: params);
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
        withReadStream: Platform.isLinux,
      );
      return result?.files.first.path;
    }
  }

  /// Validates that the backup file exists and meets size requirements
  /// Returns BackupResult with validation status
  Future<BackupResult> _validateBackupFile(String filePath) async {
    final file = File(filePath);

    // Check if file exists
    if (!await file.exists()) {
      return BackupResult.failure(S.current.fileNotFound);
    }

    // Check file size (max 10MB)
    final fileStat = await file.stat();
    if (fileStat.size > 10 * 1024 * 1024) {
      return BackupResult.failure(S.current.fileTooLarge);
    }

    return BackupResult.success([]);
  }

  /// Parses and validates JSON backup structure
  /// Returns BackupResult with parsed habits or error message
  BackupResult _parseBackupJson(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is! List) {
        return BackupResult.failure(
            'Invalid backup format: expected a list of habits');
      }

      // Validate each habit has required fields
      for (var habitJson in decoded) {
        if (habitJson is! Map<String, dynamic>) {
          return BackupResult.failure('Invalid habit format: expected object');
        }

        // Check for essential fields directly in the habit object
        final requiredFields = ['id', 'title', 'position', 'events'];
        for (var field in requiredFields) {
          if (!habitJson.containsKey(field)) {
            return BackupResult.failure(
                'Invalid backup: missing required field "$field"');
          }
        }
      }

      // Parse habits from JSON
      List<Habit> habits = [];
      for (var element in decoded) {
        habits.add(Habit.fromJson(element));
      }

      return BackupResult.success(habits);
    } catch (e) {
      return BackupResult.failure('JSON parsing error: ${e.toString()}');
    }
  }

  /// Restores database from a backup file selected by the user.
  /// Supports both legacy (List of habits) and full (Map) backup formats.
  Future<bool> restoreFromBackupFile() async {
    try {
      final String? filePath = await _selectBackupFile();
      if (filePath == null) {
        return false; // user cancelled silently
      }

      final validationResult = await _validateBackupFile(filePath);
      if (!validationResult.success) {
        _uiFeedbackService.showError(validationResult.errorMessage!);
        return false;
      }

      final jsonStr = await Backup.readBackup(filePath);
      dynamic decoded;
      try {
        decoded = jsonDecode(jsonStr);
      } catch (e) {
        _uiFeedbackService.showError('JSON parsing error: ${e.toString()}');
        return false;
      }

      // Normalize into repository-compatible structure
      Map<String, dynamic> backupData;
      if (decoded is List) {
        // Legacy format: list of habits only
        backupData = {
          'habits': decoded,
          'events': <String, dynamic>{},
          'categories': <dynamic>[],
          'habit_categories': <dynamic>[],
          'metadata': {
            'imported_from': 'legacy_list',
            'import_timestamp': DateTime.now().toIso8601String(),
          },
        };
      } else if (decoded is Map<String, dynamic>) {
        backupData = decoded;
      } else {
        _uiFeedbackService.showError('Invalid backup format');
        return false;
      }

      await _backupRepository.importData(backupData);

      _uiFeedbackService.showSuccess(
        S.current.restoreCompletedSuccessfully,
      );
      return true;
    } catch (e) {
      debugPrint('Error restoring from backup file: $e');
      _uiFeedbackService.showError(
        '${S.current.restoreFailed}: ${e.toString()}',
      );
      return false;
    }
  }

  /// Restores habits to database using BackupRepository
  ///
  /// Returns true if restore was successful, false otherwise.
  Future<bool> restoreToDatabase(List<Habit> habits) async {
    try {
      // Prepare backup data for import
      final backupData = {
        'habits': habits.map((h) => h.toJson()).toList(),
        'events': <String, dynamic>{},
        'version': await _backupRepository.getDatabaseVersion(),
      };

      // Import data to database via repository
      await _backupRepository.importData(backupData);

      _uiFeedbackService.showSuccess(
        S.current.restoreCompletedSuccessfully,
      );
      return true;
    } catch (e) {
      debugPrint('Error restoring to database: $e');
      _uiFeedbackService.showError(
        '${S.current.restoreFailed}: ${e.toString()}',
      );
      return false;
    }
  }

  /// Gets database statistics for backup information
  Future<Map<String, int>> getDatabaseStats() async {
    try {
      final habitCount = await _backupRepository.getHabitCount();
      final eventCount = await _backupRepository.getEventCount();

      return {
        'habits': habitCount,
        'events': eventCount,
      };
    } catch (e) {
      debugPrint('Error getting database stats: $e');
      return {
        'habits': 0,
        'events': 0,
      };
    }
  }
}
