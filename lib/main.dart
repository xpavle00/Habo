import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/notifications.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/widgets/biometric_auth_wrapper.dart';

import 'package:habo/settings/settings_manager.dart';
import 'package:habo/navigation/app_router.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/navigation/route_information_parser.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:habo/generated/l10n.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:habo/constants.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    windowManager.setMinimumSize(const Size(320, 320));
    windowManager.setMaximumSize(Size.infinite);
  }
  addLicenses();
  runApp(
    const Habo(),
  );
}

class Habo extends StatefulWidget {
  const Habo({super.key});

  @override
  State<Habo> createState() => _HaboState();
}

class _HaboState extends State<Habo> with WidgetsBindingObserver {
  final _appStateManager = AppStateManager();
  final _settingsManager = SettingsManager();
  late HabitsManager _habitManager;
  late AppRouter _appRouter;
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  bool _isInitialized = false;
  Timer? _dayChangeTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
    _startDayChangeTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopDayChangeTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startDayChangeTimer();
      if (_isInitialized) {
        _habitManager.checkDayChange();
      }
    } else if (state == AppLifecycleState.paused) {
      _stopDayChangeTimer();
    }
  }

  void _startDayChangeTimer() {
    _stopDayChangeTimer();

    final now = DateTime.now();
    // Calculate time until next midnight
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final timeUntilMidnight = nextMidnight.difference(now);

    // Add a small buffer (e.g., 1 second) to ensure we are past midnight
    final duration = timeUntilMidnight + const Duration(seconds: 1);

    _dayChangeTimer = Timer(duration, () {
      if (_isInitialized) {
        _habitManager.checkDayChange();
        // Schedule next midnight timer
        _startDayChangeTimer();
      }
    });
  }

  void _stopDayChangeTimer() {
    _dayChangeTimer?.cancel();
    _dayChangeTimer = null;
  }

  Future<void> _initializeApp() async {
    await _settingsManager.initialize();

    // Create a shared HaboModel instance
    final haboModel = HaboModel();

    // Initialize database first and wait for completion
    await haboModel.initDatabase();

    // Initialize service locator with the scaffold key and HaboModel
    ServiceLocator.instance
        .initialize(_scaffoldKey, haboModel, _settingsManager);

    // Create HabitsManager with repositories and services from ServiceLocator
    final repositoryFactory = ServiceLocator.instance.repositoryFactory;
    final habitsManager = HabitsManager(
      habitRepository: repositoryFactory.habitRepository,
      eventRepository: repositoryFactory.eventRepository,
      categoryRepository: repositoryFactory.categoryRepository,
      backupService: ServiceLocator.instance.backupService,
      notificationService: ServiceLocator.instance.notificationService,
      uiFeedbackService: ServiceLocator.instance.uiFeedbackService,
    );
    await habitsManager.initialize();

    if (platformSupportsNotifications()) {
      initializeNotifications();
    }

    GoogleFonts.config.allowRuntimeFetching = false;

    // Create AppRouter with initialized habitsManager
    final appRouter = AppRouter(
      navigatorKey: _navigatorKey,
      appStateManager: _appStateManager,
      settingsManager: _settingsManager,
      habitsManager: habitsManager,
    );

    setState(() {
      _habitManager = habitsManager;
      _appRouter = appRouter;
      _isInitialized = true;
    });

    // Update home widget on app launch to ensure correct state
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (context.mounted) {
        await habitsManager.updateHomeWidget(context);
      }
    });

    // Remove native splash once app is fully initialized
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      // Keep native splash while initializing
      return const SizedBox.shrink();
    }

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        // Handle Android 15 edge-to-edge
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // Enable edge-to-edge mode explicitly for consistency
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _appStateManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _settingsManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _habitManager,
        ),
      ],
      child: Consumer<SettingsManager>(builder: (context, settingsManager, _) {
        return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          // Only use dynamic colors if Material You theme is selected
          final useDynamicColors =
              settingsManager.getThemeString == Themes.materialYou;

          return MaterialApp.router(
            title: 'Habo',
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            scaffoldMessengerKey: _scaffoldKey,
            theme: (useDynamicColors && lightDynamic != null)
                ? ThemeData(
                    colorScheme: lightDynamic,
                  )
                : settingsManager.getLight,
            darkTheme: (useDynamicColors && darkDynamic != null)
                ? ThemeData(
                    colorScheme: darkDynamic,
                  )
                : settingsManager.getDark,
            routerDelegate: _appRouter,
            routeInformationParser: HaboRouteInformationParser(),
            backButtonDispatcher: RootBackButtonDispatcher(),
            builder: (context, child) {
              // Set context for automatic widget updates
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _habitManager.setWidgetContext(context);
              });
              return BiometricAuthWrapper(child: child!);
            },
          );
        });
      }),
    );
  }
}

void addLicenses() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}
