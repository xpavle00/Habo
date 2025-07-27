import 'dart:collection';

/// Abstract repository interface for habit event-related database operations.
/// This interface handles all CRUD operations for habit events (check, fail, skip, clear).
abstract class EventRepository {
  /// Inserts a new event for a habit.
  ///
  /// [habitId] The ID of the habit this event belongs to.
  /// [date] The date of the event.
  /// [event] The event data as [List] containing [DayType] and optional comment.
  /// Returns a [Future] that completes when the event is successfully inserted.
  Future<void> insertEvent(int habitId, DateTime date, List event);

  /// Deletes an event for a habit.
  ///
  /// [habitId] The ID of the habit this event belongs to.
  /// [date] The date of the event to be deleted.
  /// Returns a [Future] that completes when the event is successfully deleted.
  Future<void> deleteEvent(int habitId, DateTime date);

  /// Retrieves all events for a specific habit.
  ///
  /// [habitId] The ID of the habit whose events to retrieve.
  /// Returns a [Future] containing a [List] of events.
  Future<List<List>> getEventsForHabit(int habitId);

  /// Gets all events for a habit as a [SplayTreeMap] with DateTime keys.
  ///
  /// [habitId] The ID of the habit whose events to retrieve.
  /// Returns a [Future] containing a [SplayTreeMap] mapping dates to events.
  Future<SplayTreeMap<DateTime, List>> getEventsMapForHabit(int habitId);

  /// Deletes all events for a specific habit.
  ///
  /// [habitId] The ID of the habit whose events should be deleted.
  /// Returns a [Future] that completes when all events are deleted.
  Future<void> deleteAllEventsForHabit(int habitId);

  /// Inserts multiple events for a habit.
  ///
  /// [habitId] The ID of the habit these events belong to.
  /// [events] A [Map] of events with DateTime keys and event values.
  /// Returns a [Future] that completes when all events are inserted.
  Future<void> insertEventsForHabit(int habitId, Map<DateTime, List> events);

  /// Deletes all events from the database.
  ///
  /// This is primarily used for backup/restore operations.
  /// Returns a [Future] that completes when all events are deleted.
  Future<void> deleteAllEvents();
}
