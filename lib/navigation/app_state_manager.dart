import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habo/model/habit_data.dart';

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _statistics = false;
  bool _settings = false;
  bool _onboarding = false;
  bool _createHabit = false;
  HabitData? _editHabit;

  bool get isInitialized => _initialized;
  bool get getStatistics => _statistics;
  bool get getSettings => _settings;
  bool get getOnboarding => _onboarding;
  bool get getCreateHabit => _createHabit;
  HabitData? get getEditHabit => _editHabit;

  void initializeApp() {
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  void goStatistics(bool state) {
    _statistics = state;
    notifyListeners();
  }

  void goSettings(bool state) {
    _settings = state;
    notifyListeners();
  }

  void goOnboarding(bool state) {
    _onboarding = state;
    notifyListeners();
  }

  void goCreateHabit(bool state) {
    _createHabit = state;
    notifyListeners();
  }

  void goEditHabit(HabitData? state) {
    _editHabit = state;
    notifyListeners();
  }
}
