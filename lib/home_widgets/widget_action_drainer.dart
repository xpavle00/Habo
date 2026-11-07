import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/home_widgets/widget_action.dart';
import 'package:habo/home_widgets/widget_store.dart';

/// Applies taps queued by the native widgets to the app's data.
///
/// Reads `widget_pending_actions` (owned by native code), applies every
/// action newer than `widget_applied_seq` in seq order through
/// [HabitsManager.applyWidgetAction], then advances `widget_applied_seq`.
/// It never writes the pending list: native code prunes it.
class WidgetActionDrainer {
  WidgetActionDrainer(this._store, this._habits);

  final WidgetStore _store;
  final HabitsManager _habits;

  /// Returns the number of actions applied to a known habit.
  Future<int> drain() async {
    final raw = await _store.getString(WidgetKeys.pendingActions);
    if (raw == null || raw.isEmpty) return 0;

    final List<dynamic> entries;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return 0;
      entries = decoded;
    } on FormatException catch (e) {
      debugPrint('Widget actions: unreadable pending list: $e');
      return 0;
    }

    final appliedSeq = await _store.getInt(WidgetKeys.appliedSeq) ?? 0;
    var maxSeq = appliedSeq;
    final actions = <WidgetAction>[];
    for (final entry in entries) {
      if (entry is! Map) continue;
      final seq = entry['seq'];
      if (seq is int && seq > maxSeq) maxSeq = seq;
      try {
        final action = WidgetAction.fromJson(entry.cast<String, dynamic>());
        if (action.seq > appliedSeq) actions.add(action);
      } on FormatException catch (e) {
        debugPrint('Widget actions: skipping entry: $e');
      }
    }
    actions.sort((a, b) => a.seq.compareTo(b.seq));

    var applied = 0;
    for (final action in actions) {
      if (_habits.applyWidgetAction(action)) applied++;
    }

    if (maxSeq > appliedSeq) {
      await _store.setInt(WidgetKeys.appliedSeq, maxSeq);
    }
    return applied;
  }
}
