

/// Abstract repository interface for backup and restore operations.
/// This interface handles all database backup functionality including
/// data export/import and database file operations.
abstract class BackupRepository {
  /// Exports all habits and their events as JSON data.
  ///
  /// Returns a [Future] containing a [Map] with the complete database state,
  /// including habits and their associated events.
  Future<Map<String, dynamic>> exportAllData();

  /// Imports data from a JSON backup into the database.
  ///
  /// [data] The JSON data containing habits and events to import.
  /// Returns a [Future] that completes when the import is successful.
  Future<void> importData(Map<String, dynamic> data);

  /// Gets the current database version.
  ///
  /// Returns a [Future] containing the current database version number.
  Future<int> getDatabaseVersion();

  /// Gets the path to the database file.
  ///
  /// Returns a [Future] containing the absolute path to the database file.
  Future<String> getDatabasePath();

  /// Closes the database connection.
  ///
  /// This is used for cleanup operations during backup/restore.
  /// Returns a [Future] that completes when the database is closed.
  Future<void> closeDatabase();

  /// Reopens the database connection.
  ///
  /// This is used after closing the database for backup/restore operations.
  /// Returns a [Future] that completes when the database is reopened.
  Future<void> reopenDatabase();

  /// Gets the total count of habits in the database.
  ///
  /// Returns a [Future] containing the total number of habits.
  Future<int> getHabitCount();

  /// Gets the total count of events in the database.
  ///
  /// Returns a [Future] containing the total number of events.
  Future<int> getEventCount();

  /// Validates the integrity of the database.
  ///
  /// Returns a [Future] containing a boolean indicating whether
  /// the database is in a valid state.
  Future<bool> validateDatabaseIntegrity();
}
