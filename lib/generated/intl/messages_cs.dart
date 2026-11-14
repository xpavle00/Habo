// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a cs locale. All the
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
  String get localeName => 'cs';

  static String m17(error) => "Chyba přihlášení přes Apple: ${error}";

  static String m1(authMethod) =>
      "Pro přístup k Habo se ověřte pomocí ${authMethod}";

  static String m2(authMethod) =>
      "Pro přístup ke svým návykům se ověřte pomocí ${authMethod}";

  static String m3(authMethod) => "Zabezpečit aplikaci pomocí ${authMethod}";

  static String m4(title) => "Kategorie „${title}“ již existuje";

  static String m5(title) => "Kategorie „${title}“ byla vytvořena";

  static String m6(title) => "Kategorie „${title}“ byla smazána";

  static String m7(title) => "Kategorie „${title}“ byla aktualizována";

  static String m18(e) =>
      "K serveru se nepodařilo připojit. Ověřte adresu URL, klíč anon a zda byla použita migrace Habo.\n\nChyba: ${e}";

  static String m8(current, unit) => "Aktuálně: ${current} ${unit}";

  static String m9(title) =>
      "Opravdu chcete smazat kategorii „${title}“?\n\nKategorie bude odebrána ze všech návyků, které ji používají.";

  static String m19(error) => "Chyba: ${error}";

  static String m10(error) => "Kategorii se nepodařilo smazat: ${error}";

  static String m20(error) => "Opětovné odeslání se nezdařilo: ${error}";

  static String m11(error) => "Kategorii se nepodařilo uložit: ${error}";

  static String m21(count) => "Počet návyků: ${count}";

  static String m22(days, plural) =>
      "Poslední synchronizace před ${days} ${Intl.select(plural, {'s': 'dny', 'other': 'dnem'})}";

  static String m23(hours) => "Poslední synchronizace před ${hours} h";

  static String m24(minutes) => "Poslední synchronizace před ${minutes} min";

  static String m12(title) => "V kategorii „${title}“ nejsou žádné návyky";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m25(seconds) => "Znovu odeslat za ${seconds} s";

  static String m26(date) =>
      "Všechna aktuální data budou nahrazena zálohou z ${date}.\n\nTuto akci nelze vrátit zpět.";

  static String m27(error) => "Obnovení se nezdařilo: ${error}";

  static String m14(count) => "Vybrané kategorie: ${count}";

  static String m15(target, unit) => "Cíl: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Podle zařízení', 'light': 'Světlý', 'dark': 'Tmavý', 'oled': 'Černý OLED', 'materialYou': 'Material You', 'other': 'Podle zařízení'})}";

  static String m28(time) => "Dnes v ${time}";

  static String m29(weekday, time) => "${weekday} v ${time}";

  static String m16(version) => "Verze ${version}";

  static String m30(time) => "Včera v ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("O aplikaci"),
    "accountPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Heslo účtu bylo úspěšně změněno",
    ),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Kontrolní partner",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Přidat"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Přidat kategorii"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Pokročilé budování návyku",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Tato část vám pomůže lépe vymezit návyk pomocí jeho cyklu. U každého návyku byste měli určit spouštěč, rutinu a odměnu.",
    ),
    "all": MessageLookupByLibrary.simpleMessage("Vše"),
    "allCategories": MessageLookupByLibrary.simpleMessage("Všechny kategorie"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Všechny návyky budou nahrazeny návyky ze zálohy.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Povolit"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Už máte účet? ",
    ),
    "anUnexpectedErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "Došlo k neočekávané chybě",
    ),
    "anUnexpectedErrorOccurredTryAgain": MessageLookupByLibrary.simpleMessage(
      "Došlo k neočekávané chybě. Zkuste to znovu.",
    ),
    "anonKeyIsRequired": MessageLookupByLibrary.simpleMessage(
      "Klíč anon je povinný",
    ),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Oznámení aplikace",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Kanál pro oznámení aplikace",
    ),
    "appleSignInError": m17,
    "archive": MessageLookupByLibrary.simpleMessage("Archivovat"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Archivovat návyk"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage(
      "Archivované návyky",
    ),
    "at7AM": MessageLookupByLibrary.simpleMessage("V 7:00"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Ověřit"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Ověřte svou totožnost pro přístup k Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Ověřte se, chcete-li zapnout biometrický zámek",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage(
      "Probíhá ověřování…",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Chyba ověření",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Je vyžadováno ověření",
    ),
    "automaticCloudBackups": MessageLookupByLibrary.simpleMessage(
      "Automatické cloudové zálohy",
    ),
    "backToSignIn": MessageLookupByLibrary.simpleMessage("Zpět k přihlášení"),
    "backup": MessageLookupByLibrary.simpleMessage("Záloha"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Záloha byla úspěšně vytvořena!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage(
      "Zálohu se nepodařilo vytvořit!",
    ),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "CHYBA: Zálohu se nepodařilo vytvořit.",
    ),
    "backupRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Záloha byla úspěšně obnovena!",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biometrie"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Je vyžadováno biometrické ověření",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Biometrické ověření proběhlo úspěšně",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage("Biometrický zámek"),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Biometrický zámek byl vypnut",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Biometrický zámek byl zapnut",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "Biometrické údaje nebyly rozpoznány. Zkuste to znovu",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "Je vyžadována biometrie",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage(
      "Zaškrtávací (ano/ne)",
    ),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Budování lepších návyků",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage("Koupit mi kávu"),
    "cancel": MessageLookupByLibrary.simpleMessage("Zrušit"),
    "categories": MessageLookupByLibrary.simpleMessage("Kategorie"),
    "category": MessageLookupByLibrary.simpleMessage("Kategorie návyku"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryName": MessageLookupByLibrary.simpleMessage("Název kategorie"),
    "categoryUpdatedSuccessfully": m7,
    "changeAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Změnit heslo účtu",
    ),
    "changeMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Změnit hlavní heslo",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Změnit heslo"),
    "check": MessageLookupByLibrary.simpleMessage("Označit jako splněné"),
    "checkEmailForPasswordReset": MessageLookupByLibrary.simpleMessage(
      "V e-mailu najdete odkaz pro obnovení hesla.",
    ),
    "checkEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "V e-mailu najdete odkaz pro obnovení hesla.",
    ),
    "checkYourEmail": MessageLookupByLibrary.simpleMessage(
      "Zkontrolujte svůj e-mail",
    ),
    "chooseBackupToRestore": MessageLookupByLibrary.simpleMessage(
      "Vyberte zálohu, kterou chcete obnovit",
    ),
    "chooseStrongPassword": MessageLookupByLibrary.simpleMessage(
      "Zvolte pro svůj účet silné heslo.",
    ),
    "clickLinkInEmailToVerify": MessageLookupByLibrary.simpleMessage(
      "Otevřete odkaz v e-mailu a ověřte svůj účet. Poté se sem vraťte a klepněte na tlačítko níže.",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Zavřít"),
    "complete": MessageLookupByLibrary.simpleMessage("Splnit"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Potvrzení nového hesla",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Potvrzení hesla",
    ),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Gratulujeme! Vaše odměna:",
    ),
    "connectedToCloud": MessageLookupByLibrary.simpleMessage(
      "Připojeno ke cloudu",
    ),
    "connectedToCustomServer": MessageLookupByLibrary.simpleMessage(
      "Připojeno k vlastnímu serveru",
    ),
    "connectedToHaboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Připojeno k Habo Cloud (výchozí)",
    ),
    "continueWithApple": MessageLookupByLibrary.simpleMessage(
      "Pokračovat přes Apple",
    ),
    "continueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Pokračovat přes Google",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "couldNotConnectToServer": m18,
    "create": MessageLookupByLibrary.simpleMessage("Vytvořit"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Vytvořit účet"),
    "createAccountToBackupAndSync": MessageLookupByLibrary.simpleMessage(
      "Vytvořte si účet pro zálohování a synchronizaci.",
    ),
    "createCategory": MessageLookupByLibrary.simpleMessage(
      "Vytvořit kategorii",
    ),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Vytvořte první kategorii a uspořádejte si návyky",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Vytvořit návyk"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Vytvořte návyk a přiřaďte ho k této kategorii",
    ),
    "createMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Vytvořte hlavní heslo",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Vytvořte si první návyk.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Spouštěč"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "je podnět, který zahájí váš návyk. Může jít o určitý čas, místo, pocit nebo událost.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Spouštěč"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Současné heslo"),
    "currentPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Současné heslo je povinné",
    ),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Aktuální série"),
    "customServer": MessageLookupByLibrary.simpleMessage("Vlastní server"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "dataBeingSynchronized": MessageLookupByLibrary.simpleMessage(
      "Vaše data se synchronizují",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Datum"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Vymezte své návyky",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Abyste své návyky snáze dodržovali, můžete určit:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Smazat"),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage("Smazat účet"),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Tato akce je trvalá a nelze ji vrátit zpět. Následující data budou nenávratně smazána:",
    ),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Smazat kategorii"),
    "deleteCategoryConfirmation": m9,
    "deleteCloudBackupsAndSyncData": MessageLookupByLibrary.simpleMessage(
      "Cloudové zálohy a synchronizovaná data",
    ),
    "deleteEncryptionKeysAndProfile": MessageLookupByLibrary.simpleMessage(
      "Šifrovací klíče a profil",
    ),
    "deleteHabitsAndTrackingData": MessageLookupByLibrary.simpleMessage(
      "Všechny vaše návyky a údaje o jejich plnění",
    ),
    "deleteSubscriptionManagedSeparately": MessageLookupByLibrary.simpleMessage(
      "Předplatné (spravuje se samostatně v obchodě)",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage("Smazání účtu"),
    "deleteYourAccountAndLoginCredentials":
        MessageLookupByLibrary.simpleMessage("Váš účet a přihlašovací údaje"),
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Je vyžadováno ověření zařízení",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "Kód PIN, gesto nebo heslo zařízení",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Vyloučení odpovědnosti",
    ),
    "disconnectFromSelfHosted": MessageLookupByLibrary.simpleMessage(
      "Tímto se odpojíte od vlastního serveru a přepnete zpět na výchozí server Habo Cloud. Bude nutné se znovu přihlásit.",
    ),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Udělat 50 kliků"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Nezapomeňte zaznamenat své návyky.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Darovat 10 \$ na charitu",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Hotovo"),
    "dontHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Ještě nemáte účet? ",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("Upravit kategorii"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Upravit návyk"),
    "emailIsRequired": MessageLookupByLibrary.simpleMessage(
      "E-mail je povinný",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emailPasswordAndAccount": MessageLookupByLibrary.simpleMessage(
      "E-mail, heslo a účet",
    ),
    "emptyList": MessageLookupByLibrary.simpleMessage("Prázdný seznam"),
    "endToEndEncryption": MessageLookupByLibrary.simpleMessage(
      "Šifrování typu end-to-end",
    ),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Zadejte hodnotu"),
    "enterCurrentPasswordAndChooseNew": MessageLookupByLibrary.simpleMessage(
      "Zadejte současné heslo a zvolte nové.",
    ),
    "enterEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Zadejte svou e-mailovou adresu a pošleme vám odkaz pro obnovení hesla.",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Zadejte platný e-mail",
    ),
    "enterValidUrl": MessageLookupByLibrary.simpleMessage(
      "Zadejte platnou adresu URL (např. https://vas-projekt.supabase.co)",
    ),
    "enterYourPasswordToConfirm": MessageLookupByLibrary.simpleMessage(
      "Potvrďte zadáním svého hesla",
    ),
    "errorText": MessageLookupByLibrary.simpleMessage("Chyba"),
    "errorWithDescription": m19,
    "everythingIsSafe": MessageLookupByLibrary.simpleMessage(
      "Všechna data jsou v bezpečí",
    ),
    "exercise": MessageLookupByLibrary.simpleMessage("Cvičení"),
    "fail": MessageLookupByLibrary.simpleMessage("Označit jako nesplněné"),
    "failedToDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Účet se nepodařilo smazat",
    ),
    "failedToDeleteCategory": m10,
    "failedToResend": m20,
    "failedToSaveCategory": m11,
    "failedToSendResetLink": MessageLookupByLibrary.simpleMessage(
      "Odkaz pro obnovení se nepodařilo odeslat. Zkuste to znovu.",
    ),
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Skryjte návyky, které už nesledujete, aniž byste je smazali",
    ),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Archiv"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Uspořádejte návyky pomocí filtrů kategorií",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage(
      "Třídění do kategorií",
    ),
    "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
      "Otevřete Habo přímo na obrazovce nastavení nebo vytvoření návyku",
    ),
    "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
      "Schéma URL (přímé odkazy)",
    ),
    "featureHomescreenWidgetDarkModeDesc": MessageLookupByLibrary.simpleMessage(
      "Widget Habo pro Android nyní podporuje světlé i tmavé pozadí.",
    ),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "Sledujte pokrok návyků přímo na domovské obrazovce (experimentální)",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Widget na domovské obrazovce",
    ),
    "featureIosSoundMixingDesc": MessageLookupByLibrary.simpleMessage(
      "Zvuky Habo už nepřeruší hudbu ani podcasty",
    ),
    "featureIosSoundMixingTitle": MessageLookupByLibrary.simpleMessage(
      "Opravené směšování zvuku",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Zabezpečte aplikaci pomocí Face ID, Touch ID nebo jiné biometrie",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage("Zámek aplikace"),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "Dlouhým stisknutím tlačítka návyku rychle změníte jeho stav",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage(
      "Dlouhé stisknutí",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Dynamické barvy odpovídající tapetě",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Motiv Material You (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Sledujte například počet sklenic vody nebo přečtených stran",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Číselné hodnoty u návyků",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Nastavitelná hlasitost",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Nový zvukový systém",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 min hraní videoher",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Soubor nebyl nalezen",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "Soubor je příliš velký (max. 10 MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Otisk prstu"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage("První den týdne"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Zapomněli jste heslo?",
    ),
    "fromPreviousBackups": MessageLookupByLibrary.simpleMessage(
      "Z předchozích záloh",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Začít"),
    "habit": MessageLookupByLibrary.simpleMessage("Návyk"),
    "habitArchived": MessageLookupByLibrary.simpleMessage(
      "Návyk byl archivován",
    ),
    "habitContract": MessageLookupByLibrary.simpleMessage("Smlouva o návyku"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Ačkoli se doporučuje pozitivní motivace, někdo může dát přednost smlouvě o návyku. V ní si určíte postih za nesplnění návyku a případně i kontrolního partnera, který vám pomůže dohlížet na cíle.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("Návyk byl smazán."),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Cyklus návyku"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "Cyklus návyku je psychologický model popisující vznik návyků. Tvoří ho tři části: spouštěč, rutina a odměna. Spouštěč vyvolá rutinu (návykovou činnost), kterou následně posílí odměna. Vzniká tak cyklus, díky němuž se návyk upevňuje a snáze opakuje.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Oznámení návyků",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Kanál pro oznámení návyků",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "Název návyku nesmí být prázdný.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Typ návyku"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Návyk byl vyjmut z archivu",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Návyky:"),
    "habitsCount": m21,
    "habitsToday": MessageLookupByLibrary.simpleMessage("Dnešní návyky"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Habo Cloud (výchozí)",
    ),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Aby Habo správně fungovalo, potřebuje oprávnění posílat oznámení.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Již brzy"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Habo Sync je tady! Synchronizujte a zálohujte své návyky na všech zařízeních pomocí cloudové synchronizace šifrované mezi koncovými zařízeními.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Další informace najdete na habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Pokud chcete Habo podpořit, můžete:",
    ),
    "importantCannotBeRecovered": MessageLookupByLibrary.simpleMessage(
      "Důležité: heslo nelze obnovit",
    ),
    "incorrectCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Nesprávné současné heslo",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Nesprávné heslo",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Zadávání hodnoty"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Neplatný soubor zálohy",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Duhovka"),
    "iveVerifiedMyEmail": MessageLookupByLibrary.simpleMessage(
      "E-mail mám ověřený",
    ),
    "keepHabitsSafeAndSynced": MessageLookupByLibrary.simpleMessage(
      "Mějte své návyky v bezpečí a synchronizované na všech zařízeních.",
    ),
    "lastSyncedDaysAgo": m22,
    "lastSyncedHoursAgo": m23,
    "lastSyncedJustNow": MessageLookupByLibrary.simpleMessage(
      "Právě synchronizováno",
    ),
    "lastSyncedMinsAgo": m24,
    "logYourDays": MessageLookupByLibrary.simpleMessage(
      "Zaznamenávejte jednotlivé dny",
    ),
    "manageSubscription": MessageLookupByLibrary.simpleMessage(
      "Spravovat předplatné",
    ),
    "masterPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Hlavní heslo bylo úspěšně změněno",
    ),
    "masterPasswordDescriptionSetup": MessageLookupByLibrary.simpleMessage(
      "Hlavní heslo zašifruje všechna data ještě předtím, než opustí vaše zařízení. Zvolte silné heslo, které si zapamatujete.",
    ),
    "masterPasswordDescriptionUnlock": MessageLookupByLibrary.simpleMessage(
      "Zadejte hlavní heslo, aby bylo možné data dešifrovat a zapnout synchronizaci.",
    ),
    "masterPasswordLabel": MessageLookupByLibrary.simpleMessage("Hlavní heslo"),
    "masterPasswordWarning": MessageLookupByLibrary.simpleMessage(
      "Vaše heslo neukládáme. Pokud ho zapomenete, data nebude možné obnovit. Zapište si ho a uložte na bezpečné místo!",
    ),
    "minimum8Characters": MessageLookupByLibrary.simpleMessage(
      "Alespoň 8 znaků",
    ),
    "modify": MessageLookupByLibrary.simpleMessage("Upravit"),
    "month": MessageLookupByLibrary.simpleMessage("Měsíc"),
    "neverSynced": MessageLookupByLibrary.simpleMessage(
      "Dosud nesynchronizováno",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nové heslo"),
    "newPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Nové heslo je povinné",
    ),
    "newPasswordMustBeDifferent": MessageLookupByLibrary.simpleMessage(
      "Nové heslo se musí lišit od současného",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Další"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Žádné archivované návyky",
    ),
    "noBackupsAvailable": MessageLookupByLibrary.simpleMessage(
      "Zatím nejsou k dispozici žádné zálohy.\nZálohy se vytvářejí automaticky během synchronizace.",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Zatím žádné kategorie",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "O návycích zatím nejsou žádné údaje.",
    ),
    "noHabitsInCategory": m12,
    "noPreviousPurchasesFound": MessageLookupByLibrary.simpleMessage(
      "Nebyly nalezeny žádné předchozí nákupy.",
    ),
    "notActive": MessageLookupByLibrary.simpleMessage("Neaktivní"),
    "notConfigured": MessageLookupByLibrary.simpleMessage("Nenastaveno"),
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("Nesplněno"),
    "note": MessageLookupByLibrary.simpleMessage("Poznámka"),
    "notificationTime": MessageLookupByLibrary.simpleMessage("Čas oznámení"),
    "notifications": MessageLookupByLibrary.simpleMessage("Oznámení"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Měřitelný"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "U měřitelných návyků můžete během dne postupně zaznamenávat pokrok.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Sledujte svůj pokrok",
    ),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "offlineMode": MessageLookupByLibrary.simpleMessage("Režim offline"),
    "offlineModeDescription": MessageLookupByLibrary.simpleMessage(
      "Zakázat synchronizaci a všechna síťová spojení",
    ),
    "offlineModeRestartContent": MessageLookupByLibrary.simpleMessage(
      "Režim offline zahájíte zavřením a opětovným otevřením aplikace.",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage("Ale ne! Váš postih:"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding": MessageLookupByLibrary.simpleMessage("Úvodní průvodce"),
    "oneTapCheck": MessageLookupByLibrary.simpleMessage(
      "Splnit jedním klepnutím",
    ),
    "or": MessageLookupByLibrary.simpleMessage("nebo"),
    "orContinueWith": MessageLookupByLibrary.simpleMessage(
      "nebo pokračujte pomocí",
    ),
    "partialValue": MessageLookupByLibrary.simpleMessage("Dílčí hodnota"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Slouží k zaznamenávání pokroku po menších krocích",
    ),
    "passwordCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Heslo nesmí být prázdné",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Heslo je povinné",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Heslo"),
    "passwordMinLengthError": MessageLookupByLibrary.simpleMessage(
      "Heslo musí mít alespoň 8 znaků",
    ),
    "passwordResetSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Heslo bylo úspěšně obnoveno. Nyní se můžete přihlásit novým heslem.",
    ),
    "passwordUpdated": MessageLookupByLibrary.simpleMessage(
      "Heslo bylo změněno!",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Hesla se neshodují",
    ),
    "pauseSyncing": MessageLookupByLibrary.simpleMessage(
      "Pozastavit synchronizaci",
    ),
    "paused": MessageLookupByLibrary.simpleMessage("Pozastaveno"),
    "pausesSyncingAndBackup": MessageLookupByLibrary.simpleMessage(
      "Pozastaví synchronizaci a zálohování",
    ),
    "permanentlyDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Trvale smazat účet",
    ),
    "permanentlyDeleteYourAccountAndData": MessageLookupByLibrary.simpleMessage(
      "Trvalé smazání účtu a dat",
    ),
    "pleaseConfirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Potvrďte své heslo",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Zadejte název kategorie",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Zadejte platnou e-mailovou adresu",
    ),
    "pleaseSignInWithEmailAndPassword": MessageLookupByLibrary.simpleMessage(
      "Přihlaste se pomocí e-mailu a hesla.",
    ),
    "pleaseTypeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Pro potvrzení zadejte slovo DELETE",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Zásady ochrany osobních údajů",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profil"),
    "progress": MessageLookupByLibrary.simpleMessage("Pokrok"),
    "progressOf": m13,
    "purchasesRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Nákupy byly úspěšně obnoveny!",
    ),
    "realTimeSyncAcrossDevices": MessageLookupByLibrary.simpleMessage(
      "Synchronizace mezi zařízeními v reálném čase",
    ),
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Znovu zapněte Touch ID nebo Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Připomenutí odměny po úspěšném splnění návyku.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "Připomenutí postihu po nesplnění návyku.",
    ),
    "resendInSeconds": m25,
    "resendVerificationEmail": MessageLookupByLibrary.simpleMessage(
      "Znovu odeslat ověřovací e-mail",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Resetovat"),
    "resetAction": MessageLookupByLibrary.simpleMessage("Resetovat"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Obnovit heslo"),
    "resetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Zadejte svou e-mailovou adresu a pošleme vám odkaz pro obnovení hesla.",
    ),
    "resetToHaboCloud": MessageLookupByLibrary.simpleMessage(
      "Přepnout zpět na Habo Cloud",
    ),
    "resetToHaboCloudQuestion": MessageLookupByLibrary.simpleMessage(
      "Přepnout zpět na Habo Cloud?",
    ),
    "restEasy": MessageLookupByLibrary.simpleMessage("Buďte bez obav"),
    "restEasyDesc": MessageLookupByLibrary.simpleMessage(
      "Celou historii vašeho pokroku bezpečně a automaticky zálohujeme do cloudu. Můžete tak být zcela bez obav.",
    ),
    "restartRequired": MessageLookupByLibrary.simpleMessage(
      "Je vyžadován restart",
    ),
    "restartRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Zavřete aplikaci a znovu ji otevřete, aby se připojila k novému serveru.",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Obnovit"),
    "restoreBackupConfirmation": m26,
    "restoreBackupQuestion": MessageLookupByLibrary.simpleMessage(
      "Obnovit ze zálohy?",
    ),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Obnovení bylo úspěšně dokončeno!",
    ),
    "restoreData": MessageLookupByLibrary.simpleMessage("Obnovit data"),
    "restoreFailed": MessageLookupByLibrary.simpleMessage(
      "Obnovení se nezdařilo!",
    ),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "CHYBA: Zálohu se nepodařilo obnovit.",
    ),
    "restoreFailedTryAgain": MessageLookupByLibrary.simpleMessage(
      "Obnovení se nezdařilo. Zkuste to znovu.",
    ),
    "restoreFailedWithError": m27,
    "restorePurchases": MessageLookupByLibrary.simpleMessage("Obnovit nákupy"),
    "reward": MessageLookupByLibrary.simpleMessage("Odměna"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "je přínos nebo příjemný pocit po provedení rutiny. Odměna návyk posiluje.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Odměna"),
    "routine": MessageLookupByLibrary.simpleMessage("Rutina"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "je činnost, kterou provedete v reakci na spouštěč. Jde o samotný návyk.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rutina"),
    "sanction": MessageLookupByLibrary.simpleMessage("Postih"),
    "save": MessageLookupByLibrary.simpleMessage("Uložit"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Uložit pokrok"),
    "seamlessContinuity": MessageLookupByLibrary.simpleMessage(
      "Plynulé pokračování",
    ),
    "seamlessContinuityDesc": MessageLookupByLibrary.simpleMessage(
      "Vaše návyky jsou plynule synchronizovány na všech zařízeních. Začněte je sledovat na telefonu a bez přerušení je označujte jako splněné na tabletu.",
    ),
    "searchIcons": MessageLookupByLibrary.simpleMessage("Hledat"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Vybrat kategorie",
    ),
    "selectIcon": MessageLookupByLibrary.simpleMessage("Vybrat ikonu"),
    "selectedCategories": m14,
    "selfHostDescription": MessageLookupByLibrary.simpleMessage(
      "Provozujte vlastní backend Supabase a získejte úplný přístup k synchronizaci bez předplatného. Pokyny najdete v průvodci vlastním provozem.",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage(
      "Odeslat odkaz pro obnovení",
    ),
    "server": MessageLookupByLibrary.simpleMessage("Server"),
    "serverConfiguration": MessageLookupByLibrary.simpleMessage(
      "Nastavení serveru",
    ),
    "setColors": MessageLookupByLibrary.simpleMessage("Nastavit barvy"),
    "setNewPassword": MessageLookupByLibrary.simpleMessage(
      "Nastavit nové heslo",
    ),
    "setPassword": MessageLookupByLibrary.simpleMessage("Nastavit heslo"),
    "setUpSyncToEnable": MessageLookupByLibrary.simpleMessage(
      "Nejprve nastavte synchronizaci",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Nastavení"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Nastavte v zařízení kód, gesto nebo heslo",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Nastavte v zařízení odemykání otiskem prstu nebo obličejem",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Nastavte v zařízení Touch ID nebo Face ID",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage(
      "Zobrazovat kategorie",
    ),
    "showMonthName": MessageLookupByLibrary.simpleMessage(
      "Zobrazovat název měsíce",
    ),
    "showReward": MessageLookupByLibrary.simpleMessage("Zobrazit odměnu"),
    "showSanction": MessageLookupByLibrary.simpleMessage("Zobrazit postih"),
    "signIn": MessageLookupByLibrary.simpleMessage("Přihlásit se"),
    "signInFailedPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Přihlášení se nezdařilo. Zkuste to znovu.",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Odhlásit se"),
    "signOutConfirmationContent": MessageLookupByLibrary.simpleMessage(
      "Pro přístup k synchronizovaným datům budete muset znovu zadat hlavní heslo.",
    ),
    "signOutQuestion": MessageLookupByLibrary.simpleMessage("Odhlásit se?"),
    "signUp": MessageLookupByLibrary.simpleMessage("Zaregistrovat se"),
    "skip": MessageLookupByLibrary.simpleMessage("Přeskočit"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Přeskočit (neovlivní sérii)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Posuvník"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Zvukové efekty"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Zdrojový kód (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistiky"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Předplatit"),
    "subscribeToEnableSync": MessageLookupByLibrary.simpleMessage(
      "Předplaťte si Habo Sync a zapněte synchronizaci",
    ),
    "subscriptionNeeded": MessageLookupByLibrary.simpleMessage(
      "Je vyžadováno předplatné",
    ),
    "successful": MessageLookupByLibrary.simpleMessage("Splněno"),
    "syncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Synchronizace a zálohování",
    ),
    "syncAndBackupYourData": MessageLookupByLibrary.simpleMessage(
      "Synchronizujte a zálohujte svá data",
    ),
    "syncError": MessageLookupByLibrary.simpleMessage("Chyba synchronizace"),
    "syncNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Synchronizace není dostupná",
    ),
    "syncNow": MessageLookupByLibrary.simpleMessage("Synchronizovat nyní"),
    "syncTitle": MessageLookupByLibrary.simpleMessage("Synchronizace"),
    "syncingHero": MessageLookupByLibrary.simpleMessage(
      "Probíhá synchronizace...",
    ),
    "syncingPaused": MessageLookupByLibrary.simpleMessage(
      "Synchronizace je pozastavena",
    ),
    "syncingPausedDesc": MessageLookupByLibrary.simpleMessage("Pozastaveno"),
    "syncingToCloud": MessageLookupByLibrary.simpleMessage(
      "Synchronizace s cloudem",
    ),
    "tapCheckLongPressMenu": MessageLookupByLibrary.simpleMessage(
      "Klepnutím splnit, dlouhým stisknutím otevřít nabídku",
    ),
    "tapSyncNowToRetry": MessageLookupByLibrary.simpleMessage(
      "Opakujte akci klepnutím na Synchronizovat nyní",
    ),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Cílová hodnota"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Smluvní podmínky",
    ),
    "testConnectionAndSave": MessageLookupByLibrary.simpleMessage(
      "Otestovat připojení a uložit",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Motiv"),
    "themeSelect": m0,
    "thisChangesYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Tímto změníte heslo pro přihlášení k Habo.",
    ),
    "todayAt": m28,
    "topStreak": MessageLookupByLibrary.simpleMessage("Nejdelší série"),
    "total": MessageLookupByLibrary.simpleMessage("Celkem"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Dotkněte se snímače"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Pokrok můžete sledovat v kalendáři každého návyku nebo na stránce se statistikami.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Zkusit znovu"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Pravidlo dvou dnů"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "S pravidlem dvou dnů můžete jeden den vynechat, aniž byste přišli o sérii, pokud návyk následující den splníte.",
    ),
    "typeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Potvrďte zadáním DELETE",
    ),
    "unableToVerifyIdentity": MessageLookupByLibrary.simpleMessage(
      "Totožnost se nepodařilo ověřit",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Vyjmout z archivu"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Vyjmout návyk z archivu",
    ),
    "unavailableWhileOffline": MessageLookupByLibrary.simpleMessage(
      "Nedostupné v režimu offline",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Vrátit zpět"),
    "unexpectedErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Došlo k neočekávané chybě. Zkuste to znovu.",
    ),
    "unit": MessageLookupByLibrary.simpleMessage("Jednotka"),
    "unknown": MessageLookupByLibrary.simpleMessage("Neznámé"),
    "unlockAndSync": MessageLookupByLibrary.simpleMessage(
      "Odemknout a synchronizovat",
    ),
    "unlockPasswordExplanation": MessageLookupByLibrary.simpleMessage(
      "Jde o heslo, které jste vytvořili při prvním nastavení synchronizace na jiném zařízení.",
    ),
    "unlockSyncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Odemknout synchronizaci a zálohování",
    ),
    "unlockYourData": MessageLookupByLibrary.simpleMessage(
      "Odemkněte svá data",
    ),
    "updateYourEncryptionPassword": MessageLookupByLibrary.simpleMessage(
      "Změna šifrovacího hesla",
    ),
    "updateYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Změna přihlašovacího hesla",
    ),
    "urlIsRequired": MessageLookupByLibrary.simpleMessage(
      "Adresa URL je povinná",
    ),
    "urlMustStartWithHttpOrHttps": MessageLookupByLibrary.simpleMessage(
      "Adresa URL musí začínat https:// nebo http://",
    ),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Používat pravidlo dvou dnů",
    ),
    "verificationEmailResent": MessageLookupByLibrary.simpleMessage(
      "Ověřovací e-mail byl znovu odeslán!",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Zobrazit archivované návyky",
    ),
    "viewOrCancelYourPlan": MessageLookupByLibrary.simpleMessage(
      "Zobrazení nebo zrušení tarifu",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Varování"),
    "weSentVerificationLinkTo": MessageLookupByLibrary.simpleMessage(
      "Ověřovací odkaz jsme poslali na adresu",
    ),
    "week": MessageLookupByLibrary.simpleMessage("Týden"),
    "weekdayAt": m29,
    "welcomeBackStayConsistent": MessageLookupByLibrary.simpleMessage(
      "Vítejte zpět! Pokračujte v pravidelném plnění návyků.",
    ),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Co je nového"),
    "whatsNewVersion": m16,
    "willSyncWhenConnected": MessageLookupByLibrary.simpleMessage(
      "Synchronizace proběhne po připojení",
    ),
    "yesterdayAt": m30,
    "youAreOffline": MessageLookupByLibrary.simpleMessage("Jste offline"),
    "yourCommentHere": MessageLookupByLibrary.simpleMessage(
      "Sem napište poznámku",
    ),
    "zeroKnowledgePrivacy": MessageLookupByLibrary.simpleMessage(
      "Soukromí bez přístupu k datům",
    ),
    "zeroKnowledgePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "Moderní šifrování typu end-to-end. Hlavní klíč máte pouze vy — vaše osobní data nikdy nemůžeme číst ani k nim přistupovat.",
    ),
  };
}
