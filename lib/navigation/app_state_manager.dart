import 'package:flutter/material.dart';
import 'package:habo/model/habit_data.dart';

class AppStateManager extends ChangeNotifier {
  bool _statistics = false;
  bool _settings = false;
  bool _onboarding = false;
  bool _whatsNew = false;
  bool _createHabit = false;
  HabitData? _editHabit;

  bool get getStatistics => _statistics;
  bool get getSettings => _settings;
  bool get getOnboarding => _onboarding;
  bool get getWhatsNew => _whatsNew;
  bool get getCreateHabit => _createHabit;
  HabitData? get getEditHabit => _editHabit;

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

  void goWhatsNew(bool state) {
    _whatsNew = state;
    notifyListeners();
  }

  void goCreateHabit(bool state) {
    _createHabit = state;
    notifyListeners();
  }

  void goEditHabit(HabitData? habitData) {
    _editHabit = habitData;
    notifyListeners();
  }
}
