// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sk locale. All the
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
  String get localeName => 'sk';

  static String m1(authMethod) =>
      "Prosím autentifikujte sa na prístup do Habo pomocou ${authMethod}";

  static String m2(authMethod) =>
      "Prosím autentifikujte sa pomocou ${authMethod} na prístup k vašim zvykom";

  static String m3(authMethod) => "Zabezpečiť aplikáciu pomocou ${authMethod}";

  static String m4(title) => "Kategória \"${title}\" už existuje";

  static String m5(title) => "Kategória \"${title}\" bola úspešne vytvorená";

  static String m6(title) => "Kategória \"${title}\" bola úspešne odstránená";

  static String m7(title) =>
      "Kategória \"${title}\" bola úspešne aktualizovaná";

  static String m8(current, unit) => "Aktuálne: ${current} ${unit}";

  static String m9(title) =>
      "Ste si istí, že chcete odstrániť \"${title}\"?\n\nToto odstráni kategóriu zo všetkých zvykov, ktoré ju používajú.";

  static String m10(error) => "Nepodarilo sa odstrániť kategóriu: ${error}";

  static String m11(error) => "Nepodarilo sa uložiť kategóriu: ${error}";

  static String m12(title) => "Žiadne zvyky v \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m14(count) => "Vybrané kategórie (${count})";

  static String m15(target, unit) => "Cieľ: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Zariadenie', 'light': 'Svetlá', 'dark': 'Tmavá', 'oled': 'OLED čierna', 'materialYou': 'Material You', 'other': 'Zariadenie'})}";

  static String m16(version) => "Verzia ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("O aplikácii"),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Partner dohľadu",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Pridať"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Pridať kategóriu"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Pokročilá tvorba zvykov",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Táto sekcia vám pomôže lepšie definovať vaše zvyky pomocou Cyklu zvyku. Mali by ste definovať signály, rutiny a odmeny pre každý zvyk.",
    ),
    "allCategories": MessageLookupByLibrary.simpleMessage("Všetky kategórie"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Všetky zvyky budú nahradené zálohovanými zvykmi.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Povoliť"),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Oznámenia aplikácie",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Kanál oznámení pre aplikáciu",
    ),
    "archive": MessageLookupByLibrary.simpleMessage("Archivovať"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Archivovať zvyk"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage("Archivované zvyky"),
    "at7AM": MessageLookupByLibrary.simpleMessage("O 7:00"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autentifikovať"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Prosím autentifikujte sa na prístup do Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Autentifikujte sa na povolenie biometrického zámku",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage("Autentifikácia…"),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Chyba autentifikácie",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Vyžaduje sa autentifikácia",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Záloha"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Záloha bola úspešne vytvorená!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage("Záloha zlyhala!"),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "CHYBA: Vytvorenie zálohy zlyhalo.",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biometrické"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Vyžaduje sa biometrická autentifikácia",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Biometrická autentifikácia úspešná",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage("Biometrický zámok"),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Biometrický zámok zakázaný",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Biometrický zámok povolený",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "Biometrické údaje neboli rozpoznané, skúste znova",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "Vyžadujú sa biometrické údaje",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage("Áno/nie zvyk"),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Budovanie lepších zvykov",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage("Kúpiť mi kávu"),
    "cancel": MessageLookupByLibrary.simpleMessage("Zrušiť"),
    "categories": MessageLookupByLibrary.simpleMessage("Kategórie"),
    "category": MessageLookupByLibrary.simpleMessage("Kategória"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryUpdatedSuccessfully": m7,
    "check": MessageLookupByLibrary.simpleMessage("Skontrolovať"),
    "close": MessageLookupByLibrary.simpleMessage("Zavrieť"),
    "complete": MessageLookupByLibrary.simpleMessage("Dokončiť"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Gratulujem! Vaša odmena:",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("Vytvoriť"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Vytvorte svoju prvú kategóriu na organizovanie zvykov",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Vytvoriť zvyk"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Vytvorte zvyk a priraďte ho k tejto kategórii",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Vytvorte svoj prvý zvyk.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Signál"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "je spúšťač, ktorý inicializuje váš zvyk. Môže to byť konkrétny čas, miesto, pocit alebo udalosť.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Signál"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Aktuálna séria"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "date": MessageLookupByLibrary.simpleMessage("Dátum"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Definujte svoje zvyky",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Aby ste sa lepšie držali svojich zvykov, môžete definovať:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Vymazať"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage(
      "Odstrániť kategóriu",
    ),
    "deleteCategoryConfirmation": m9,
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Vyžadujú sa prihlasovacie údaje zariadenia",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "PIN, vzor alebo heslo zariadenia",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Vylúčenie zodpovednosti",
    ),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Spraviť 50 klikov"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Nezabudnite skontrolovať svoje zvyky.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Prispejte 10\$ na charitu",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Hotovo"),
    "editCategory": MessageLookupByLibrary.simpleMessage("Upraviť kategóriu"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Upraviť zvyk"),
    "emptyList": MessageLookupByLibrary.simpleMessage("Prázdny zoznam"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Zadajte množstvo"),
    "exercise": MessageLookupByLibrary.simpleMessage("Cvičenie"),
    "fail": MessageLookupByLibrary.simpleMessage("Zlyhanie"),
    "failedToDeleteCategory": m10,
    "failedToSaveCategory": m11,
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Skryte zvyky, ktoré už nesledujete bez ich odstránenia",
    ),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Archív"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Organizujte zvyky pomocou filtrov kategórií",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage("Kategórie"),
    "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
      "Otvorte Habo priamo na obrazovky nastavenia alebo vytvoriť nový zvyk",
    ),
    "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
      "URL schéma (deep links)",
    ),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "Zobrazte svoj postup z domovskej obrazovky (experimentálne)",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Widget na domovskej obrazovke",
    ),
    "featureIosSoundMixingDesc": MessageLookupByLibrary.simpleMessage(
      "Zvuky Habo už neprerušujú vašu hudbu alebo podcasty",
    ),
    "featureIosSoundMixingTitle": MessageLookupByLibrary.simpleMessage(
      "Opravené mixovanie zvuku",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Zabezpečte aplikáciu pomocou Face ID / Touch ID / biometrických údajov",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage("Funkcia zámku"),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "Dlhým stlačením tlačidiel zvykov rýchlo zmeníte stav",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage(
      "Dlhé stlačenie na označenie",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Dynamické farby, ktoré sa prispôsobia vašej tapete",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Material You téma (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Sledujte počty ako poháre vody alebo prečítané stránky",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Číselné hodnoty vo zvykoch",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Nastaviteľná hlasitosť",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Nový zvukový engine",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 min. hrania videohier",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Súbor sa nenašiel"),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "Súbor je príliš veľký (max 10MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Odtlačok prsta"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage("Prvý deň týždňa"),
    "habit": MessageLookupByLibrary.simpleMessage("Zvyk"),
    "habitArchived": MessageLookupByLibrary.simpleMessage("Zvyk archivovaný"),
    "habitContract": MessageLookupByLibrary.simpleMessage("Zmluva o zvyku"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Hoci sa odporúča pozitívne posilnenie, niektorí ľudia môžu uprednostniť zmluvu o zvyku. Zmluva o zvyku vám umožňuje špecifikovať sankciu, ktorá bude uložená, ak zvyk nesplníte, a môže zahŕňať partnera, ktorý dohliada na vaše ciele.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage(
      "Zvyk bol odstránený.",
    ),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Cyklus zvyku"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "Cyklus zvyku je psychologický model popisujúci proces tvorby zvyku. Skladá sa z troch komponentov: Signál, Rutina a Odmena. Signál spustí Rutinu (zvykovú činnosť), ktorá je potom posilnená Odmenou, čím vytvára slučku, ktorá zvyk zabezpečí a pravdepodobne sa bude opakovať.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Oznámenia o zvykoch",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Kanál oznámení pre zvyky",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "Názov zvyku nemôže byť prázdny.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Typ zvyku"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Archivácia zvyku zrušená",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Zvyky:"),
    "habitsToday": MessageLookupByLibrary.simpleMessage("Dnešné zvyky"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo potrebuje povolenie na odosielanie oznámení na správne fungovanie.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Čoskoro"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Synchronizujte svoje zvyky na všetkých zariadeniach pomocou end-to-end šifrovanej cloudovej služby Habo.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Dozvedieť sa viac na habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Ak chcete podporiť Habo, môžete:",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Vstup"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Neplatný záložný súbor",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Dúhovka"),
    "logYourDays": MessageLookupByLibrary.simpleMessage(
      "Zaznamenávajte svoje dni",
    ),
    "modify": MessageLookupByLibrary.simpleMessage("Upraviť"),
    "month": MessageLookupByLibrary.simpleMessage("Mesiac"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Žiadne archivované zvyky",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Zatiaľ žiadne kategórie",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Nie sú žiadne údaje o zvykoch.",
    ),
    "noHabitsInCategory": m12,
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("Nie tak úspešný"),
    "note": MessageLookupByLibrary.simpleMessage("Poznámka"),
    "notificationTime": MessageLookupByLibrary.simpleMessage("Čas oznámenia"),
    "notifications": MessageLookupByLibrary.simpleMessage("Oznámenia"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Číselný zvyk"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Číselné zvyky vám umožňujú sledovať pokrok v prírastkoch počas dňa.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Sledujte svoj pokrok",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Ó nie! Vaša sankcia:",
    ),
    "onboarding": MessageLookupByLibrary.simpleMessage("Úvod"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Čiastočná hodnota"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Na sledovanie pokroku v menších prírastkoch",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Prosím zadajte názov kategórie",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Ochrana osobných údajov",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Pokrok"),
    "progressOf": m13,
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Prosím znovu povoľte Touch ID alebo Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Pripomenutie odmeny po úspešnej rutine.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "Pripomenutie sankcie po neúspešnej rutine.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Resetovať"),
    "restore": MessageLookupByLibrary.simpleMessage("Obnoviť"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Obnovenie bolo úspešne dokončené!",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage("Obnovenie zlyhalo!"),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "CHYBA: Obnovenie zálohy zlyhalo.",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Odmena"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "je výhoda alebo pozitívny pocit, ktorý zažívate po vykonaní rutiny. Posilňuje zvyk.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Odmena"),
    "routine": MessageLookupByLibrary.simpleMessage("Rutina"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "je činnosť, ktorú vykonávate ako reakciu na signál. Ide o samotný zvyk.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rutina"),
    "sanction": MessageLookupByLibrary.simpleMessage("Sankcia"),
    "save": MessageLookupByLibrary.simpleMessage("Uložiť"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Uložiť pokrok"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Vybrať kategórie",
    ),
    "selectedCategories": m14,
    "setColors": MessageLookupByLibrary.simpleMessage("Nastaviť farby"),
    "settings": MessageLookupByLibrary.simpleMessage("Nastavenia"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Prosím nastavte prihlasovacie údaje zariadenia v nastaveniach",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Prosím nastavte odtlačok prsta alebo odomknutie tvárou v nastaveniach zariadenia",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Prosím nastavte Touch ID alebo Face ID v nastaveniach zariadenia",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage(
      "Zobraziť kategórie",
    ),
    "showMonthName": MessageLookupByLibrary.simpleMessage(
      "Zobraziť názov mesiaca",
    ),
    "showReward": MessageLookupByLibrary.simpleMessage("Zobraziť odmenu"),
    "showSanction": MessageLookupByLibrary.simpleMessage("Zobraziť sankciu"),
    "skip": MessageLookupByLibrary.simpleMessage("Preskočiť"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Preskočiť (neovplyvňuje sériu)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Posuvník"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Zvukové efekty"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Zdrojový kód (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Štatistiky"),
    "successful": MessageLookupByLibrary.simpleMessage("Úspešný"),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Cieľová hodnota"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Obchodné podmienky",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Téma"),
    "themeSelect": m0,
    "topStreak": MessageLookupByLibrary.simpleMessage("Najdlhšia séria"),
    "total": MessageLookupByLibrary.simpleMessage("Celkom"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Dotknite sa senzora"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Môžete sledovať svoj pokrok prostredníctvom kalendárneho zobrazenia v každom zvyku alebo na stránke so štatistikami.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Skúsiť znova"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Pravidlo dvoch dní"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "S pravidlom dvoch dní môžete vynechať jeden deň a nestratiť sériu, ak je nasledujúci deň úspešný.",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Zrušiť archiváciu"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Zrušiť archiváciu zvyku",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Vrátiť späť"),
    "unit": MessageLookupByLibrary.simpleMessage("Jednotka"),
    "unknown": MessageLookupByLibrary.simpleMessage("Neznáme"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Použiť pravidlo dvoch dní",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Zobraziť archivované zvyky",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Varovanie"),
    "week": MessageLookupByLibrary.simpleMessage("Týždeň"),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Čo je nové"),
    "whatsNewVersion": m16,
    "yourCommentHere": MessageLookupByLibrary.simpleMessage(
      "Vaša poznámka sem",
    ),
  };
}
