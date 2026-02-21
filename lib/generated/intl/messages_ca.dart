// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ca locale. All the
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
  String get localeName => 'ca';

  static String m1(authMethod) =>
      "Si us plau, autentica\'t amb ${authMethod} per accedir a Habo";

  static String m2(authMethod) =>
      "Si us plau, autenticat amb ${authMethod} per accedir als teus hàbits";

  static String m3(authMethod) => "Protegeix l\'app amb ${authMethod}";

  static String m4(title) => "La categoria \"${title}\" ja existeix";

  static String m5(title) => "Categoria \"${title}\" creada amb èxit";

  static String m6(title) => "Categoria \"${title}\" eliminada amb èxit";

  static String m7(title) => "Categoria \"${title}\" actualitzada amb èxit";

  static String m8(current, unit) => "Actual: ${current} ${unit}";

  static String m9(title) =>
      "Vols eliminar \"${title}\"?\n\nAixò suprimirà la categoria de tots els hàbits associats.";

  static String m10(error) => "Error en eliminar la categoria: ${error}";

  static String m11(error) => "Error en desar la categoria: ${error}";

  static String m12(title) => "No hi ha cap hàbit a \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m14(count) => "Categories Seleccionades (${count})";

  static String m15(target, unit) => "Objectiu: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Dispositiu', 'light': 'Clar', 'dark': 'Fosc', 'oled': 'Negre pur (OLED)', 'materialYou': 'Material You', 'other': 'Dispositiu'})}";

  static String m16(version) => "Versió ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Quant a"),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Persona responsable",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Afegeix"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Afegeix Categoria"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Creació avançada d\'hàbits",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Aquesta secció t\'ajuda a definir millor els hàbits utilitzant el cicle de l\'hàbit. Has de definir senyals, rutines i gratificacions per cada hàbit.",
    ),
    "allCategories": MessageLookupByLibrary.simpleMessage(
      "Totes les categories",
    ),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Tots els hàbits seran substituïts pels de la còpia de seguretat.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Permet"),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificacions de l\'aplicació",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Forma de notificació per les notificacions de l\'aplicació",
    ),
    "archive": MessageLookupByLibrary.simpleMessage("Arxiva"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Arxiva l\'hàbit"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage("Hàbits Arxivats"),
    "at7AM": MessageLookupByLibrary.simpleMessage("A les 7:00"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autenticar"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Si us plau, autentica\'t per accedir a Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Autentica\'t per activar el bloqueig biomètric",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage("Autenticant…"),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Error d\'autenticació",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autenticació requerida",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Còpia de seguretat"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Còpia de seguretat creada amb èxit!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage(
      "Còpia de seguretat fallida!",
    ),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "ERROR: La creació de la còpia de seguretat ha fallat.",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biomètrica"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autenticació biomètrica requerida",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Autenticació biomètrica amb èxit",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage("Bloqueig Biomètric"),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Bloqueig biomètric desactivat",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Bloqueig biomètric activat",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "No s\'han reconegut les dades biomètriques, torna a intentar-ho",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "Biomètrica requerida",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage(
      "Hàbit booleà (Fet/No fet)",
    ),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Construint Millors Hàbits",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage(
      "Convida\'m a un cafè",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel·la"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "category": MessageLookupByLibrary.simpleMessage("Categoria"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryUpdatedSuccessfully": m7,
    "check": MessageLookupByLibrary.simpleMessage("Comprova"),
    "close": MessageLookupByLibrary.simpleMessage("Tanca"),
    "complete": MessageLookupByLibrary.simpleMessage("Completar"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Enhorabona! La teva recompensa:",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("Crea"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Crea la primera categoria per organitzar els teus hàbits",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Crea un hàbit"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Crea un hàbit i assigna\'l aquesta categoria",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Crea el teu primer hàbit.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Senyal"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "és el desencadenant que inicia l\'hàbit. Pot ser un moment, lloc, sentiment o event concret.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Senyal"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Ratxa actual"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "date": MessageLookupByLibrary.simpleMessage("Data"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Defineix els teus hàbits",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Per cenyir-te millor als teus hàbits, pots definir:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Elimina"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Elimina Categoria"),
    "deleteCategoryConfirmation": m9,
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Es requereixen les credencials del dispositiu",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "PIN, Patrò o Contrasenya del dispositiu",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Exempció de responsabilitat",
    ),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Fer 50 flexions"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "No oblidis revisar els teus hàbits.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Fer una donació de 10€ a una organització benèfica",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Fet"),
    "editCategory": MessageLookupByLibrary.simpleMessage("Editar Categoria"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Edita l\'hàbit"),
    "emptyList": MessageLookupByLibrary.simpleMessage("Llista buida"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Introdueix quantitat"),
    "exercise": MessageLookupByLibrary.simpleMessage("Fer exercici"),
    "fail": MessageLookupByLibrary.simpleMessage("Fracàs"),
    "failedToDeleteCategory": m10,
    "failedToSaveCategory": m11,
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Amaga hàbits que ja no segueixes sense eliminar-los",
    ),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Arxiu"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Organitza els hàbits amb filtres de categoria",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage(
      "Categories",
    ),
    "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
      "Obre pantalles de Habo directament (com la de configuració o la de crear)",
    ),
    "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
      "Esquema d\'URL (deep links)",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Protegeix l\'app amb Face ID / Touch ID/ bloqueig biomètric",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage(
      "Funció de bloqueig",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Colors dinàmics basats en el teu fons de pantalla",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Tema Material You (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Fes un seguiment de comptadors (per exemple gots d\'aigua beguts o pàgines llegides)",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Valors numèrics als hàbits",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage("Volum ajustable"),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Nou motor de so",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 min. de videojocs",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "No s\'ha trobat l\'arxiu",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "L\'arxiu és massa gran (màxim 10MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Empremta"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage(
      "Primer dia de la setmana",
    ),
    "habit": MessageLookupByLibrary.simpleMessage("Hàbit"),
    "habitArchived": MessageLookupByLibrary.simpleMessage("Hàbit arxivat"),
    "habitContract": MessageLookupByLibrary.simpleMessage(
      "Clàusules de l\'hàbit",
    ),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Tot i que es recomana el reforçament positiu, algunes persones poden optar per una clàusula d\'incompliment de l\'hàbit. Això permet estipular la sanció a imposar-te si no compleixes amb l\'hàbit. A més a més, pots demanar l\'ajuda d\'una persona responsable que t\'ajudi a supervisar els objectius.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("Hàbit eliminat."),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Cicle de l\'hàbit"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "El cicle de l\'hàbit (Habit loop) és un model psicològic que descriu el procés de formació dels hàbits. Es conforma per tres components: Senyal, Rutina i Gratificació. El Senyal dona lloc a la Rutina (l\'acció habitual), i aquesta és reforçada per la Gratificació. Això resulta en un cicle que fa que l\'hàbit s\'arreli i sigui més probable que el repeteixis.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificacions dels hàbits",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Forma de notificació per les notificacions d\'hàbits",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "El títol de l\'hàbit no pot ser buit.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Tipus d\'hàbit"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage("Hàbit desarxivat"),
    "habits": MessageLookupByLibrary.simpleMessage("Hàbits:"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo necessita permís per enviar notificacions per funcionar correctament.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Properament"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Sincronitza els hàbits entre tots els teus dispositius amb el servei de núvol de Habo, encriptat d\'extrem-a-extrem.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Més informació a habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Si vols donar suport a Habo, pots:",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Entrada"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Fitxer de còpia de seguretat invàlid",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Iris"),
    "logYourDays": MessageLookupByLibrary.simpleMessage(
      "Porta un registre diari",
    ),
    "modify": MessageLookupByLibrary.simpleMessage("Modifica"),
    "month": MessageLookupByLibrary.simpleMessage("Mes"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "No hi ha cap hàbit arxivat",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Encara no hi ha cap categoria",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "No hi ha dades sobre els hàbits.",
    ),
    "noHabitsInCategory": m12,
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage(
      "No completat amb èxit",
    ),
    "note": MessageLookupByLibrary.simpleMessage("Nota"),
    "notificationTime": MessageLookupByLibrary.simpleMessage(
      "Horari de la notificació",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notificacions"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Hàbit numèric"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Els hàbits numèrics et permeten monitorar el progrés en increments durant el dia.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Observa el teu progrés",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Oh no! La teva sanció:",
    ),
    "onboarding": MessageLookupByLibrary.simpleMessage("Guia inicial"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Valor parcial"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Per monitorar el progrés en increments més petits",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Si us plau, afegeix un títol de categoria",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de privacitat",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Progrés"),
    "progressOf": m13,
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Si us plau, torna a activar el Touch ID o Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "El recordatori de la gratificació desprès de dur a terme una rutina amb èxit.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "El recordatori de la sanció quan no es completa amb èxit una rutina.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Restableix"),
    "restore": MessageLookupByLibrary.simpleMessage("Restaura"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Restauració completada amb èxit!",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage(
      "Restauració fallida!",
    ),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "ERROR: La restauració de la còpia de seguretat ha fallat.",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Gratificació"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "és el benefici o sentiment positiu que s\'experimenta un cop duta a terme la rutina. Reforça l\'hàbit.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Gratificació"),
    "routine": MessageLookupByLibrary.simpleMessage("Rutina"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "és l\'acció que es duu a terme en resposta al senyal. Això és l\'hàbit en si mateix.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rutina"),
    "sanction": MessageLookupByLibrary.simpleMessage("Sanció"),
    "save": MessageLookupByLibrary.simpleMessage("Desa"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Desar progrés"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Selecciona Categories",
    ),
    "selectedCategories": m14,
    "setColors": MessageLookupByLibrary.simpleMessage("Canvia els colors"),
    "settings": MessageLookupByLibrary.simpleMessage("Paràmetres"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Si us plau, configura les credencials del dispositiu a la configuració",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Si us plau, configura el desbloqueig facial o per empremta a la configuració del dispositiu",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Si us plau, configura el Touch ID o Face ID a la configuració del dispositiu",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage("Mostra Categories"),
    "showMonthName": MessageLookupByLibrary.simpleMessage(
      "Mostra el nom del mes",
    ),
    "showReward": MessageLookupByLibrary.simpleMessage(
      "Mostra la gratificació",
    ),
    "showSanction": MessageLookupByLibrary.simpleMessage("Mostra la sanció"),
    "skip": MessageLookupByLibrary.simpleMessage("Salta"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Salta (no afecta la ratxa)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Selector"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Efectes de so"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Codi font (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Estadístiques"),
    "successful": MessageLookupByLibrary.simpleMessage("Completat amb èxit"),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Valor objectiu"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Condicions generals",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeSelect": m0,
    "topStreak": MessageLookupByLibrary.simpleMessage("La millor ratxa"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Sensor d\'empremta"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Pots fer un seguiment del teu progrés a través de la vista de calendari per cada hàbit o a la pàgina d\'estadístiques.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Torna a intentar-ho"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Regla dels dos dies"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Amb la regla dels dos dies, es pot perdre un dia sense perdre la ratxa, sempre que el següent dia la completis amb èxit.",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Desarxiva"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Desarxiva l\'hàbit",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Desfés"),
    "unit": MessageLookupByLibrary.simpleMessage("Unitat"),
    "unknown": MessageLookupByLibrary.simpleMessage("Desconegut"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Utilitza la regla dels dos dies",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Mostra hàbits arxivats",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Avís"),
    "week": MessageLookupByLibrary.simpleMessage("Setmana"),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Novetats"),
    "whatsNewVersion": m16,
    "yourCommentHere": MessageLookupByLibrary.simpleMessage(
      "Escriu el teu comentari aquí",
    ),
  };
}
