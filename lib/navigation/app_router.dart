import 'package:flutter/material.dart';
import 'package:habo/habits/edit_habit_screen.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/habits/habits_screen.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/navigation/routes.dart';
import 'package:habo/navigation/route_information_parser.dart';
import 'package:habo/onboarding/onboarding_screen.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:habo/settings/settings_screen.dart';
import 'package:habo/splash_screen.dart';
import 'package:habo/statistics/statistics_screen.dart';
import 'package:habo/whats_new/whats_new_screen.dart';

class AppRouter extends RouterDelegate<HaboRouteConfiguration>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<HaboRouteConfiguration> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final SettingsManager settingsManager;
  final HabitsManager habitsManager;

  AppRouter(
      {required this.navigatorKey,
      required this.appStateManager,
      required this.settingsManager,
      required this.habitsManager}) {
    appStateManager.addListener(notifyListeners);
    settingsManager.addListener(notifyListeners);
    habitsManager.addListener(notifyListeners);
    settingsManager.getSeenOnboarding;
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    settingsManager.removeListener(notifyListeners);
    habitsManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onDidRemovePage: _handleDidRemovePage,
      pages: [
        if (allInitialized()) HabitsScreen.page(),
        if (appStateManager.getStatistics) StatisticsScreen.page(),
        if (appStateManager.getSettings) SettingsScreen.page(),
        if (appStateManager.getWhatsNew || _shouldShowWhatsNew())
          WhatsNewScreen.page(),
        if (appStateManager.getOnboarding || !settingsManager.getSeenOnboarding)
          OnboardingScreen.page(),
        if (appStateManager.getCreateHabit) EditHabitScreen.page(null),
        if (appStateManager.getEditHabit != null)
          EditHabitScreen.page(appStateManager.getEditHabit!),
        if (!allInitialized()) SplashScreen.page(),
      ],
    );
  }

  bool allInitialized() {
    return settingsManager.isInitialized && habitsManager.isInitialized;
  }

  void _handleDidRemovePage(Page<dynamic> page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (page.name == Routes.statisticsPath) {
        appStateManager.goStatistics(false);
      }

      if (page.name == Routes.settingsPath) {
        appStateManager.goSettings(false);
      }

      if (page.name == Routes.onboardingPath) {
        appStateManager.goOnboarding(false);
      }

      if (page.name == Routes.whatsNewPath) {
        appStateManager.goWhatsNew(false);
        final current = settingsManager.getCurrentAppVersion;
        if (current.isNotEmpty) {
          settingsManager.setLastWhatsNewVersion = current;
        }
      }

      if (page.name == Routes.createHabitPath) {
        appStateManager.goCreateHabit(false);
      }

      if (page.name == Routes.editHabitPath) {
        appStateManager.goEditHabit(null);
      }
    });
  }

  @override
  Future<void> setNewRoutePath(HaboRouteConfiguration configuration) async {
    // Handle deep link navigation
    _handleDeepLink(configuration.path);
  }

  @override
  HaboRouteConfiguration get currentConfiguration {
    // Return current route configuration based on app state
    if (appStateManager.getStatistics) {
      return const HaboRouteConfiguration(path: '/statistics');
    }
    if (appStateManager.getSettings) {
      return const HaboRouteConfiguration(path: '/settings');
    }
    if (appStateManager.getCreateHabit) {
      return const HaboRouteConfiguration(path: '/create');
    }
    if (appStateManager.getEditHabit != null) {
      return const HaboRouteConfiguration(path: '/edit');
    }
    if (appStateManager.getWhatsNew) {
      return const HaboRouteConfiguration(path: '/whatsnew');
    }
    if (appStateManager.getOnboarding) {
      return const HaboRouteConfiguration(path: '/onboarding');
    }
    return const HaboRouteConfiguration(path: '/');
  }

  /// Handle deep link navigation by updating app state
  void _handleDeepLink(String path) {
    final normalizedPath = path.toLowerCase();

    // Wait for app to be initialized before navigating
    if (!allInitialized()) {
      // Retry after a short delay if not initialized
      Future.delayed(const Duration(milliseconds: 500), () {
        if (allInitialized()) {
          _handleDeepLink(path);
        }
      });
      return;
    }

    // Defer state updates to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Reset all navigation states first
      appStateManager.goStatistics(false);
      appStateManager.goSettings(false);
      appStateManager.goCreateHabit(false);
      appStateManager.goOnboarding(false);
      appStateManager.goWhatsNew(false);
      appStateManager.goEditHabit(null);

      // Navigate based on the URL path
      switch (normalizedPath) {
        case '/statistics':
          appStateManager.goStatistics(true);
          break;
        case '/settings':
          appStateManager.goSettings(true);
          break;
        case '/create':
        case '/createhabit':
        case '/new':
          appStateManager.goCreateHabit(true);
          break;
        case '/whatsnew':
          appStateManager.goWhatsNew(true);
          break;
        case '/':
        case '/main':
        case '/habits':
        default:
          // Default to main habits screen - no action needed as it's the default
          break;
      }
    });
  }

  bool _shouldShowWhatsNew() {
    // Only show for users who have completed onboarding.
    if (!settingsManager.getSeenOnboarding) return false;
    final current = settingsManager.getCurrentAppVersion;
    if (current.isEmpty) return false;
    final last = settingsManager.getLastWhatsNewVersion;
    return current != last;
  }
}
