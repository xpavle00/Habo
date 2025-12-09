import 'package:habo/model/habo_model.dart';
import 'habit_repository.dart';
import 'event_repository.dart';
import 'backup_repository.dart';
import 'category_repository.dart';
import 'sqlite_habit_repository.dart';
import 'sqlite_event_repository.dart';
import 'sqlite_backup_repository.dart';
import 'sqlite_category_repository.dart';

/// Factory for creating repository instances.
/// Provides centralized repository creation and dependency injection.
class RepositoryFactory {
  final HaboModel _haboModel;

  late final HabitRepository _habitRepository;
  late final EventRepository _eventRepository;
  late final BackupRepository _backupRepository;
  late final CategoryRepository _categoryRepository;

  RepositoryFactory(this._haboModel) {
    _habitRepository = SQLiteHabitRepository(_haboModel);
    _eventRepository = SQLiteEventRepository(_haboModel);
    _backupRepository = SQLiteBackupRepository(_haboModel);
    _categoryRepository = SQLiteCategoryRepository(_haboModel);
  }

  /// Gets the habit repository instance.
  HabitRepository get habitRepository => _habitRepository;

  /// Gets the event repository instance.
  EventRepository get eventRepository => _eventRepository;

  /// Gets the backup repository instance.
  BackupRepository get backupRepository => _backupRepository;

  /// Gets the category repository instance.
  CategoryRepository get categoryRepository => _categoryRepository;

  /// Disposes all repository instances.
  void dispose() {
    // Repositories don't need explicit disposal as they delegate to HaboModel
  }
}
