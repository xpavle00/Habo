// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m17(error) => "Fehler bei der Anmeldung mit Apple: ${error}";

  static String m1(authMethod) =>
      "Bitte authentifizieren, um mit ${authMethod} auf Habo zuzugreifen";

  static String m2(authMethod) =>
      "Bitte authentifiziere dich mit ${authMethod}, um auf deine Gewohnheiten zuzugreifen";

  static String m3(authMethod) => "Sichere App mit ${authMethod}";

  static String m4(title) => "Kategorie „${title}“ existiert bereits";

  static String m5(title) => "Kategorie „${title}“ erfolgreich erstellt";

  static String m6(title) => "Kategorie „${title}“ erfolgreich gelöscht";

  static String m7(title) => "Kategorie „${title}“ erfolgreich aktualisiert";

  static String m18(e) =>
      "Verbindung zum Server fehlgeschlagen. Überprüfe die URL, den Anon-Key und ob die Habo-Migration angewendet wurde.\n\nFehler: ${e}";

  static String m8(current, unit) => "Aktuell: ${current} ${unit}";

  static String m9(title) =>
      "Möchtest du „${title}” wirklich löschen?\n\nDadurch wird die Kategorie aus allen Gewohnheiten entfernt, die sie verwenden.";

  static String m19(error) => "Fehler: ${error}";

  static String m10(error) => "Löschen der Kategorie fehlgeschlagen: ${error}";

  static String m20(error) => "Erneutes Senden fehlgeschlagen: ${error}";

  static String m11(error) =>
      "Speichern der Kategorie fehlgeschlagen: ${error}";

  static String m21(count) => "${count} Gewohnheiten";

  static String m22(days, plural) =>
      "Zuletzt vor ${days} ${Intl.select(plural, {'s': 'Tagen', 'other': 'Tag'})} synchronisiert";

  static String m23(hours) => "Zuletzt vor ${hours} Std. synchronisiert";

  static String m24(minutes) => "Zuletzt vor ${minutes} Min. synchronisiert";

  static String m12(title) => "Keine Gewohnheiten in „${title}“";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m25(seconds) => "Erneut senden in ${seconds} s";

  static String m26(date) =>
      "Dadurch werden alle aktuellen Daten durch die Sicherung vom ${date} ersetzt.\n\nDiese Aktion kann nicht rückgängig gemacht werden.";

  static String m27(error) => "Wiederherstellung fehlgeschlagen: ${error}";

  static String m14(count) => "Ausgewählte Kategorien (${count})";

  static String m15(target, unit) => "Ziel: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Gerät', 'light': 'Hell', 'dark': 'Dunkel', 'oled': 'OLED  Schwarz', 'materialYou': 'Material You', 'other': 'Gerät'})}";

  static String m28(time) => "Heute um ${time}";

  static String m29(weekday, time) => "${weekday} um ${time}";

  static String m16(version) => "Version ${version}";

  static String m30(time) => "Gestern um ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Über"),
    "accountPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Kontopasswort erfolgreich geändert",
    ),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Verantwortlichkeitspartner",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Hinzufügen"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Kategorie hinzufügen"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Fortgeschrittene Gewohnheitsbildung",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Dieser Abschnitt hilft dir, deine Gewohnheiten mithilfe der Gewohnheit schleife besser zu definieren. Du solltest für jede Gewohnheit Signale, Routinen und Belohnungen definieren.",
    ),
    "all": MessageLookupByLibrary.simpleMessage("Alle"),
    "allCategories": MessageLookupByLibrary.simpleMessage("Alle Kategorien"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Alle Gewohnheiten werden durch Gewohnheiten aus der Sicherung ersetzt.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Erlauben"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Du hast bereits ein Konto? ",
    ),
    "anUnexpectedErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "Ein unerwarteter Fehler ist aufgetreten",
    ),
    "anUnexpectedErrorOccurredTryAgain": MessageLookupByLibrary.simpleMessage(
      "Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.",
    ),
    "anonKeyIsRequired": MessageLookupByLibrary.simpleMessage(
      "Anon-Key ist erforderlich",
    ),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "App-Benachrichtigungen",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungskanal für Anwendungsbenachrichtigungen",
    ),
    "appleSignInError": m17,
    "archive": MessageLookupByLibrary.simpleMessage("Archivieren"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage(
      "Gewohnheit archivieren",
    ),
    "archivedHabits": MessageLookupByLibrary.simpleMessage(
      "Archivierte Gewohnheiten",
    ),
    "at7AM": MessageLookupByLibrary.simpleMessage("Um 07:00"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authentifizieren"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Bitte authentifizieren, um auf Habo zuzugreifen",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Authentifizieren, um biometrische Sperre zu aktivieren",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage(
      "Authentifizierung läuft…",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Authentifizierungsfehler",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Authentifizierung erforderlich",
    ),
    "automaticCloudBackups": MessageLookupByLibrary.simpleMessage(
      "Automatische Cloud-Sicherungen",
    ),
    "backToSignIn": MessageLookupByLibrary.simpleMessage(
      "Zurück zur Anmeldung",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Sicherung"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Sicherung erfolgreich erstellt!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage(
      "Sicherung fehlgeschlagen!",
    ),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "FEHLER: Erstellen der Sicherung fehlgeschlagen.",
    ),
    "backupRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Sicherung erfolgreich wiederhergestellt!",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biometrisch"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Biometrische Authentifizierung erforderlich",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Biometrische Authentifizierung erfolgreich",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage(
      "Biometrische Sperre",
    ),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Biometrische Sperre deaktiviert",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Biometrische Sperre aktiviert",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "Biometrische Daten nicht erkannt, bitte erneut versuchen",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "­Biometrische Daten erforderlich",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage(
      "Boolesche Gewohnheit",
    ),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Bessere Gewohnheiten Entwickeln",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage(
      "Kaufe mir einen Kaffee",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "categories": MessageLookupByLibrary.simpleMessage("Kategorien"),
    "category": MessageLookupByLibrary.simpleMessage("Kategorie"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryName": MessageLookupByLibrary.simpleMessage("Kategoriename"),
    "categoryUpdatedSuccessfully": m7,
    "changeAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Kontopasswort ändern",
    ),
    "changeMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Master-Passwort ändern",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Passwort ändern"),
    "check": MessageLookupByLibrary.simpleMessage("Prüfen"),
    "checkEmailForPasswordReset": MessageLookupByLibrary.simpleMessage(
      "Sieh in deinem E-Mail-Postfach nach dem Link zum Zurücksetzen des Passworts.",
    ),
    "checkEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Sieh in deinem E-Mail-Postfach nach dem Link zum Zurücksetzen des Passworts.",
    ),
    "checkYourEmail": MessageLookupByLibrary.simpleMessage(
      "Sieh in deinem E-Mail-Postfach nach",
    ),
    "chooseBackupToRestore": MessageLookupByLibrary.simpleMessage(
      "Wähle eine Sicherung zum Wiederherstellen",
    ),
    "chooseStrongPassword": MessageLookupByLibrary.simpleMessage(
      "Wähle ein starkes Passwort für dein Konto.",
    ),
    "clickLinkInEmailToVerify": MessageLookupByLibrary.simpleMessage(
      "Klicke auf den Link in der E-Mail, um dein Konto zu bestätigen. Komm dann hierher zurück und tippe auf die Schaltfläche unten.",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Schließen"),
    "complete": MessageLookupByLibrary.simpleMessage("Vollständig"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Neues Passwort bestätigen",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Passwort bestätigen",
    ),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Herzlichen Glückwunsch! Deine Belohnung:",
    ),
    "connectedToCloud": MessageLookupByLibrary.simpleMessage(
      "Mit der Cloud verbunden",
    ),
    "connectedToCustomServer": MessageLookupByLibrary.simpleMessage(
      "Mit einem eigenen Server verbunden",
    ),
    "connectedToHaboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Mit Habo Cloud verbunden (Standard)",
    ),
    "continueWithApple": MessageLookupByLibrary.simpleMessage(
      "Mit Apple fortfahren",
    ),
    "continueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Mit Google fortfahren",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "couldNotConnectToServer": m18,
    "create": MessageLookupByLibrary.simpleMessage("Erstellen"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Konto erstellen"),
    "createAccountToBackupAndSync": MessageLookupByLibrary.simpleMessage(
      "Erstelle ein Konto zum Sichern und Synchronisieren.",
    ),
    "createCategory": MessageLookupByLibrary.simpleMessage(
      "Kategorie erstellen",
    ),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Erstelle deine erste Kategorie, um deine Gewohnheiten zu organisieren",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Gewohnheit erstellen"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Erstelle eine Gewohnheit und ordne sie dieser Kategorie zu",
    ),
    "createMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Master-Passwort erstellen",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Erstelle deine erste Gewohnheit.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Signal"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "ist der Auslöser, der deine Gewohnheit auslöst. Dies kann eine bestimmte Zeit, ein bestimmter Ort, ein bestimmtes Gefühl oder ein bestimmtes Ereignis sein.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Signal"),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "Aktuelles Passwort",
    ),
    "currentPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Aktuelles Passwort ist erforderlich",
    ),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Aktuelle Serie"),
    "customServer": MessageLookupByLibrary.simpleMessage("Eigener Server"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "dataBeingSynchronized": MessageLookupByLibrary.simpleMessage(
      "Deine Daten werden synchronisiert",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Datum"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Definiere deine Gewohnheiten",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Um deine Gewohnheiten besser einzuhalten, kannst du Folgendes festlegen:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage("Konto löschen"),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Diese Aktion ist endgültig und kann nicht rückgängig gemacht werden. Die folgenden Daten werden dauerhaft gelöscht:",
    ),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Kategorie löschen"),
    "deleteCategoryConfirmation": m9,
    "deleteCloudBackupsAndSyncData": MessageLookupByLibrary.simpleMessage(
      "Cloud-Sicherungen und Synchronisierungsdaten",
    ),
    "deleteEncryptionKeysAndProfile": MessageLookupByLibrary.simpleMessage(
      "Verschlüsselungsschlüssel und Profil",
    ),
    "deleteHabitsAndTrackingData": MessageLookupByLibrary.simpleMessage(
      "Alle deine Gewohnheiten und Verlaufsdaten",
    ),
    "deleteSubscriptionManagedSeparately": MessageLookupByLibrary.simpleMessage(
      "Abonnement (wird separat über den Store verwaltet)",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Dein Konto löschen",
    ),
    "deleteYourAccountAndLoginCredentials":
        MessageLookupByLibrary.simpleMessage(
          "Dein Konto und deine Anmeldedaten",
        ),
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Geräteanmeldedaten erforderlich",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "Geräte-PIN, Muster oder Passwort",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Haftungsausschluss"),
    "disconnectFromSelfHosted": MessageLookupByLibrary.simpleMessage(
      "Dadurch wird die Verbindung zu deinem selbst gehosteten Server getrennt und zum Standardserver Habo Cloud zurückgewechselt. Du musst dich erneut anmelden.",
    ),
    "do50PushUps": MessageLookupByLibrary.simpleMessage(
      "50 Liegestütze machen",
    ),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Vergiss nicht, deine Gewohnheiten zu überprüfen.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "10 \$ für wohltätige Zwecke spenden",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Fertig"),
    "dontHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Du hast noch kein Konto? ",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage(
      "Kategorie bearbeiten",
    ),
    "editHabit": MessageLookupByLibrary.simpleMessage("Gewohnheit bearbeiten"),
    "emailIsRequired": MessageLookupByLibrary.simpleMessage(
      "E-Mail ist erforderlich",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("E-Mail"),
    "emailPasswordAndAccount": MessageLookupByLibrary.simpleMessage(
      "E-Mail, Passwort und Konto",
    ),
    "emptyList": MessageLookupByLibrary.simpleMessage("Leere Liste"),
    "endToEndEncryption": MessageLookupByLibrary.simpleMessage(
      "Ende-zu-Ende-Verschlüsselung",
    ),
    "enterAmount": MessageLookupByLibrary.simpleMessage("­Betrag eingeben"),
    "enterCurrentPasswordAndChooseNew": MessageLookupByLibrary.simpleMessage(
      "Gib dein aktuelles Passwort ein und wähle ein neues.",
    ),
    "enterEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Gib deine E-Mail-Adresse ein und wir senden dir einen Link zum Zurücksetzen deines Passworts.",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Gib eine gültige E-Mail-Adresse ein",
    ),
    "enterValidUrl": MessageLookupByLibrary.simpleMessage(
      "Gib eine gültige URL ein (z. B. https://dein-projekt.supabase.co)",
    ),
    "enterYourPasswordToConfirm": MessageLookupByLibrary.simpleMessage(
      "Gib zur Bestätigung dein Passwort ein",
    ),
    "errorText": MessageLookupByLibrary.simpleMessage("Fehler"),
    "errorWithDescription": m19,
    "everythingIsSafe": MessageLookupByLibrary.simpleMessage(
      "Alles ist sicher",
    ),
    "exercise": MessageLookupByLibrary.simpleMessage("Übung"),
    "fail": MessageLookupByLibrary.simpleMessage("Fehlgeschlagen"),
    "failedToDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Konto konnte nicht gelöscht werden",
    ),
    "failedToDeleteCategory": m10,
    "failedToResend": m20,
    "failedToSaveCategory": m11,
    "failedToSendResetLink": MessageLookupByLibrary.simpleMessage(
      "Der Link zum Zurücksetzen konnte nicht gesendet werden. Bitte versuche es erneut.",
    ),
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Verstecke Gewohnheiten, die du nicht mehr verfolgst, ohne sie zu löschen",
    ),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Archivieren"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Organisiere Gewohnheiten mit Kategoriefiltern",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage(
      "Kategorien",
    ),
    "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
      "Öffne Habo direkt auf Bildschirmen wie Einstellungen oder erstellen",
    ),
    "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
      "URL-Schema (Deep Links)",
    ),
    "featureHomeWidgetsDesc": MessageLookupByLibrary.simpleMessage(
      "Hake eine Gewohnheit ab, sieh die heutige Liste oder das ganze Jahr einer Gewohnheit – direkt auf deinem Startbildschirm, auf iOS und Android. Wähle in den Einstellungen ein helles, dunkles oder Geräte-Widget-Thema.",
    ),
    "featureHomeWidgetsTitle": MessageLookupByLibrary.simpleMessage(
      "Neue Startbildschirm-Widgets",
    ),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "Sieh deinen Gewohnheitsfortschritt auf einen Blick auf deinem Startbildschirm (experimentell)",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Startbildschirm-Widget",
    ),
    "featureIosSoundMixingDesc": MessageLookupByLibrary.simpleMessage(
      "Habo-Töne unterbrechen deine Musik oder Podcasts nicht mehr",
    ),
    "featureIosSoundMixingTitle": MessageLookupByLibrary.simpleMessage(
      "Tonmischung korrigiert",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Sichern Sie die App mit Face ID / Touch ID / Biometrie",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage("Sperrfunktion"),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "Drücke lange auf die Gewohnheitsschaltflächen, um den Status schnell zu ändern",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage(
      "Abhaken durch langes Drücken",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Dynamische Farben, die zu deinem Geräte-Hintergrund passen",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Material You-Thema (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Verfolge Dinge wie Gläser Wasser oder gelesene Seiten",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Numerische Werte in Gewohnheiten",
    ),
    "featureOfflineModeDesc": MessageLookupByLibrary.simpleMessage(
      "Schalte Synchronisierung und alle Netzwerkverbindungen in den Einstellungen aus.",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Einstellbare Lautstärke",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Neue Sound-Engine",
    ),
    "featureYearGridDesc": MessageLookupByLibrary.simpleMessage(
      "Die Statistikkarte jeder Gewohnheit zeigt jetzt das ganze Jahr auf einen Blick.",
    ),
    "featureYearGridTitle": MessageLookupByLibrary.simpleMessage(
      "Jahresansicht in der Statistik",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 Min. Videospiele",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Datei nicht gefunden",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "Datei zu groß (max. 10 MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Fingerabdruck"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage(
      "Erster Tag der Woche",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Passwort vergessen?",
    ),
    "fromPreviousBackups": MessageLookupByLibrary.simpleMessage(
      "Aus früheren Sicherungen",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Los geht\'s"),
    "habit": MessageLookupByLibrary.simpleMessage("Gewohnheit"),
    "habitArchived": MessageLookupByLibrary.simpleMessage(
      "Gewohnheit archiviert",
    ),
    "habitContract": MessageLookupByLibrary.simpleMessage("Gewohnheitsvertrag"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Obwohl positive Verstärkung empfohlen wird, entscheiden sich manche Menschen für einen Gewohnheitsvertrag. Ein Gewohnheitsvertrag ermöglicht es dir, eine Sanktion festzulegen, die verhängt wird, wenn du deine Gewohnheit nicht einhältst. Außerdem kann ein Verantwortlichkeitspartner hinzugezogen werden, der dich bei der Überwachung deiner Ziele unterstützt.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage(
      "Gewohnheit gelöscht.",
    ),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Gewohnheitsschleife"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "Habit Loop ist ein psychologisches Modell, das den Prozess der Gewohnheitsbildung beschreibt. Es besteht aus drei Komponenten: Signal, Routine und Belohnung. Das Signal löst die Routine (gewohnheitsmäßige Handlung) aus, die dann durch die Belohnung verstärkt wird. Dadurch entsteht eine Schleife, die die Gewohnheit verfestigt und die Wiederholungswahrscheinlichkeit erhöht.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Gewohnheitsbenachrichtigungen",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungskanal für Gewohnheitsbenachrichtigungen",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "Der Titel der Gewohnheit darf nicht leer sein.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Gewohnheitstyp"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Gewohnheit wiederhergestellt",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Gewohnheiten:"),
    "habitsCount": m21,
    "habitsToday": MessageLookupByLibrary.simpleMessage("Gewohnheiten heute"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Habo Cloud (Standard)",
    ),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo benötigt die Erlaubnis, Benachrichtigungen zu senden, um richtig zu funktionieren.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Demnächst"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Habo Sync ist da! Synchronisiere und sichere deine Gewohnheiten auf all deinen Geräten mit Ende-zu-Ende-verschlüsselter Cloud-Synchronisierung.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Weitere Informationen unter habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Wenn du Habo unterstützen möchtest, kannst du:",
    ),
    "importantCannotBeRecovered": MessageLookupByLibrary.simpleMessage(
      "Wichtig: Kann nicht wiederhergestellt werden",
    ),
    "incorrectCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Aktuelles Passwort ist falsch",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Falsches Passwort",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Eingabe"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Ungültige Sicherungsdatei",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Iris"),
    "iveVerifiedMyEmail": MessageLookupByLibrary.simpleMessage(
      "Ich habe meine E-Mail-Adresse bestätigt",
    ),
    "keepHabitsSafeAndSynced": MessageLookupByLibrary.simpleMessage(
      "Halte deine Gewohnheiten sicher und auf all deinen Geräten synchron.",
    ),
    "lastSyncedDaysAgo": m22,
    "lastSyncedHoursAgo": m23,
    "lastSyncedJustNow": MessageLookupByLibrary.simpleMessage(
      "Gerade eben synchronisiert",
    ),
    "lastSyncedMinsAgo": m24,
    "logYourDays": MessageLookupByLibrary.simpleMessage("Tage protokollieren"),
    "manageSubscription": MessageLookupByLibrary.simpleMessage(
      "Abonnement verwalten",
    ),
    "masterPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Master-Passwort erfolgreich geändert",
    ),
    "masterPasswordDescriptionSetup": MessageLookupByLibrary.simpleMessage(
      "Dein Master-Passwort verschlüsselt alle deine Daten, bevor sie dein Gerät verlassen. Wähle etwas Starkes, das du dir gut merken kannst.",
    ),
    "masterPasswordDescriptionUnlock": MessageLookupByLibrary.simpleMessage(
      "Gib dein Master-Passwort ein, um deine Daten zu entschlüsseln und die Synchronisierung zu aktivieren.",
    ),
    "masterPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Master-Passwort",
    ),
    "masterPasswordWarning": MessageLookupByLibrary.simpleMessage(
      "Wir speichern dein Passwort nicht. Wenn du es vergisst, können deine Daten nicht wiederhergestellt werden. Schreib es dir auf und bewahre es sicher auf!",
    ),
    "minimum8Characters": MessageLookupByLibrary.simpleMessage(
      "Mindestens 8 Zeichen",
    ),
    "modify": MessageLookupByLibrary.simpleMessage("Ändern"),
    "month": MessageLookupByLibrary.simpleMessage("Monat"),
    "neverSynced": MessageLookupByLibrary.simpleMessage(
      "Noch nie synchronisiert",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
    "newPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Neues Passwort ist erforderlich",
    ),
    "newPasswordMustBeDifferent": MessageLookupByLibrary.simpleMessage(
      "Das neue Passwort muss sich vom aktuellen unterscheiden",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Weiter"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Keine archivierten Gewohnheiten",
    ),
    "noBackupsAvailable": MessageLookupByLibrary.simpleMessage(
      "Noch keine Sicherungen vorhanden.\nSicherungen werden bei der Synchronisierung automatisch erstellt.",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Noch keine Kategorien",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Es gibt keine Daten über Gewohnheiten.",
    ),
    "noHabitsInCategory": m12,
    "noPreviousPurchasesFound": MessageLookupByLibrary.simpleMessage(
      "Keine früheren Käufe gefunden.",
    ),
    "notActive": MessageLookupByLibrary.simpleMessage("Nicht aktiv"),
    "notConfigured": MessageLookupByLibrary.simpleMessage("Nicht eingerichtet"),
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage(
      "Nicht so erfolgreich",
    ),
    "note": MessageLookupByLibrary.simpleMessage("Hinweis"),
    "notificationTime": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungszeit",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Benachrichtigungen"),
    "numericHabit": MessageLookupByLibrary.simpleMessage(
      "Numerische Gewohnheit",
    ),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Numerische Gewohnheiten ermöglichen es dir, den Fortschritt im Laufe des Tages schrittweise zu verfolgen.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Beobachte deine Fortschritte",
    ),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "offlineMode": MessageLookupByLibrary.simpleMessage("Offline-Modus"),
    "offlineModeDescription": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung und alle Netzwerkverbindungen deaktivieren",
    ),
    "offlineModeRestartContent": MessageLookupByLibrary.simpleMessage(
      "Bitte schließe die App und öffne sie erneut, um den Offline-Modus anzuwenden.",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Oh nein! Deine Strafe:",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding": MessageLookupByLibrary.simpleMessage("Einarbeitung"),
    "oneTapCheck": MessageLookupByLibrary.simpleMessage(
      "Einmal tippen zum Abhaken",
    ),
    "or": MessageLookupByLibrary.simpleMessage("oder"),
    "orContinueWith": MessageLookupByLibrary.simpleMessage("oder weiter mit"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Teilwert"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Um Fortschritte in kleineren Schritten zu verfolgen",
    ),
    "passwordCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Das Passwort darf nicht leer sein",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Passwort ist erforderlich",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Passwort"),
    "passwordMinLengthError": MessageLookupByLibrary.simpleMessage(
      "Das Passwort muss mindestens 8 Zeichen lang sein",
    ),
    "passwordResetSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Dein Passwort wurde erfolgreich zurückgesetzt. Du kannst dich jetzt mit deinem neuen Passwort anmelden.",
    ),
    "passwordUpdated": MessageLookupByLibrary.simpleMessage(
      "Passwort aktualisiert!",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Die Passwörter stimmen nicht überein",
    ),
    "pauseSyncing": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung pausieren",
    ),
    "paused": MessageLookupByLibrary.simpleMessage("Pausiert"),
    "pausesSyncingAndBackup": MessageLookupByLibrary.simpleMessage(
      "Pausiert Synchronisierung und Sicherung",
    ),
    "permanentlyDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Konto dauerhaft löschen",
    ),
    "permanentlyDeleteYourAccountAndData": MessageLookupByLibrary.simpleMessage(
      "Konto und Daten dauerhaft löschen",
    ),
    "pleaseConfirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Bitte bestätige dein Passwort",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Bitte gebe einen Kategorietitel ein",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Bitte gib eine gültige E-Mail-Adresse ein",
    ),
    "pleaseSignInWithEmailAndPassword": MessageLookupByLibrary.simpleMessage(
      "Bitte melde dich mit deiner E-Mail-Adresse und deinem Passwort an.",
    ),
    "pleaseTypeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Bitte gib zur Bestätigung DELETE ein",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Datenschutzerklärung",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profil"),
    "progress": MessageLookupByLibrary.simpleMessage("Fortschritt"),
    "progressOf": m13,
    "purchasesRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Käufe erfolgreich wiederhergestellt!",
    ),
    "realTimeSyncAcrossDevices": MessageLookupByLibrary.simpleMessage(
      "Echtzeit-Synchronisierung zwischen Geräten",
    ),
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Bitte aktiviere deine Touch ID oder Face ID erneut",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Die Erinnerung an die Belohnung nach einer erfolgreichen Übung.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "Die Erinnerung an die Strafe nach einer erfolglosen Übung.",
    ),
    "resendInSeconds": m25,
    "resendVerificationEmail": MessageLookupByLibrary.simpleMessage(
      "Bestätigungs-E-Mail erneut senden",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Zurücksetzen"),
    "resetAction": MessageLookupByLibrary.simpleMessage("Zurücksetzen"),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Passwort zurücksetzen",
    ),
    "resetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Gib deine E-Mail-Adresse ein und wir senden dir einen Link zum Zurücksetzen deines Passworts.",
    ),
    "resetToHaboCloud": MessageLookupByLibrary.simpleMessage(
      "Auf Habo Cloud zurücksetzen",
    ),
    "resetToHaboCloudQuestion": MessageLookupByLibrary.simpleMessage(
      "Auf Habo Cloud zurücksetzen?",
    ),
    "restEasy": MessageLookupByLibrary.simpleMessage("Ganz entspannt"),
    "restEasyDesc": MessageLookupByLibrary.simpleMessage(
      "Wir sichern deinen gesamten Fortschrittsverlauf sicher in der Cloud. Völlige Sorgenfreiheit, ganz automatisch.",
    ),
    "restartRequired": MessageLookupByLibrary.simpleMessage(
      "Neustart erforderlich",
    ),
    "restartRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Bitte schließe die App und öffne sie erneut, um dich mit dem neuen Server zu verbinden.",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Wiederherstellen"),
    "restoreBackupConfirmation": m26,
    "restoreBackupQuestion": MessageLookupByLibrary.simpleMessage(
      "Sicherung wiederherstellen?",
    ),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Wiederherstellung erfolgreich abgeschlossen!",
    ),
    "restoreData": MessageLookupByLibrary.simpleMessage(
      "Daten wiederherstellen",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage(
      "Wiederherstellung fehlgeschlagen!",
    ),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "FEHLER: Wiederherstellen der Sicherung fehlgeschlagen.",
    ),
    "restoreFailedTryAgain": MessageLookupByLibrary.simpleMessage(
      "Wiederherstellung fehlgeschlagen. Bitte versuche es erneut.",
    ),
    "restoreFailedWithError": m27,
    "restorePurchases": MessageLookupByLibrary.simpleMessage(
      "Käufe wiederherstellen",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Belohnung"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "ist der Nutzen oder das positive Gefühl, das du nach der Durchführung der Routine verspürst. Es verstärkt die Gewohnheit.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Belohnung"),
    "routine": MessageLookupByLibrary.simpleMessage("Routine"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "ist die Aktion, die du als Reaktion auf das Signal ausführst. Dies ist die Gewohnheit selbst.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Routine"),
    "sanction": MessageLookupByLibrary.simpleMessage("Strafe"),
    "save": MessageLookupByLibrary.simpleMessage("Speichern"),
    "saveProgress": MessageLookupByLibrary.simpleMessage(
      "Fortschritt speichern",
    ),
    "seamlessContinuity": MessageLookupByLibrary.simpleMessage(
      "Nahtlose Kontinuität",
    ),
    "seamlessContinuityDesc": MessageLookupByLibrary.simpleMessage(
      "Deine Gewohnheiten, überall perfekt synchronisiert. Beginne auf dem Smartphone und hake nahtlos auf dem Tablet ab.",
    ),
    "searchIcons": MessageLookupByLibrary.simpleMessage("Suchen"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Kategorien auswählen",
    ),
    "selectIcon": MessageLookupByLibrary.simpleMessage("Symbol auswählen"),
    "selectedCategories": m14,
    "selfHostDescription": MessageLookupByLibrary.simpleMessage(
      "Hoste dein eigenes Supabase-Backend für vollen Synchronisierungszugriff ohne Abonnement. Eine Anleitung zur Einrichtung findest du im Self-Hosting-Leitfaden.",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage(
      "Link zum Zurücksetzen senden",
    ),
    "server": MessageLookupByLibrary.simpleMessage("Server"),
    "serverConfiguration": MessageLookupByLibrary.simpleMessage(
      "Serverkonfiguration",
    ),
    "setColors": MessageLookupByLibrary.simpleMessage("Farben festlegen"),
    "setNewPassword": MessageLookupByLibrary.simpleMessage(
      "Neues Passwort festlegen",
    ),
    "setPassword": MessageLookupByLibrary.simpleMessage("Passwort festlegen"),
    "setUpSyncToEnable": MessageLookupByLibrary.simpleMessage(
      "Richte zuerst die Synchronisierung ein",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Bitte richte die Geräteanmeldedaten in den Einstellungen ein",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Bitte richte die Entsperrung per Fingerabdruck oder Gesichtserkennung in den Geräteeinstellungen ein",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Bitte richte deine Touch ID oder Face ID in den Geräteeinstellungen ein",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage(
      "Kategorien anzeigen",
    ),
    "showMonthName": MessageLookupByLibrary.simpleMessage(
      "Monatsname anzeigen",
    ),
    "showReward": MessageLookupByLibrary.simpleMessage("Belohnung anzeigen"),
    "showSanction": MessageLookupByLibrary.simpleMessage("Strafe anzeigen"),
    "signIn": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "signInFailedPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Anmeldung fehlgeschlagen. Bitte versuche es erneut.",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Abmelden"),
    "signOutConfirmationContent": MessageLookupByLibrary.simpleMessage(
      "Du musst dein Master-Passwort erneut eingeben, um auf deine synchronisierten Daten zuzugreifen.",
    ),
    "signOutQuestion": MessageLookupByLibrary.simpleMessage("Abmelden?"),
    "signUp": MessageLookupByLibrary.simpleMessage("Registrieren"),
    "skip": MessageLookupByLibrary.simpleMessage("Überspringen"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Überspringen (hat keinen Einfluss auf Serien)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Schieberegler"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Klangeffekte"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Quellcode (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistiken"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Abonnieren"),
    "subscribeToEnableSync": MessageLookupByLibrary.simpleMessage(
      "Abonniere, um Habo Sync zu aktivieren",
    ),
    "subscriptionNeeded": MessageLookupByLibrary.simpleMessage(
      "Abonnement erforderlich",
    ),
    "successful": MessageLookupByLibrary.simpleMessage("Erfolgreich"),
    "syncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung & Sicherung",
    ),
    "syncAndBackupYourData": MessageLookupByLibrary.simpleMessage(
      "Synchronisiere und sichere deine Daten",
    ),
    "syncError": MessageLookupByLibrary.simpleMessage(
      "Synchronisierungsfehler",
    ),
    "syncNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung nicht verfügbar",
    ),
    "syncNow": MessageLookupByLibrary.simpleMessage("Jetzt synchronisieren"),
    "syncTitle": MessageLookupByLibrary.simpleMessage("Synchronisierung"),
    "syncingHero": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung läuft...",
    ),
    "syncingPaused": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung pausiert",
    ),
    "syncingPausedDesc": MessageLookupByLibrary.simpleMessage("Pausiert"),
    "syncingToCloud": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung mit der Cloud",
    ),
    "tapCheckLongPressMenu": MessageLookupByLibrary.simpleMessage(
      "Tippen zum Abhaken, lange drücken für Menü",
    ),
    "tapSyncNowToRetry": MessageLookupByLibrary.simpleMessage(
      "Tippe auf „Jetzt synchronisieren“, um es erneut zu versuchen",
    ),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Zielwert"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Bedingungen und Konditionen",
    ),
    "testConnectionAndSave": MessageLookupByLibrary.simpleMessage(
      "Verbindung testen & speichern",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Thema"),
    "themeSelect": m0,
    "thisChangesYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Dies ändert dein Anmeldepasswort für Habo.",
    ),
    "todayAt": m28,
    "topStreak": MessageLookupByLibrary.simpleMessage("Top-Serie"),
    "total": MessageLookupByLibrary.simpleMessage("Gesamt"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Berührungssensor"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Du kannst deinen Fortschritt über die Kalenderansicht in jeder Gewohnheit oder auf der Statistikseite verfolgen.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Zwei-Tage-Regel"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Mit der Zwei-Tage-Regel kannst du einen Tag auslassen und verlierst keine Serie, wenn der nächste Tag erfolgreich ist.",
    ),
    "typeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Zur Bestätigung DELETE eingeben",
    ),
    "unableToVerifyIdentity": MessageLookupByLibrary.simpleMessage(
      "Identität konnte nicht bestätigt werden",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Wiederherstellen"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Gewohnheit wiederherstellen",
    ),
    "unavailableWhileOffline": MessageLookupByLibrary.simpleMessage(
      "Offline nicht verfügbar",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Rückgängig"),
    "unexpectedErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es erneut.",
    ),
    "unit": MessageLookupByLibrary.simpleMessage("Einheit"),
    "unknown": MessageLookupByLibrary.simpleMessage("Unbekannt"),
    "unlockAndSync": MessageLookupByLibrary.simpleMessage(
      "Entsperren & synchronisieren",
    ),
    "unlockPasswordExplanation": MessageLookupByLibrary.simpleMessage(
      "Dies ist das Passwort, das du bei der ersten Einrichtung der Synchronisierung auf einem anderen Gerät erstellt hast.",
    ),
    "unlockSyncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Synchronisierung & Sicherung freischalten",
    ),
    "unlockYourData": MessageLookupByLibrary.simpleMessage(
      "Entsperre deine Daten",
    ),
    "updateYourEncryptionPassword": MessageLookupByLibrary.simpleMessage(
      "Verschlüsselungspasswort ändern",
    ),
    "updateYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Anmeldepasswort ändern",
    ),
    "urlIsRequired": MessageLookupByLibrary.simpleMessage(
      "URL ist erforderlich",
    ),
    "urlMustStartWithHttpOrHttps": MessageLookupByLibrary.simpleMessage(
      "Die URL muss mit https:// oder http:// beginnen",
    ),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Zwei-Tage-Regel verwenden",
    ),
    "verificationEmailResent": MessageLookupByLibrary.simpleMessage(
      "Bestätigungs-E-Mail erneut gesendet!",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Archivierte Gewohnheiten ansehen",
    ),
    "viewOrCancelYourPlan": MessageLookupByLibrary.simpleMessage(
      "Tarif ansehen oder kündigen",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Warnung"),
    "weSentVerificationLinkTo": MessageLookupByLibrary.simpleMessage(
      "Wir haben einen Bestätigungslink gesendet an",
    ),
    "week": MessageLookupByLibrary.simpleMessage("Woche"),
    "weekdayAt": m29,
    "welcomeBackStayConsistent": MessageLookupByLibrary.simpleMessage(
      "Willkommen zurück! Bleiben wir dran.",
    ),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Was ist Neu"),
    "whatsNewVersion": m16,
    "widgetChooseHabit": MessageLookupByLibrary.simpleMessage(
      "Gewohnheit auswählen",
    ),
    "widgetNoHabits": MessageLookupByLibrary.simpleMessage(
      "Füge eine Gewohnheit in Habo hinzu",
    ),
    "widgetTheme": MessageLookupByLibrary.simpleMessage("Widget-Thema"),
    "willSyncWhenConnected": MessageLookupByLibrary.simpleMessage(
      "Wird synchronisiert, sobald eine Verbindung besteht",
    ),
    "yesterdayAt": m30,
    "youAreOffline": MessageLookupByLibrary.simpleMessage("Du bist offline"),
    "yourCommentHere": MessageLookupByLibrary.simpleMessage("Deine Notiz hier"),
    "zeroKnowledgePrivacy": MessageLookupByLibrary.simpleMessage(
      "Zero-Knowledge-Datenschutz",
    ),
    "zeroKnowledgePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "Modernste Ende-zu-Ende-Verschlüsselung. Nur du besitzt den Hauptschlüssel – wir können deine persönlichen Daten niemals lesen oder darauf zugreifen.",
    ),
  };
}
