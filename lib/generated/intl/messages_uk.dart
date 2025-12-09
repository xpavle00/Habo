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

  static String m0(theme) => "${Intl.select(theme, {
            'device': 'Пристрій',
            'light': 'Світла',
            'dark': 'Темна',
            'oled': 'Чорна OLED',
            'other': 'Пристрій'
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Про застосунок"),
        "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
          "Партнер по відповідальності",
        ),
        "add": MessageLookupByLibrary.simpleMessage("Додати"),
        "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
          "Розширене будування звички",
        ),
        "advancedHabitBuildingDescription":
            MessageLookupByLibrary.simpleMessage(
          "Цей розділ допоможе вам краще визначити свої звички за допомогою циклу звички. Для кожної звички ви маєте визначити сигнал, рутину та винагороду.",
        ),
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
        "at7AM": MessageLookupByLibrary.simpleMessage("О 7:00 ранку"),
        "backup": MessageLookupByLibrary.simpleMessage("Резервна копія"),
        "backupFailedError": MessageLookupByLibrary.simpleMessage(
          "Помилка: не вдалося створити резервну копію.",
        ),
        "buyMeACoffee": MessageLookupByLibrary.simpleMessage(
          "Пригостити мене кавою",
        ),
        "cancel": MessageLookupByLibrary.simpleMessage("Скасувати"),
        "check": MessageLookupByLibrary.simpleMessage("Перевірити"),
        "close": MessageLookupByLibrary.simpleMessage("Закрити"),
        "congratulationsReward": MessageLookupByLibrary.simpleMessage(
          "Вітаємо! Твоя нагорода:",
        ),
        "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
        "create": MessageLookupByLibrary.simpleMessage("Створити"),
        "createHabit": MessageLookupByLibrary.simpleMessage("Створити звичку"),
        "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
          "Створіть вашу першу звичку.",
        ),
        "cue": MessageLookupByLibrary.simpleMessage("Сигнал"),
        "cueDescription": MessageLookupByLibrary.simpleMessage(
          "це тригер, який запускає вашу звичку. Це може бути певний час, місце, відчуття або подія.",
        ),
        "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Сигнал"),
        "currentStreak":
            MessageLookupByLibrary.simpleMessage("Поточний рекорд"),
        "dan": MessageLookupByLibrary.simpleMessage("Денис"),
        "date": MessageLookupByLibrary.simpleMessage("Дата"),
        "defineYourHabits": MessageLookupByLibrary.simpleMessage(
          "Визначте свої звички",
        ),
        "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
          "Щоб краще дотримуватися своїх звичок, ви можете визначити:",
        ),
        "delete": MessageLookupByLibrary.simpleMessage("Видалити"),
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
        "editHabit": MessageLookupByLibrary.simpleMessage("Редагувати звичку"),
        "emptyList": MessageLookupByLibrary.simpleMessage("Порожній список"),
        "exercise": MessageLookupByLibrary.simpleMessage("Вправа"),
        "fail": MessageLookupByLibrary.simpleMessage("Невдача"),
        "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
          "15 хвилин у відеоіграх",
        ),
        "firstDayOfWeek":
            MessageLookupByLibrary.simpleMessage("Перший день тижня"),
        "habit": MessageLookupByLibrary.simpleMessage("Звичка"),
        "habitContract":
            MessageLookupByLibrary.simpleMessage("Договір про звичку"),
        "habitContractDescription": MessageLookupByLibrary.simpleMessage(
          "Хоча рекомендується позитивне підкріплення, деякі люди можуть обрати договір про звичку. Договір про звичку дозволяє вам вказати покарання, які будуть застосовані, якщо ви пропустите свою звичку, також ви може залучити партнера, який допоможе контролювати досягнення ваших цілей.",
        ),
        "habitDeleted":
            MessageLookupByLibrary.simpleMessage("Звичку видалено."),
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
        "habits": MessageLookupByLibrary.simpleMessage("Звички:"),
        "habo": MessageLookupByLibrary.simpleMessage("Habo"),
        "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
          "Для коректної роботи Habo потрібен дозвіл на надсилання повідомлень.",
        ),
        "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
          "Якщо ви хочете підтримати Habo, ви можете:",
        ),
        "logYourDays":
            MessageLookupByLibrary.simpleMessage("Відстежуйте свої дні"),
        "modify": MessageLookupByLibrary.simpleMessage("Змінити"),
        "month": MessageLookupByLibrary.simpleMessage("Місяць"),
        "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
          "Даних про звички немає.",
        ),
        "notSoSuccessful":
            MessageLookupByLibrary.simpleMessage("Не такі успішні"),
        "note": MessageLookupByLibrary.simpleMessage("Нотатки"),
        "notificationTime": MessageLookupByLibrary.simpleMessage(
          "Час повідомлення",
        ),
        "notifications": MessageLookupByLibrary.simpleMessage("Повідомлення"),
        "observeYourProgress": MessageLookupByLibrary.simpleMessage(
          "Спостерігайте за своїм прогресом",
        ),
        "ohNoSanction": MessageLookupByLibrary.simpleMessage(
          "Ой лишенько! Ваше покарання:",
        ),
        "onboarding":
            MessageLookupByLibrary.simpleMessage("Навчальний посібник"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage(
          "Політика конфіденційності",
        ),
        "remainderOfReward": MessageLookupByLibrary.simpleMessage(
          "Нагадувати про винагороду після успішної рутини.",
        ),
        "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
          "Нагадування про покарання після невдалої рутини.",
        ),
        "reset": MessageLookupByLibrary.simpleMessage("Скинути"),
        "restore": MessageLookupByLibrary.simpleMessage("Відновити"),
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
        "setColors": MessageLookupByLibrary.simpleMessage("Змінити кольори"),
        "settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
        "showMonthName": MessageLookupByLibrary.simpleMessage(
          "Показувати назву місяця",
        ),
        "showReward":
            MessageLookupByLibrary.simpleMessage("Показувати винагороду"),
        "showSanction": MessageLookupByLibrary.simpleMessage(
          "Показувати покаранння",
        ),
        "skip": MessageLookupByLibrary.simpleMessage("Пропустити"),
        "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
          "Пропущені (не впливає на рекорд)",
        ),
        "soundEffects": MessageLookupByLibrary.simpleMessage("Звукові ефекти"),
        "sourceCode":
            MessageLookupByLibrary.simpleMessage("Вихідний код (GitHub)"),
        "statistics": MessageLookupByLibrary.simpleMessage("Статистика"),
        "successful": MessageLookupByLibrary.simpleMessage("Успішні"),
        "termsAndConditions": MessageLookupByLibrary.simpleMessage(
          "Умови та положення",
        ),
        "theme": MessageLookupByLibrary.simpleMessage("Тема"),
        "themeSelect": m0,
        "topStreak": MessageLookupByLibrary.simpleMessage("Найкращий рекорд"),
        "total": MessageLookupByLibrary.simpleMessage("Загалом"),
        "trackYourProgress": MessageLookupByLibrary.simpleMessage(
          "Ви можете відстежувати свій прогрес через календар у кожній звичці або на сторінці статистики.",
        ),
        "twoDayRule": MessageLookupByLibrary.simpleMessage("Правило двох днів"),
        "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
          "З правилом двох днів ви можете пропустити один день та не втратити рекорд, якщо наступний день буде успішним.",
        ),
        "undo": MessageLookupByLibrary.simpleMessage("Відмінити"),
        "unknown": MessageLookupByLibrary.simpleMessage("Невідомо"),
        "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
          "Використовувати правило двох днів",
        ),
        "warning": MessageLookupByLibrary.simpleMessage("Попередження"),
        "week": MessageLookupByLibrary.simpleMessage("Тиждень"),
        "yourCommentHere":
            MessageLookupByLibrary.simpleMessage("Ваші нотатки тут"),
      };
}
