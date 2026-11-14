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

  static String m17(error) => "Chyba prihlásenia cez Apple: ${error}";

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

  static String m18(e) =>
      "K serveru sa nepodarilo pripojiť. Overte adresu URL, kľúč anon a či bola použitá migrácia Habo.\n\nChyba: ${e}";

  static String m8(current, unit) => "Aktuálne: ${current} ${unit}";

  static String m9(title) =>
      "Ste si istí, že chcete odstrániť \"${title}\"?\n\nToto odstráni kategóriu zo všetkých zvykov, ktoré ju používajú.";

  static String m19(error) => "Chyba: ${error}";

  static String m10(error) => "Nepodarilo sa odstrániť kategóriu: ${error}";

  static String m20(error) => "Opätovné odoslanie zlyhalo: ${error}";

  static String m11(error) => "Nepodarilo sa uložiť kategóriu: ${error}";

  static String m21(count) => "Počet zvykov: ${count}";

  static String m22(days, plural) =>
      "Posledná synchronizácia pred ${days} ${Intl.select(plural, {'s': 'dňami', 'other': 'dňom'})}";

  static String m23(hours) => "Posledná synchronizácia pred ${hours} h";

  static String m24(minutes) => "Posledná synchronizácia pred ${minutes} min";

  static String m12(title) => "Žiadne zvyky v \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m25(seconds) => "Znova odoslať o ${seconds} s";

  static String m26(date) =>
      "Všetky aktuálne údaje budú nahradené zálohou z ${date}.\n\nTúto akciu nie je možné vrátiť späť.";

  static String m27(error) => "Obnovenie zlyhalo: ${error}";

  static String m14(count) => "Vybrané kategórie (${count})";

  static String m15(target, unit) => "Cieľ: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Zariadenie', 'light': 'Svetlá', 'dark': 'Tmavá', 'oled': 'OLED čierna', 'materialYou': 'Material You', 'other': 'Zariadenie'})}";

  static String m28(time) => "Dnes o ${time}";

  static String m29(weekday, time) => "${weekday} o ${time}";

  static String m16(version) => "Verzia ${version}";

  static String m30(time) => "Včera o ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("O aplikácii"),
    "accountPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Heslo účtu bolo úspešne zmenené",
    ),
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
    "all": MessageLookupByLibrary.simpleMessage("Všetko"),
    "allCategories": MessageLookupByLibrary.simpleMessage("Všetky kategórie"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Všetky zvyky budú nahradené zálohovanými zvykmi.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Povoliť"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Už máte účet? ",
    ),
    "anUnexpectedErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "Vyskytla sa neočakávaná chyba",
    ),
    "anUnexpectedErrorOccurredTryAgain": MessageLookupByLibrary.simpleMessage(
      "Vyskytla sa neočakávaná chyba. Skúste to znova.",
    ),
    "anonKeyIsRequired": MessageLookupByLibrary.simpleMessage(
      "Kľúč anon je povinný",
    ),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Oznámenia aplikácie",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Kanál oznámení pre aplikáciu",
    ),
    "appleSignInError": m17,
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
    "automaticCloudBackups": MessageLookupByLibrary.simpleMessage(
      "Automatické cloudové zálohy",
    ),
    "backToSignIn": MessageLookupByLibrary.simpleMessage("Späť na prihlásenie"),
    "backup": MessageLookupByLibrary.simpleMessage("Záloha"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Záloha bola úspešne vytvorená!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage("Záloha zlyhala!"),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "CHYBA: Vytvorenie zálohy zlyhalo.",
    ),
    "backupRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Záloha bola úspešne obnovená!",
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
    "categoryName": MessageLookupByLibrary.simpleMessage("Názov kategórie"),
    "categoryUpdatedSuccessfully": m7,
    "changeAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Zmeniť heslo účtu",
    ),
    "changeMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Zmeniť hlavné heslo",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Zmeniť heslo"),
    "check": MessageLookupByLibrary.simpleMessage("Skontrolovať"),
    "checkEmailForPasswordReset": MessageLookupByLibrary.simpleMessage(
      "Odkaz na obnovenie hesla nájdete vo svojom e-maile.",
    ),
    "checkEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Odkaz na obnovenie hesla nájdete vo svojom e-maile.",
    ),
    "checkYourEmail": MessageLookupByLibrary.simpleMessage(
      "Skontrolujte svoj e-mail",
    ),
    "chooseBackupToRestore": MessageLookupByLibrary.simpleMessage(
      "Vyberte zálohu, ktorú chcete obnoviť",
    ),
    "chooseStrongPassword": MessageLookupByLibrary.simpleMessage(
      "Zvoľte pre svoj účet silné heslo.",
    ),
    "clickLinkInEmailToVerify": MessageLookupByLibrary.simpleMessage(
      "Kliknutím na odkaz v e-maile overte svoj účet. Potom sa sem vráťte a ťuknite na tlačidlo nižšie.",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Zavrieť"),
    "complete": MessageLookupByLibrary.simpleMessage("Dokončiť"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Potvrdenie nového hesla",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Potvrdenie hesla",
    ),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Gratulujem! Vaša odmena:",
    ),
    "connectedToCloud": MessageLookupByLibrary.simpleMessage(
      "Pripojené ku cloudu",
    ),
    "connectedToCustomServer": MessageLookupByLibrary.simpleMessage(
      "Pripojené k vlastnému serveru",
    ),
    "connectedToHaboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Pripojené k Habo Cloud (predvolené)",
    ),
    "continueWithApple": MessageLookupByLibrary.simpleMessage(
      "Pokračovať cez Apple",
    ),
    "continueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Pokračovať cez Google",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "couldNotConnectToServer": m18,
    "create": MessageLookupByLibrary.simpleMessage("Vytvoriť"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Vytvoriť účet"),
    "createAccountToBackupAndSync": MessageLookupByLibrary.simpleMessage(
      "Vytvorte si účet na zálohovanie a synchronizáciu.",
    ),
    "createCategory": MessageLookupByLibrary.simpleMessage(
      "Vytvoriť kategóriu",
    ),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Vytvorte svoju prvú kategóriu na organizovanie zvykov",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Vytvoriť zvyk"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Vytvorte zvyk a priraďte ho k tejto kategórii",
    ),
    "createMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Vytvorte hlavné heslo",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Vytvorte svoj prvý zvyk.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Signál"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "je spúšťač, ktorý inicializuje váš zvyk. Môže to byť konkrétny čas, miesto, pocit alebo udalosť.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Signál"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Aktuálne heslo"),
    "currentPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Aktuálne heslo je povinné",
    ),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Aktuálna séria"),
    "customServer": MessageLookupByLibrary.simpleMessage("Vlastný server"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "dataBeingSynchronized": MessageLookupByLibrary.simpleMessage(
      "Vaše údaje sa synchronizujú",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Dátum"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Definujte svoje zvyky",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Aby ste sa lepšie držali svojich zvykov, môžete definovať:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Vymazať"),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Odstrániť účet",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Táto akcia je trvalá a nie je možné ju vrátiť späť. Nasledujúce údaje budú natrvalo odstránené:",
    ),
    "deleteCategory": MessageLookupByLibrary.simpleMessage(
      "Odstrániť kategóriu",
    ),
    "deleteCategoryConfirmation": m9,
    "deleteCloudBackupsAndSyncData": MessageLookupByLibrary.simpleMessage(
      "Cloudové zálohy a synchronizované údaje",
    ),
    "deleteEncryptionKeysAndProfile": MessageLookupByLibrary.simpleMessage(
      "Šifrovacie kľúče a profil",
    ),
    "deleteHabitsAndTrackingData": MessageLookupByLibrary.simpleMessage(
      "Všetky vaše zvyky a údaje o ich plnení",
    ),
    "deleteSubscriptionManagedSeparately": MessageLookupByLibrary.simpleMessage(
      "Predplatné (spravuje sa samostatne v obchode)",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Odstránenie účtu",
    ),
    "deleteYourAccountAndLoginCredentials":
        MessageLookupByLibrary.simpleMessage("Váš účet a prihlasovacie údaje"),
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Vyžadujú sa prihlasovacie údaje zariadenia",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "PIN, vzor alebo heslo zariadenia",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Vylúčenie zodpovednosti",
    ),
    "disconnectFromSelfHosted": MessageLookupByLibrary.simpleMessage(
      "Týmto sa odpojíte od vlastného servera a prepnete späť na predvolený server Habo Cloud. Bude potrebné sa znova prihlásiť.",
    ),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Spraviť 50 klikov"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Nezabudnite skontrolovať svoje zvyky.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Prispejte 10\$ na charitu",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Hotovo"),
    "dontHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Ešte nemáte účet? ",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("Upraviť kategóriu"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Upraviť zvyk"),
    "emailIsRequired": MessageLookupByLibrary.simpleMessage(
      "E-mail je povinný",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emailPasswordAndAccount": MessageLookupByLibrary.simpleMessage(
      "E-mail, heslo a účet",
    ),
    "emptyList": MessageLookupByLibrary.simpleMessage("Prázdny zoznam"),
    "endToEndEncryption": MessageLookupByLibrary.simpleMessage(
      "End-to-end šifrovanie",
    ),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Zadajte množstvo"),
    "enterCurrentPasswordAndChooseNew": MessageLookupByLibrary.simpleMessage(
      "Zadajte aktuálne heslo a zvoľte nové.",
    ),
    "enterEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Zadajte svoju e-mailovú adresu a pošleme vám odkaz na obnovenie hesla.",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Zadajte platný e-mail",
    ),
    "enterValidUrl": MessageLookupByLibrary.simpleMessage(
      "Zadajte platnú adresu URL (napr. https://vas-projekt.supabase.co)",
    ),
    "enterYourPasswordToConfirm": MessageLookupByLibrary.simpleMessage(
      "Potvrďte zadaním svojho hesla",
    ),
    "errorText": MessageLookupByLibrary.simpleMessage("Chyba"),
    "errorWithDescription": m19,
    "everythingIsSafe": MessageLookupByLibrary.simpleMessage(
      "Všetko je v bezpečí",
    ),
    "exercise": MessageLookupByLibrary.simpleMessage("Cvičenie"),
    "fail": MessageLookupByLibrary.simpleMessage("Zlyhanie"),
    "failedToDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Účet sa nepodarilo odstrániť",
    ),
    "failedToDeleteCategory": m10,
    "failedToResend": m20,
    "failedToSaveCategory": m11,
    "failedToSendResetLink": MessageLookupByLibrary.simpleMessage(
      "Odkaz na obnovenie sa nepodarilo odoslať. Skúste to znova.",
    ),
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
    "featureHomescreenWidgetDarkModeDesc": MessageLookupByLibrary.simpleMessage(
      "Widget pre Android teraz podporuje svetlé aj tmavé pozadie.",
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
    "featureIosWidgetsDesc": MessageLookupByLibrary.simpleMessage(
      "Označte zvyk ako splnený, pozrite si dnešný pokrok alebo celý rok zvyku priamo z domovskej obrazovky. Pridajte jeden widget pre každý zvyk.",
    ),
    "featureIosWidgetsTitle": MessageLookupByLibrary.simpleMessage(
      "Nové widgety na domovskej obrazovke (iOS)",
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
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Zabudli ste heslo?",
    ),
    "fromPreviousBackups": MessageLookupByLibrary.simpleMessage(
      "Z predchádzajúcich záloh",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Začať"),
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
    "habitsCount": m21,
    "habitsToday": MessageLookupByLibrary.simpleMessage("Dnešné zvyky"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Habo Cloud (predvolené)",
    ),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo potrebuje povolenie na odosielanie oznámení na správne fungovanie.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Čoskoro"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Habo Sync je tu! Synchronizujte a zálohujte svoje zvyky na všetkých zariadeniach pomocou end-to-end šifrovanej cloudovej synchronizácie.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Dozvedieť sa viac na habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Ak chcete podporiť Habo, môžete:",
    ),
    "importantCannotBeRecovered": MessageLookupByLibrary.simpleMessage(
      "Dôležité: heslo sa nedá obnoviť",
    ),
    "incorrectCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Nesprávne aktuálne heslo",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Nesprávne heslo",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Vstup"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Neplatný záložný súbor",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Dúhovka"),
    "iveVerifiedMyEmail": MessageLookupByLibrary.simpleMessage(
      "E-mail mám overený",
    ),
    "keepHabitsSafeAndSynced": MessageLookupByLibrary.simpleMessage(
      "Majte svoje zvyky v bezpečí a synchronizované na všetkých zariadeniach.",
    ),
    "lastSyncedDaysAgo": m22,
    "lastSyncedHoursAgo": m23,
    "lastSyncedJustNow": MessageLookupByLibrary.simpleMessage(
      "Práve synchronizované",
    ),
    "lastSyncedMinsAgo": m24,
    "logYourDays": MessageLookupByLibrary.simpleMessage(
      "Zaznamenávajte svoje dni",
    ),
    "manageSubscription": MessageLookupByLibrary.simpleMessage(
      "Spravovať predplatné",
    ),
    "masterPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Hlavné heslo bolo úspešne zmenené",
    ),
    "masterPasswordDescriptionSetup": MessageLookupByLibrary.simpleMessage(
      "Hlavné heslo zašifruje všetky vaše údaje ešte predtým, než opustia zariadenie. Zvoľte silné heslo, ktoré si zapamätáte.",
    ),
    "masterPasswordDescriptionUnlock": MessageLookupByLibrary.simpleMessage(
      "Zadajte hlavné heslo, aby sa dali údaje dešifrovať a zapnúť synchronizácia.",
    ),
    "masterPasswordLabel": MessageLookupByLibrary.simpleMessage("Hlavné heslo"),
    "masterPasswordWarning": MessageLookupByLibrary.simpleMessage(
      "Vaše heslo neukladáme. Ak ho zabudnete, údaje sa nebudú dať obnoviť. Zapíšte si ho a uložte na bezpečné miesto!",
    ),
    "minimum8Characters": MessageLookupByLibrary.simpleMessage(
      "Aspoň 8 znakov",
    ),
    "modify": MessageLookupByLibrary.simpleMessage("Upraviť"),
    "month": MessageLookupByLibrary.simpleMessage("Mesiac"),
    "neverSynced": MessageLookupByLibrary.simpleMessage(
      "Zatiaľ nesynchronizované",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nové heslo"),
    "newPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Nové heslo je povinné",
    ),
    "newPasswordMustBeDifferent": MessageLookupByLibrary.simpleMessage(
      "Nové heslo sa musí líšiť od aktuálneho",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Ďalej"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Žiadne archivované zvyky",
    ),
    "noBackupsAvailable": MessageLookupByLibrary.simpleMessage(
      "Zatiaľ nie sú k dispozícii žiadne zálohy.\nZálohy sa vytvárajú automaticky počas synchronizácie.",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Zatiaľ žiadne kategórie",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Nie sú žiadne údaje o zvykoch.",
    ),
    "noHabitsInCategory": m12,
    "noPreviousPurchasesFound": MessageLookupByLibrary.simpleMessage(
      "Nenašli sa žiadne predchádzajúce nákupy.",
    ),
    "notActive": MessageLookupByLibrary.simpleMessage("Neaktívne"),
    "notConfigured": MessageLookupByLibrary.simpleMessage("Nenastavené"),
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
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "offlineMode": MessageLookupByLibrary.simpleMessage("Režim offline"),
    "offlineModeDescription": MessageLookupByLibrary.simpleMessage(
      "Vypnúť synchronizáciu a všetky sieťové pripojenia",
    ),
    "offlineModeRestartContent": MessageLookupByLibrary.simpleMessage(
      "Zatvorte aplikáciu a znova ju otvorte, aby sa režim offline použil.",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Ó nie! Vaša sankcia:",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding": MessageLookupByLibrary.simpleMessage("Úvod"),
    "oneTapCheck": MessageLookupByLibrary.simpleMessage(
      "Splniť jedným ťuknutím",
    ),
    "or": MessageLookupByLibrary.simpleMessage("alebo"),
    "orContinueWith": MessageLookupByLibrary.simpleMessage(
      "alebo pokračujte cez",
    ),
    "partialValue": MessageLookupByLibrary.simpleMessage("Čiastočná hodnota"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Na sledovanie pokroku v menších prírastkoch",
    ),
    "passwordCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Heslo nesmie byť prázdne",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Heslo je povinné",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Heslo"),
    "passwordMinLengthError": MessageLookupByLibrary.simpleMessage(
      "Heslo musí mať aspoň 8 znakov",
    ),
    "passwordResetSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Heslo bolo úspešne obnovené. Teraz sa môžete prihlásiť novým heslom.",
    ),
    "passwordUpdated": MessageLookupByLibrary.simpleMessage(
      "Heslo bolo zmenené!",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Heslá sa nezhodujú",
    ),
    "pauseSyncing": MessageLookupByLibrary.simpleMessage(
      "Pozastaviť synchronizáciu",
    ),
    "paused": MessageLookupByLibrary.simpleMessage("Pozastavené"),
    "pausesSyncingAndBackup": MessageLookupByLibrary.simpleMessage(
      "Pozastaví synchronizáciu a zálohovanie",
    ),
    "permanentlyDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Natrvalo odstrániť účet",
    ),
    "permanentlyDeleteYourAccountAndData": MessageLookupByLibrary.simpleMessage(
      "Trvalé odstránenie účtu a údajov",
    ),
    "pleaseConfirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Potvrďte svoje heslo",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Prosím zadajte názov kategórie",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Zadajte platnú e-mailovú adresu",
    ),
    "pleaseSignInWithEmailAndPassword": MessageLookupByLibrary.simpleMessage(
      "Prihláste sa pomocou e-mailu a hesla.",
    ),
    "pleaseTypeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Na potvrdenie zadajte slovo DELETE",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Ochrana osobných údajov",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profil"),
    "progress": MessageLookupByLibrary.simpleMessage("Pokrok"),
    "progressOf": m13,
    "purchasesRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Nákupy boli úspešne obnovené!",
    ),
    "realTimeSyncAcrossDevices": MessageLookupByLibrary.simpleMessage(
      "Synchronizácia medzi zariadeniami v reálnom čase",
    ),
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Prosím znovu povoľte Touch ID alebo Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Pripomenutie odmeny po úspešnej rutine.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "Pripomenutie sankcie po neúspešnej rutine.",
    ),
    "resendInSeconds": m25,
    "resendVerificationEmail": MessageLookupByLibrary.simpleMessage(
      "Znova odoslať overovací e-mail",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Resetovať"),
    "resetAction": MessageLookupByLibrary.simpleMessage("Resetovať"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Obnoviť heslo"),
    "resetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Zadajte svoju e-mailovú adresu a pošleme vám odkaz na obnovenie hesla.",
    ),
    "resetToHaboCloud": MessageLookupByLibrary.simpleMessage(
      "Prepnúť späť na Habo Cloud",
    ),
    "resetToHaboCloudQuestion": MessageLookupByLibrary.simpleMessage(
      "Prepnúť späť na Habo Cloud?",
    ),
    "restEasy": MessageLookupByLibrary.simpleMessage("Buďte bez obáv"),
    "restEasyDesc": MessageLookupByLibrary.simpleMessage(
      "Celú históriu vášho pokroku bezpečne zálohujeme do cloudu. Úplný pokoj, automaticky.",
    ),
    "restartRequired": MessageLookupByLibrary.simpleMessage(
      "Vyžaduje sa reštart",
    ),
    "restartRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Zatvorte aplikáciu a znova ju otvorte, aby sa pripojila k novému serveru.",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Obnoviť"),
    "restoreBackupConfirmation": m26,
    "restoreBackupQuestion": MessageLookupByLibrary.simpleMessage(
      "Obnoviť zálohu?",
    ),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Obnovenie bolo úspešne dokončené!",
    ),
    "restoreData": MessageLookupByLibrary.simpleMessage("Obnoviť údaje"),
    "restoreFailed": MessageLookupByLibrary.simpleMessage("Obnovenie zlyhalo!"),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "CHYBA: Obnovenie zálohy zlyhalo.",
    ),
    "restoreFailedTryAgain": MessageLookupByLibrary.simpleMessage(
      "Obnovenie zlyhalo. Skúste to znova.",
    ),
    "restoreFailedWithError": m27,
    "restorePurchases": MessageLookupByLibrary.simpleMessage("Obnoviť nákupy"),
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
    "seamlessContinuity": MessageLookupByLibrary.simpleMessage(
      "Plynulé pokračovanie",
    ),
    "seamlessContinuityDesc": MessageLookupByLibrary.simpleMessage(
      "Vaše zvyky dokonale synchronizované všade. Začnite ich sledovať v telefóne a plynulo ich odškrtávajte na tablete.",
    ),
    "searchIcons": MessageLookupByLibrary.simpleMessage("Hľadať"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Vybrať kategórie",
    ),
    "selectIcon": MessageLookupByLibrary.simpleMessage("Vybrať ikonu"),
    "selectedCategories": m14,
    "selfHostDescription": MessageLookupByLibrary.simpleMessage(
      "Prevádzkujte vlastný backend Supabase a získajte plný prístup k synchronizácii bez predplatného. Pokyny nájdete v príručke k vlastnému hostingu.",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage(
      "Odoslať odkaz na obnovenie",
    ),
    "server": MessageLookupByLibrary.simpleMessage("Server"),
    "serverConfiguration": MessageLookupByLibrary.simpleMessage(
      "Nastavenie servera",
    ),
    "setColors": MessageLookupByLibrary.simpleMessage("Nastaviť farby"),
    "setNewPassword": MessageLookupByLibrary.simpleMessage(
      "Nastaviť nové heslo",
    ),
    "setPassword": MessageLookupByLibrary.simpleMessage("Nastaviť heslo"),
    "setUpSyncToEnable": MessageLookupByLibrary.simpleMessage(
      "Najprv nastavte synchronizáciu",
    ),
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
    "signIn": MessageLookupByLibrary.simpleMessage("Prihlásiť sa"),
    "signInFailedPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Prihlásenie zlyhalo. Skúste to znova.",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Odhlásiť sa"),
    "signOutConfirmationContent": MessageLookupByLibrary.simpleMessage(
      "Na prístup k synchronizovaným údajom budete musieť znova zadať hlavné heslo.",
    ),
    "signOutQuestion": MessageLookupByLibrary.simpleMessage("Odhlásiť sa?"),
    "signUp": MessageLookupByLibrary.simpleMessage("Zaregistrovať sa"),
    "skip": MessageLookupByLibrary.simpleMessage("Preskočiť"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Preskočiť (neovplyvňuje sériu)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Posuvník"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Zvukové efekty"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Zdrojový kód (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Štatistiky"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Predplatiť"),
    "subscribeToEnableSync": MessageLookupByLibrary.simpleMessage(
      "Predplaťte si Habo Sync a zapnite synchronizáciu",
    ),
    "subscriptionNeeded": MessageLookupByLibrary.simpleMessage(
      "Vyžaduje sa predplatné",
    ),
    "successful": MessageLookupByLibrary.simpleMessage("Úspešný"),
    "syncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Synchronizácia a zálohovanie",
    ),
    "syncAndBackupYourData": MessageLookupByLibrary.simpleMessage(
      "Synchronizujte a zálohujte svoje údaje",
    ),
    "syncError": MessageLookupByLibrary.simpleMessage("Chyba synchronizácie"),
    "syncNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synchronizácia nie je dostupná",
    ),
    "syncNow": MessageLookupByLibrary.simpleMessage("Synchronizovať teraz"),
    "syncTitle": MessageLookupByLibrary.simpleMessage("Synchronizácia"),
    "syncingHero": MessageLookupByLibrary.simpleMessage("Synchronizuje sa..."),
    "syncingPaused": MessageLookupByLibrary.simpleMessage(
      "Synchronizácia je pozastavená",
    ),
    "syncingPausedDesc": MessageLookupByLibrary.simpleMessage("Pozastavené"),
    "syncingToCloud": MessageLookupByLibrary.simpleMessage(
      "Synchronizácia s cloudom",
    ),
    "tapCheckLongPressMenu": MessageLookupByLibrary.simpleMessage(
      "Ťuknutím splniť, dlhým stlačením otvoriť ponuku",
    ),
    "tapSyncNowToRetry": MessageLookupByLibrary.simpleMessage(
      "Ťuknite na Synchronizovať teraz a skúste to znova",
    ),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Cieľová hodnota"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Obchodné podmienky",
    ),
    "testConnectionAndSave": MessageLookupByLibrary.simpleMessage(
      "Otestovať pripojenie a uložiť",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Téma"),
    "themeSelect": m0,
    "thisChangesYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Týmto zmeníte heslo na prihlásenie do Habo.",
    ),
    "todayAt": m28,
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
    "typeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Potvrďte zadaním DELETE",
    ),
    "unableToVerifyIdentity": MessageLookupByLibrary.simpleMessage(
      "Totožnosť sa nepodarilo overiť",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Zrušiť archiváciu"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Zrušiť archiváciu zvyku",
    ),
    "unavailableWhileOffline": MessageLookupByLibrary.simpleMessage(
      "Nedostupné v režime offline",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Vrátiť späť"),
    "unexpectedErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Vyskytla sa neočakávaná chyba. Skúste to znova.",
    ),
    "unit": MessageLookupByLibrary.simpleMessage("Jednotka"),
    "unknown": MessageLookupByLibrary.simpleMessage("Neznáme"),
    "unlockAndSync": MessageLookupByLibrary.simpleMessage(
      "Odomknúť a synchronizovať",
    ),
    "unlockPasswordExplanation": MessageLookupByLibrary.simpleMessage(
      "Ide o heslo, ktoré ste vytvorili pri prvom nastavení synchronizácie na inom zariadení.",
    ),
    "unlockSyncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Odomknúť synchronizáciu a zálohovanie",
    ),
    "unlockYourData": MessageLookupByLibrary.simpleMessage(
      "Odomknite svoje údaje",
    ),
    "updateYourEncryptionPassword": MessageLookupByLibrary.simpleMessage(
      "Zmena šifrovacieho hesla",
    ),
    "updateYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Zmena prihlasovacieho hesla",
    ),
    "urlIsRequired": MessageLookupByLibrary.simpleMessage(
      "Adresa URL je povinná",
    ),
    "urlMustStartWithHttpOrHttps": MessageLookupByLibrary.simpleMessage(
      "Adresa URL musí začínať na https:// alebo http://",
    ),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Použiť pravidlo dvoch dní",
    ),
    "verificationEmailResent": MessageLookupByLibrary.simpleMessage(
      "Overovací e-mail bol znova odoslaný!",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Zobraziť archivované zvyky",
    ),
    "viewOrCancelYourPlan": MessageLookupByLibrary.simpleMessage(
      "Zobrazenie alebo zrušenie plánu",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Varovanie"),
    "weSentVerificationLinkTo": MessageLookupByLibrary.simpleMessage(
      "Overovací odkaz sme poslali na adresu",
    ),
    "week": MessageLookupByLibrary.simpleMessage("Týždeň"),
    "weekdayAt": m29,
    "welcomeBackStayConsistent": MessageLookupByLibrary.simpleMessage(
      "Vitajte späť! Pokračujme v pravidelnosti.",
    ),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Čo je nové"),
    "whatsNewVersion": m16,
    "widgetChooseHabit": MessageLookupByLibrary.simpleMessage("Vyberte zvyk"),
    "widgetNoHabits": MessageLookupByLibrary.simpleMessage(
      "Pridajte zvyk v Habo",
    ),
    "widgetTheme": MessageLookupByLibrary.simpleMessage("Téma widgetu"),
    "willSyncWhenConnected": MessageLookupByLibrary.simpleMessage(
      "Synchronizácia prebehne po pripojení",
    ),
    "yesterdayAt": m30,
    "youAreOffline": MessageLookupByLibrary.simpleMessage("Ste offline"),
    "yourCommentHere": MessageLookupByLibrary.simpleMessage(
      "Vaša poznámka sem",
    ),
    "zeroKnowledgePrivacy": MessageLookupByLibrary.simpleMessage(
      "Súkromie s nulovým prístupom",
    ),
    "zeroKnowledgePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "Špičkové end-to-end šifrovanie. Hlavný kľúč máte iba vy — vaše osobné údaje nikdy nemôžeme čítať ani k nim pristupovať.",
    ),
  };
}
