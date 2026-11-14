import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/generated/l10n.dart';
import 'package:habo/model/habo_model.dart';
import 'package:habo/screens/sync_login_view.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    ServiceLocator.instance.reset();
    ServiceLocator.instance.initialize(
      scaffoldKey: GlobalKey<ScaffoldMessengerState>(),
      haboModel: HaboModel(),
      settingsManager: SettingsManager(),
    );
  });

  tearDown(() => ServiceLocator.instance.reset());

  Future<void> pumpLoginView(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en')],
        home: Scaffold(body: SyncLoginView()),
      ),
    );
    await tester.pumpAndSettle();
  }

  List<Iterable<String>?> fieldHints(WidgetTester tester) {
    return tester
        .widgetList<TextField>(find.byType(TextField))
        .map((field) => field.autofillHints)
        .toList();
  }

  group('SyncLoginView autofill', () {
    testWidgets('form fields are inside an AutofillGroup', (tester) async {
      await pumpLoginView(tester);

      expect(
        find.ancestor(
          of: find.byType(TextField).first,
          matching: find.byType(AutofillGroup),
        ),
        findsOneWidget,
      );
    });

    testWidgets('sign-in uses username and password hints', (tester) async {
      await pumpLoginView(tester);

      final hints = fieldHints(tester);
      expect(hints, hasLength(2));
      expect(hints[0], [AutofillHints.username, AutofillHints.email]);
      expect(hints[1], [AutofillHints.password]);
    });

    testWidgets('sign-up uses new-credential hints on all three fields', (
      tester,
    ) async {
      await pumpLoginView(tester);

      final toggle = find.text(S.current.signUp);
      await tester.ensureVisible(toggle);
      await tester.tap(toggle);
      await tester.pumpAndSettle();

      final hints = fieldHints(tester);
      expect(hints, hasLength(3));
      expect(hints[0], [AutofillHints.newUsername, AutofillHints.email]);
      expect(hints[1], [AutofillHints.newPassword]);
      expect(hints[2], [AutofillHints.newPassword]);
    });
  });
}
