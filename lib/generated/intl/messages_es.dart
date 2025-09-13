// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m1(authMethod) =>
      "Por favor, autentícate para acceder a Habo usando ${authMethod}";

  static String m2(authMethod) =>
      "Por favor, autentícate usando ${authMethod} para acceder a tus hábitos";

  static String m3(authMethod) => "Protege la aplicación con ${authMethod}";

  static String m4(title) => "La categoría \"${title}\" ya existe";

  static String m5(title) => "Categoría \"${title}\" creada correctamente";

  static String m6(title) => "Categoría \"${title}\" eliminada correctamente";

  static String m7(title) => "Categoría \"${title}\" actualizada correctamente";

  static String m8(current, unit) => "Actual: ${current} ${unit}";

  static String m9(title) =>
      "Estás seguro de eliminar \"${title}\"?\n\nEsto eliminará la categoría de todos los hábitos que la usan.";

  static String m10(error) => "Error al eliminar la categoría: ${error}";

  static String m11(error) => "Error al guardar la categoría: ${error}";

  static String m12(title) => "Ho hay hábitos en \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m14(count) => "Categorías seleccionadas (${count})";

  static String m15(target, unit) => "Objetivo: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Dispositivo', 'light': 'Claro', 'dark': 'Oscuro', 'oled': 'Oscuro para Oled', 'other': 'Dispositivo'})}";

  static String m16(version) => "Versión ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Colaborador responsable",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Añadir"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Añadir"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Creación avanzada de hábitos",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Esta sección te ayuda a definir mejor los hábitos utilizando un bucle de hábitos. Debes definir señales, rutinas y recompensas para cada hábito.",
    ),
    "allCategories": MessageLookupByLibrary.simpleMessage(
      "Todas las categorías",
    ),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Todos los hábitos serán sustituidos por los de la copia de seguridad.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Permitir"),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificaciones de la aplicación",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Métodos para las notificaciones de la aplicación",
    ),
    "archive": MessageLookupByLibrary.simpleMessage("Archivar"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Archivar hábito"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage(
      "Hábitos Archivados",
    ),
    "at7AM": MessageLookupByLibrary.simpleMessage("A las 7 de la mañana"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autenticar"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Por favor, autentícate para acceder a Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Autentícate para activar el bloqueo biométrico",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage("Autenticando…"),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Error de autenticación",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autenticación requerida",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Copia de seguridad"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "¡Copia de seguridad creada con éxito!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage(
      "¡Error en la copia de seguridad!",
    ),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "ERROR: al crear la copia de seguridad.",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biométrica"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autenticación biométrica requerida",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Autenticación biométrica exitosa",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage("Bloqueo Biométrico"),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Desbloqueo biométrico desactivado",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Desbloqueo biométrico activado",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "Biométrica no reconocida, inténtalo de nuevo",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "Biométrica requerida",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage("Hábito de sí/no"),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Construyendo mejores hábitos",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage("Invítame a un café"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "categories": MessageLookupByLibrary.simpleMessage("Categorías"),
    "category": MessageLookupByLibrary.simpleMessage("Categoría"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryUpdatedSuccessfully": m7,
    "check": MessageLookupByLibrary.simpleMessage("Comprobar"),
    "close": MessageLookupByLibrary.simpleMessage("Cerrar"),
    "complete": MessageLookupByLibrary.simpleMessage("Completado"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "¡Felicidades! Tu recompensa:",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("Crear"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Crea tu primera categoría para organizar tus hábitos",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Crear un hábito"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Crea un hábito y asígnalo a esta categoría",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Crea tu primer hábito.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Estímulo"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "es el desencadenante que inicia el hábito. Puede ser un momento concreto, un lugar, una sensación o un acontecimiento.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Estímulo"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Racha actual"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "date": MessageLookupByLibrary.simpleMessage("Fecha"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Define tus hábitos",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Para ceñirte mejor a tus hábitos, puedes definir:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Borrar"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage(
      "Eliminar categoría",
    ),
    "deleteCategoryConfirmation": m9,
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Credenciales del dispositivo requeridos",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "PIN, patrón o contraseña del dispositivo",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Aviso legal"),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Hacer 50 flexiones"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "No olvides revisar tus hábitos.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Donar 10 \$ a una organización benéfica",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Hecho"),
    "editCategory": MessageLookupByLibrary.simpleMessage("Editar Categoría"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Editar el hábito"),
    "emptyList": MessageLookupByLibrary.simpleMessage("La lista está vacía"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Introduzca cantidad"),
    "exercise": MessageLookupByLibrary.simpleMessage("Ejercicio"),
    "fail": MessageLookupByLibrary.simpleMessage("Fracaso"),
    "failedToDeleteCategory": m10,
    "failedToSaveCategory": m11,
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Oculta hábitos que ya no sigues sin eliminarlos",
    ),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Archivo"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Organiza los hábitos usando filtros por categoría",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage(
      "Categorías",
    ),
    "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
      "Abre Habo directamente en pantallas como ajustes o crear hábito",
    ),
    "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
      "Esquema de URL (deep links)",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Protege la app con Face ID / Touch ID / biometría",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage(
      "Función de bloqueo",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Colores dinámicos que se ajustan a tu fondo de pantalla",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Tema Material You (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Sigue conteos como vasos de agua o páginas leídas",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Valores numéricos en los hábitos",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Volumen ajustable",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Nuevo motor de sonido",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 minutos de videojuegos",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Archivo no encontrado",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "Archivo demasiado grande (máximo 10MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Huella"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage(
      "El primer día de la semana",
    ),
    "habit": MessageLookupByLibrary.simpleMessage("Hábito"),
    "habitArchived": MessageLookupByLibrary.simpleMessage("Hábito archivado"),
    "habitContract": MessageLookupByLibrary.simpleMessage(
      "Contrato del hábito",
    ),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Aunque se recomienda el refuerzo positivo, algunas personas pueden optar por un contrato de hábitos. Un contrato de hábitos permite especificar una sanción que se impondrá si no cumples el hábito, y puede implicar a otra persona o responsable que te ayude a supervisar tus objetivos.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("Hábito eliminado."),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Costumbre"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "Las costumbres es un modelo psicológico que describe el proceso de formación de los hábitos. Consta de tres componentes: Estímulo, Rutina y Recompensa. La señal desencadena la rutina (acción habitual), que se ve reforzada por la recompensa, creando un bucle que hace que el hábito esté más arraigado y sea más probable que se repita.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificaciones sobre los hábitos",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Formas de notificación de los hábitos",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "El título del hábito no puede estar vacío.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Tipo de hábito"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Hábito desarchivado",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Hábitos:"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo necesita permisos para enviar notificaciones para funcionar correctamente.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Próximamente"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Sincroniza tus hábitos en todos tus dispositivos con el servicio en la nube cifrado de extremo a extremo de Habo.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Más información en habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Si quieres apoyar a Habo puedes hacerlo:",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Entrada"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Archivo de copia de seguridad inválido",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Iris"),
    "logYourDays": MessageLookupByLibrary.simpleMessage("Registra tus días"),
    "modify": MessageLookupByLibrary.simpleMessage("Modificar"),
    "month": MessageLookupByLibrary.simpleMessage("Mes"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "No hay hábitos archivados",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Aún no hay categorías",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "No hay ningún dato sobre los hábitos.",
    ),
    "noHabitsInCategory": m12,
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("No tan bien"),
    "note": MessageLookupByLibrary.simpleMessage("Nota"),
    "notificationTime": MessageLookupByLibrary.simpleMessage(
      "Horario de la notificación",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notificaciones"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Hábito numérico"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Los hábitos numéricos te permiten registrar el progreso en incrementos a lo largo del día.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Observa tus progresos",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage("¡Oh no! Tu sanción:"),
    "onboarding": MessageLookupByLibrary.simpleMessage("Incorporando"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Valor parcial"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Para registrar el progreso en incrementos más pequeños",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Introduce un título para la categoría",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de privacidad",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Progreso"),
    "progressOf": m13,
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Por favor, reactiva Touch ID o Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "El recuerdo de la recompensa tras una rutina exitosa.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "El recordatorio de la sanción tras una rutina fallida.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Restablecer"),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "¡Restauración completada con éxito!",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage(
      "¡Restauración fallida!",
    ),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "ERROR: al restaurar la copia de seguridad.",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Recompensa"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "es el beneficio o la sensación positiva que experimentas después de realizar la rutina. Refuerza el hábito.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Recompensa"),
    "routine": MessageLookupByLibrary.simpleMessage("Rutina"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "es la acción que realizas en respuesta a la señal. Es el hábito en sí.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rutina"),
    "sanction": MessageLookupByLibrary.simpleMessage("Sanción"),
    "save": MessageLookupByLibrary.simpleMessage("Guardar"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Guardar progreso"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Selecciona Categorías",
    ),
    "selectedCategories": m14,
    "setColors": MessageLookupByLibrary.simpleMessage("Establecer los colores"),
    "settings": MessageLookupByLibrary.simpleMessage("Ajustes"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Por favor, configura los credenciales en los ajustes del dispositivo",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Por favor, configura la huella o desbloqueo facial en los ajustes del dispositivo",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Por favor, configura Touch ID o Face ID en los ajustes del dispositivo",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage("Ver Categorías"),
    "showMonthName": MessageLookupByLibrary.simpleMessage(
      "Mostrar el nombre del mes",
    ),
    "showReward": MessageLookupByLibrary.simpleMessage("Mostrar la recompensa"),
    "showSanction": MessageLookupByLibrary.simpleMessage("Mostrar la sanción"),
    "skip": MessageLookupByLibrary.simpleMessage("Omitir"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Omitir (no afecta a las rachas)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Deslizador"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Efectos de sonido"),
    "sourceCode": MessageLookupByLibrary.simpleMessage(
      "Código fuente (en GitHub)",
    ),
    "statistics": MessageLookupByLibrary.simpleMessage("Estadísticas"),
    "successful": MessageLookupByLibrary.simpleMessage("Con éxito"),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Valor objetivo"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Condiciones generales",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeSelect": m0,
    "topStreak": MessageLookupByLibrary.simpleMessage("La mejor racha"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Lector de huella"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Puedes seguir tu progreso a través del calendario para cada hábito o en la página de estadísticas.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Intentar de nuevo"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Regla de los dos días"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Con la regla de los dos días, puedes perder un día y no pierdes una racha si el día siguiente tienes éxito.",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Desarchivar"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Desarchivar hábito",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Deshacer"),
    "unit": MessageLookupByLibrary.simpleMessage("Unidad"),
    "unknown": MessageLookupByLibrary.simpleMessage("Desconocido"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Utilizar la regla de los dos días",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Ver hábitos archivados",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Advertencia"),
    "week": MessageLookupByLibrary.simpleMessage("Semana"),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Novedades"),
    "whatsNewVersion": m16,
    "yourCommentHere": MessageLookupByLibrary.simpleMessage(
      "Tu comentario aquí",
    ),
  };
}
