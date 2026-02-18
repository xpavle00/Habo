// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
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
  String get localeName => 'uk';

  static String m1(authMethod) =>
      "Будь ласка, пройдіть автентифікацію, щоб отримати доступ до Habo за допомогою ${authMethod}";

  static String m2(authMethod) =>
      "Будь ласка, пройдіть автентифікацію за допомогою ${authMethod}, щоб отримати доступ до своїх звичок";

  static String m3(authMethod) => "Безпечний додаток з ${authMethod}";

  static String m4(title) => "Категорія \"${title}\" вже існує";

  static String m5(title) => "Категорію \"${title}\" успішно створено";

  static String m6(title) => "Категорію \"${title}\" успішно видалено";

  static String m7(title) => "Категорію \"${title}\" успішно оновлено";

  static String m8(current, unit) => "Поточний: ${current} ${unit}";

  static String m9(title) =>
      "Ви впевнені, що хочете видалити \"${title}\"?\n\nЦе видалить категорію з усіх звичок, які її використовують.";

  static String m10(error) => "Не вдалося видалити категорію: ${error}";

  static String m11(error) => "Не вдалося зберегти категорію: ${error}";

  static String m12(title) => "Немає звичок у \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m14(count) => "Вибрані категорії (${count})";

  static String m15(target, unit) => "Ціль: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Пристрій', 'light': 'Світло', 'dark': 'Темний', 'oled': 'OLED чорний', 'materialYou': 'Material You', 'other': 'Пристрій'})}";

  static String m16(version) => "Версія ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Про застосунок"),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Партнер по відповідальності",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Додати"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Додати категорію"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Розширене будування звички",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Цей розділ допоможе вам краще визначити свої звички за допомогою циклу звички. Для кожної звички ви маєте визначити сигнал, рутину та винагороду.",
    ),
    "allCategories": MessageLookupByLibrary.simpleMessage("Усі категорії"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Всі звички будуть замінені звичками з резервної копії.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Дозволити"),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Повідомлення про застосунок",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Канал сповіщень для повідомлень про застосунок",
    ),
    "archive": MessageLookupByLibrary.simpleMessage("Архів"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Звичка архівувати"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage("Архівні звички"),
    "at7AM": MessageLookupByLibrary.simpleMessage("О 7:00 ранку"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Автентифікація"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, пройдіть автентифікацію для доступу до Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Автентифікація для активації біометричного блокування",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage("Автентифікація…"),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Помилка автентифікації",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Потрібна автентифікація",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Резервна копія"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Резервна копія успішно створена!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage(
      "Не вдалося створити резервну копію!",
    ),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "Помилка: не вдалося створити резервну копію.",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Біометричний"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Потрібна біометрична автентифікація",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Біометрична автентифікація успішна",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage("Біометричний замок"),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Біометричний замок вимкнено",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Біометричний замок увімкнено",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "Біометричні дані не розпізнано, спробуйте ще раз",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "Необхідні біометричні дані",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage("Булева звичка"),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Формування кращих звичок",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage(
      "Пригостити мене кавою",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Скасувати"),
    "categories": MessageLookupByLibrary.simpleMessage("Категорії"),
    "category": MessageLookupByLibrary.simpleMessage("Категорія"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryUpdatedSuccessfully": m7,
    "check": MessageLookupByLibrary.simpleMessage("Перевірити"),
    "close": MessageLookupByLibrary.simpleMessage("Закрити"),
    "complete": MessageLookupByLibrary.simpleMessage("Завершено"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Вітаємо! Твоя нагорода:",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("Створити"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Створіть свою першу категорію для впорядкування своїх звичок",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Створити звичку"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Створіть звичку та віднесіть її до цієї категорії",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Створіть вашу першу звичку.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Сигнал"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "це тригер, який запускає вашу звичку. Це може бути певний час, місце, відчуття або подія.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Сигнал"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Поточний рекорд"),
    "dan": MessageLookupByLibrary.simpleMessage("Денис"),
    "date": MessageLookupByLibrary.simpleMessage("Дата"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Визначте свої звички",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Щоб краще дотримуватися своїх звичок, ви можете визначити:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Видалити"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage(
      "Видалити категорію",
    ),
    "deleteCategoryConfirmation": m9,
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Потрібні облікові дані пристрою",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "PIN-код, графічний ключ або пароль пристрою",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Застереження"),
    "do50PushUps": MessageLookupByLibrary.simpleMessage(
      "Виконати 50 віджимань",
    ),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Не забудьте перевірити свої звички.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Пожертвувати 400₴ на благодійність",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Завершити"),
    "editCategory": MessageLookupByLibrary.simpleMessage(
      "Редагувати категорію",
    ),
    "editHabit": MessageLookupByLibrary.simpleMessage("Редагувати звичку"),
    "emptyList": MessageLookupByLibrary.simpleMessage("Порожній список"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Введіть суму"),
    "exercise": MessageLookupByLibrary.simpleMessage("Вправа"),
    "fail": MessageLookupByLibrary.simpleMessage("Невдача"),
    "failedToDeleteCategory": m10,
    "failedToSaveCategory": m11,
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Приховуйте звички, які ви більше не відстежуєте, без видалення",
    ),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Архів"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Упорядкуйте звички за допомогою фільтрів категорій",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage("Категорії"),
    "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
      "Відкрийте Habo безпосередньо на таких екранах, як налаштування або створення",
    ),
    "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
      "Схема URL-адрес (глибокі посилання)",
    ),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "Переглядайте прогрес у виконанні своїх звичок одним поглядом з головного екрана (експериментально)",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Віджет головного екрана",
    ),
    "featureIosSoundMixingDesc": MessageLookupByLibrary.simpleMessage(
      "Звуки Habo більше не переривають вашу музику чи подкасти",
    ),
    "featureIosSoundMixingTitle": MessageLookupByLibrary.simpleMessage(
      "Виправлено мікшування звуку",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Захистіть додаток за допомогою Face ID / Touch ID / біометрії",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage(
      "Функція блокування",
    ),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "Тривале натискання на звичні кнопки для швидкої зміни статусу",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage(
      "Перевірка тривалого натискання",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Динамічні кольори, що пасують до ваших шпалер",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Тема Material You (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Кількість відстежень, як-от склянки води або прочитані сторінки",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Числові значення у звичках",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Регульована гучність",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Новий звуковий двигун",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 хвилин у відеоіграх",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("Файл не знайдено"),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "Файл занадто великий (максимум 10 МБ)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Відбиток пальця"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage("Перший день тижня"),
    "habit": MessageLookupByLibrary.simpleMessage("Звичка"),
    "habitArchived": MessageLookupByLibrary.simpleMessage("Звичку архівовано"),
    "habitContract": MessageLookupByLibrary.simpleMessage("Договір про звичку"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Хоча рекомендується позитивне підкріплення, деякі люди можуть обрати договір про звичку. Договір про звичку дозволяє вам вказати покарання, які будуть застосовані, якщо ви пропустите свою звичку, також ви може залучити партнера, який допоможе контролювати досягнення ваших цілей.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("Звичку видалено."),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Цикл звички"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "Цикл звички – це психологічна модель, що описує процес формування звички. Вона складається з трьох компонентів: сигнал, рутина та винагорода. Сигнал запускає рутину (дії, які ви хочете зробити звичкою), яка потім підкріплюється винагородою, створюючи цикл, що робить звичку більш укоріненою та схильною до повторення.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Повідомлення про звички",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Канал сповіщень для повідомлень про звички",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "Назва звички не може бути порожньою.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Тип звички"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Звичку розархівовано",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Звички:"),
    "habitsToday": MessageLookupByLibrary.simpleMessage("Звички сьогодні"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Для коректної роботи Habo потрібен дозвіл на надсилання повідомлень.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Скоро буде"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Синхронізуйте свої звички на всіх пристроях за допомогою хмарного сервісу Habo з наскрізним шифруванням.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Дізнайтеся більше на habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Якщо ви хочете підтримати Habo, ви можете:",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Вхід"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Недійсний файл резервної копії",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Ірис"),
    "logYourDays": MessageLookupByLibrary.simpleMessage("Відстежуйте свої дні"),
    "modify": MessageLookupByLibrary.simpleMessage("Змінити"),
    "month": MessageLookupByLibrary.simpleMessage("Місяць"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Немає архівованих звичок",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Поки що немає категорій",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Даних про звички немає.",
    ),
    "noHabitsInCategory": m12,
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("Не такі успішні"),
    "note": MessageLookupByLibrary.simpleMessage("Нотатки"),
    "notificationTime": MessageLookupByLibrary.simpleMessage(
      "Час повідомлення",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Повідомлення"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Числова звичка"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Числові звички дозволяють вам відстежувати прогрес поступово протягом дня.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Спостерігайте за своїм прогресом",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Ой лишенько! Ваше покарання:",
    ),
    "onboarding": MessageLookupByLibrary.simpleMessage("Навчальний посібник"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Часткове значення"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Відстежувати прогрес меншими кроками",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, введіть назву категорії",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Політика конфіденційності",
    ),
    "progress": MessageLookupByLibrary.simpleMessage("Прогрес"),
    "progressOf": m13,
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, знову ввімкніть Touch ID або Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Нагадувати про винагороду після успішної рутини.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "Нагадування про покарання після невдалої рутини.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Скинути"),
    "restore": MessageLookupByLibrary.simpleMessage("Відновити"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Відновлення успішно завершено!",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage(
      "Відновлення не вдалося!",
    ),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "Помилка: відновлення з резервної копії не вдалося.",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Винагорода"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "це користь або позитивне відчуття, яке ви відчуваєте після виконання рутини. Це закріплює звичку.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Винагороду"),
    "routine": MessageLookupByLibrary.simpleMessage("Рутина"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "це дія, яку ви робите у відповідь на сигнал. Це сама звичка.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Рутину"),
    "sanction": MessageLookupByLibrary.simpleMessage("Покарання"),
    "save": MessageLookupByLibrary.simpleMessage("Зберегти"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Зберегти прогрес"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Виберіть категорії",
    ),
    "selectedCategories": m14,
    "setColors": MessageLookupByLibrary.simpleMessage("Змінити кольори"),
    "settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, налаштуйте облікові дані пристрою в налаштуваннях",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, налаштуйте розблокування відбитком пальця або обличчям у налаштуваннях пристрою",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, налаштуйте Touch ID або Face ID у налаштуваннях пристрою",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage(
      "Показати категорії",
    ),
    "showMonthName": MessageLookupByLibrary.simpleMessage(
      "Показувати назву місяця",
    ),
    "showReward": MessageLookupByLibrary.simpleMessage("Показувати винагороду"),
    "showSanction": MessageLookupByLibrary.simpleMessage(
      "Показувати покаранння",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Пропустити"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Пропущені (не впливає на рекорд)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Слайдер"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Звукові ефекти"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Вихідний код (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Статистика"),
    "successful": MessageLookupByLibrary.simpleMessage("Успішні"),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Цільове значення"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Умови та положення",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "themeSelect": m0,
    "topStreak": MessageLookupByLibrary.simpleMessage("Найкращий рекорд"),
    "total": MessageLookupByLibrary.simpleMessage("Загалом"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Сенсорний датчик"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Ви можете відстежувати свій прогрес через календар у кожній звичці або на сторінці статистики.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Спробуйте ще раз"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Правило двох днів"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "З правилом двох днів ви можете пропустити один день та не втратити рекорд, якщо наступний день буде успішним.",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Розархівувати"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Звичка розархівування",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Відмінити"),
    "unit": MessageLookupByLibrary.simpleMessage("Одиниця"),
    "unknown": MessageLookupByLibrary.simpleMessage("Невідомо"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Використовувати правило двох днів",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Переглянути архівовані звички",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Попередження"),
    "week": MessageLookupByLibrary.simpleMessage("Тиждень"),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Що нового"),
    "whatsNewVersion": m16,
    "yourCommentHere": MessageLookupByLibrary.simpleMessage("Ваші нотатки тут"),
  };
}
