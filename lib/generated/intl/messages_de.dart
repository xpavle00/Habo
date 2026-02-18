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

  static String m1(authMethod) =>
      "Bitte authentifizieren, um mit ${authMethod} auf Habo zuzugreifen";

  static String m2(authMethod) =>
      "Bitte authentifiziere dich mit ${authMethod}, um auf deine Gewohnheiten zuzugreifen";

  static String m3(authMethod) => "Sichere App mit ${authMethod}";

  static String m4(title) => "Kategorie „${title}“ existiert bereits";

  static String m5(title) => "Kategorie „${title}“ erfolgreich erstellt";

  static String m6(title) => "Kategorie „${title}“ erfolgreich gelöscht";

  static String m7(title) => "Kategorie „${title}“ erfolgreich aktualisiert";

  static String m8(current, unit) => "Aktuell: ${current} ${unit}";

  static String m9(title) =>
      "Möchtest du „${title}” wirklich löschen?\n\nDadurch wird die Kategorie aus allen Gewohnheiten entfernt, die sie verwenden.";

  static String m10(error) => "Löschen der Kategorie fehlgeschlagen: ${error}";

  static String m11(error) =>
      "Speichern der Kategorie fehlgeschlagen: ${error}";

  static String m12(title) => "Keine Gewohnheiten in „${title}“";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m14(count) => "Ausgewählte Kategorien (${count})";

  static String m15(target, unit) => "Ziel: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Gerät', 'light': 'Hell', 'dark': 'Dunkel', 'oled': 'OLED  Schwarz', 'materialYou': 'Material You', 'other': 'Gerät'})}";

  static String m16(version) => "Version ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Über"),
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
    "allCategories": MessageLookupByLibrary.simpleMessage("Alle Kategorien"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Alle Gewohnheiten werden durch Gewohnheiten aus der Sicherung ersetzt.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Erlauben"),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "App-Benachrichtigungen",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungskanal für Anwendungsbenachrichtigungen",
    ),
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
    "categoryUpdatedSuccessfully": m7,
    "check": MessageLookupByLibrary.simpleMessage("Prüfen"),
    "close": MessageLookupByLibrary.simpleMessage("Schließen"),
    "complete": MessageLookupByLibrary.simpleMessage("Vollständig"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Herzlichen Glückwunsch! Deine Belohnung:",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("Erstellen"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Erstelle deine erste Kategorie, um deine Gewohnheiten zu organisieren",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Gewohnheit erstellen"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Erstelle eine Gewohnheit und ordne sie dieser Kategorie zu",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Erstelle deine erste Gewohnheit.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Signal"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "ist der Auslöser, der deine Gewohnheit auslöst. Dies kann eine bestimmte Zeit, ein bestimmter Ort, ein bestimmtes Gefühl oder ein bestimmtes Ereignis sein.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Signal"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Aktuelle Serie"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "date": MessageLookupByLibrary.simpleMessage("Datum"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Definiere deine Gewohnheiten",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Um deine Gewohnheiten besser einzuhalten, kannst du Folgendes festlegen:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Kategorie löschen"),
    "deleteCategoryConfirmation": m9,
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Geräteanmeldedaten erforderlich",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "Geräte-PIN, Muster oder Passwort",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Haftungsausschluss"),
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
    "editCategory": MessageLookupByLibrary.simpleMessage(
      "Kategorie bearbeiten",
    ),
    "editHabit": MessageLookupByLibrary.simpleMessage("Gewohnheit bearbeiten"),
    "emptyList": MessageLookupByLibrary.simpleMessage("Leere Liste"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("­Betrag eingeben"),
    "exercise": MessageLookupByLibrary.simpleMessage("Übung"),
    "fail": MessageLookupByLibrary.simpleMessage("Fehlgeschlagen"),
    "failedToDeleteCategory": m10,
    "failedToSaveCategory": m11,
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
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Sichern Sie die App mit Face ID / Touch ID / Biometrie",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage("Sperrfunktion"),
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
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Einstellbare Lautstärke",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Neue Sound-Engine",
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
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo benötigt die Erlaubnis, Benachrichtigungen zu senden, um richtig zu funktionieren.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Demnächst"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Synchronisiere deine Gewohnheiten auf allen deinen Geräten mit Habo\'s End-to-End-verschlüsseltem Cloud-Dienst.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Weitere Informationen unter habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Wenn du Habo unterstützen möchtest, kannst du:",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Eingabe"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Ungültige Sicherungsdatei",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Iris"),
    "logYourDays": MessageLookupByLibrary.simpleMessage("Tage protokollieren"),
    "modify": MessageLookupByLibrary.simpleMessage("Ändern"),
    "month": MessageLookupByLibrary.simpleMessage("Monat"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Keine archivierten Gewohnheiten",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Noch keine Kategorien",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Es gibt keine Daten über Gewohnheiten.",
    ),
    "noHabitsInCategory": m12,
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
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Oh nein! Deine Strafe:",
    ),
    "onboarding": MessageLookupByLibrary.simpleMessage("Einarbeitung"),
    "or": MessageLookupByLibrary.simpleMessage("oder"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Teilwert"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Um Fortschritte in kleineren Schritten zu verfolgen",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Bitte gebe einen Kategorietitel ein",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Datenschutzerklärung",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Fortschritt"),
    "progressOf": m13,
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Bitte aktiviere deine Touch ID oder Face ID erneut",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Die Erinnerung an die Belohnung nach einer erfolgreichen Übung.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "Die Erinnerung an die Strafe nach einer erfolglosen Übung.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Zurücksetzen"),
    "restore": MessageLookupByLibrary.simpleMessage("Wiederherstellen"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Wiederherstellung erfolgreich abgeschlossen!",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage(
      "Wiederherstellung fehlgeschlagen!",
    ),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "FEHLER: Wiederherstellen der Sicherung fehlgeschlagen.",
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
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Kategorien auswählen",
    ),
    "selectedCategories": m14,
    "setColors": MessageLookupByLibrary.simpleMessage("Farben festlegen"),
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
    "skip": MessageLookupByLibrary.simpleMessage("Überspringen"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Überspringen (hat keinen Einfluss auf Serien)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Schieberegler"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Klangeffekte"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Quellcode (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistiken"),
    "successful": MessageLookupByLibrary.simpleMessage("Erfolgreich"),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Zielwert"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Bedingungen und Konditionen",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Thema"),
    "themeSelect": m0,
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
    "unarchive": MessageLookupByLibrary.simpleMessage("Wiederherstellen"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Gewohnheit wiederherstellen",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Rückgängig"),
    "unit": MessageLookupByLibrary.simpleMessage("Einheit"),
    "unknown": MessageLookupByLibrary.simpleMessage("Unbekannt"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Zwei-Tage-Regel verwenden",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Archivierte Gewohnheiten ansehen",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Warnung"),
    "week": MessageLookupByLibrary.simpleMessage("Woche"),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Was ist Neu"),
    "whatsNewVersion": m16,
    "yourCommentHere": MessageLookupByLibrary.simpleMessage("Deine Notiz hier"),
  };
}
