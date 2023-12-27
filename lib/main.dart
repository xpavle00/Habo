import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habo/habits/habits_manager.dart';
import 'package:habo/navigation/app_router.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/notifications.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  addLicenses();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const Habo(),
  );
}

class Habo extends StatefulWidget {
  const Habo({Key? key}) : super(key: key);

  @override
  State<Habo> createState() => _HaboState();
}

class _HaboState extends State<Habo> {
  final _appStateManager = AppStateManager();
  final _settingsManager = SettingsManager();
  final _habitManager = HabitsManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    if (Platform.isLinux || Platform.isMacOS) {
      // setWindowTitle('Habo!!!');
      setWindowMinSize(const Size(320, 320));
      setWindowMaxSize(Size.infinite);
    }
    _settingsManager.initialize();
    _habitManager.initialize();
    if (platformSupportsNotifications()) {
      initializeNotifications();
    }
    GoogleFonts.config.allowRuntimeFetching = false;
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      settingsManager: _settingsManager,
      habitsManager: _habitManager,
    );
    init();
    super.initState();
  }

  Future<void> init() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final ref = FirebaseFirestore.instance.collection('habits').doc(androidInfo.id);
    ref.get().then((value){
      if (!value.exists) {
        ref.set({
          'docId': androidInfo.id,
          'id': Timestamp.now().seconds,
          'position': 0,
          'title': 'Fajr at Masjid',
          'twoDayRule': false,
          'cue': '',
          'routine': '',
          'reward': '',
          'showReward': false,
          'advanced': false,
          'notification': false,
          'notTime': '12:0',
          'events': null,
          'sanction': '',
          'showSanction': false,
          'accountant': '',
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      child: Consumer<SettingsManager>(builder: (context, counter, _) {
        return MaterialApp(
          title: 'Habo',
          scaffoldMessengerKey:
              Provider.of<HabitsManager>(context).getScaffoldKey,
          theme: Provider.of<SettingsManager>(context).getLight,
          darkTheme: Provider.of<SettingsManager>(context).getDark,
          home: Router(
            routerDelegate: _appRouter,
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        );
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
