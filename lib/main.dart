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

class _HaboState extends State<Habo> {
  final _appStateManager = AppStateManager();
  final _settingsManager = SettingsManager();
  late HabitsManager _habitManager;
  late AppRouter _appRouter;
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _settingsManager.initialize();
    
    // Create a shared HaboModel instance
    final haboModel = HaboModel();
    
    // Initialize database first and wait for completion
    await haboModel.initDatabase();
    
    // Initialize service locator with the scaffold key and HaboModel
    ServiceLocator.instance.initialize(_scaffoldKey, haboModel, _settingsManager);
    
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
          statusBarBrightness: Brightness.light),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
          final useDynamicColors = settingsManager.getThemeString == Themes.materialYou;
          
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
            theme: (useDynamicColors && lightDynamic != null) ? ThemeData(
              colorScheme: lightDynamic,
            ) : settingsManager.getLight,
            darkTheme: (useDynamicColors && darkDynamic != null) ? ThemeData(
              colorScheme: darkDynamic,
            ) : settingsManager.getDark,
            routerDelegate: _appRouter,
            routeInformationParser: HaboRouteInformationParser(),
            backButtonDispatcher: RootBackButtonDispatcher(),
            builder: (context, child) {
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
