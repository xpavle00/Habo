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

  static String m0(reward) => "Gratulujeme! Tvoja odmena:\n${reward}";

  static String m1(sanction) => "O nie! Tvoja sankcia:\n${sanction}";

  static String m2(theme) => "${Intl.select(theme, {
            'device': 'Zariadenie',
            'light': 'Svetlý',
            'dark': 'Tmavý',
            'oled': 'Oled čierna',
            'other': '',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("O aplikácii"),
        "accountabilityPartner":
            MessageLookupByLibrary.simpleMessage("Partner zodpovednosti"),
        "actualStreak": MessageLookupByLibrary.simpleMessage("Aktuálny rekord"),
        "add": MessageLookupByLibrary.simpleMessage("Pridať"),
        "advancedHabitBuilding":
            MessageLookupByLibrary.simpleMessage("Pokročilé budovanie zvykov"),
        "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
            "Táto sekcia ti pomôže lepšie definovať svoje zvyky pomocou Zvykovej slučky. Pre každý zvyk by si mal definovať Cueva, Rutinu a Odmenu."),
        "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
            "Všetky zvyky budú nahradené zvykmi zálohy."),
        "allow": MessageLookupByLibrary.simpleMessage("Povoliť"),
        "appNotifications":
            MessageLookupByLibrary.simpleMessage("Upozornenia aplikácie"),
        "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
            "Kanál upozornení pre upozornenia aplikácie"),
        "at7AM": MessageLookupByLibrary.simpleMessage("O 7:00 ráno"),
        "backup": MessageLookupByLibrary.simpleMessage("Zálohovať"),
        "backupFailedError": MessageLookupByLibrary.simpleMessage(
            "CHYBA: Vytvorenie zálohy zlyhalo."),
        "buyMeACoffee": MessageLookupByLibrary.simpleMessage("Kúp mi kávu\n"),
        "cancel": MessageLookupByLibrary.simpleMessage("Zrušiť"),
        "check": MessageLookupByLibrary.simpleMessage("Kontrolovať"),
        "close": MessageLookupByLibrary.simpleMessage("Zavrieť"),
        "comment": MessageLookupByLibrary.simpleMessage("Komentár"),
        "congratulationReward": m0,
        "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
        "create": MessageLookupByLibrary.simpleMessage("Vytvoriť"),
        "createHabit": MessageLookupByLibrary.simpleMessage("Vytvoriť zvyk"),
        "createYourFirstHabit":
            MessageLookupByLibrary.simpleMessage("Vytvorte svoj prvý zvyk."),
        "cue": MessageLookupByLibrary.simpleMessage("Cue"),
        "cueDescription": MessageLookupByLibrary.simpleMessage(
            " je spúšťač, ktorý spúšťa tvoj zvyk. Môže to byť konkrétny čas, miesto, pocit alebo udalosť.\n\n"),
        "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Cue"),
        "dan": MessageLookupByLibrary.simpleMessage("Dan"),
        "date": MessageLookupByLibrary.simpleMessage("Dátum"),
        "defineYourHabits":
            MessageLookupByLibrary.simpleMessage("Definuj svoje zvyky"),
        "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
            "Aby si sa lepšie držal svojich zvykov, môžeš definovať:"),
        "delete": MessageLookupByLibrary.simpleMessage("Vymazať"),
        "disclaimer": MessageLookupByLibrary.simpleMessage("Zodpovednosť\n"),
        "do50PushUps": MessageLookupByLibrary.simpleMessage("Urob 50 klikov"),
        "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
            "Nezabudnite skontrolovať svoje zvyky."),
        "donateToCharity":
            MessageLookupByLibrary.simpleMessage("Prispej 10 \$ na charitu"),
        "done": MessageLookupByLibrary.simpleMessage("Hotovo"),
        "editHabit": MessageLookupByLibrary.simpleMessage("Upraviť zvyk"),
        "emptyList": MessageLookupByLibrary.simpleMessage("Prázdny zoznam"),
        "exercise": MessageLookupByLibrary.simpleMessage("Cvičenie"),
        "fail": MessageLookupByLibrary.simpleMessage("Zlyhať"),
        "fifteenMinOfVideoGames":
            MessageLookupByLibrary.simpleMessage("15 minút video hier"),
        "firstDayOfWeek":
            MessageLookupByLibrary.simpleMessage("Prvý deň týždňa"),
        "habit": MessageLookupByLibrary.simpleMessage("Zvyk"),
        "habitContract": MessageLookupByLibrary.simpleMessage("Zmluva o zvyku"),
        "habitContractDescription": MessageLookupByLibrary.simpleMessage(
            "Aj keď sa odporúča pozitívne posilňovanie, niektorí ľudia sa môžu rozhodnúť pre zmluvu o zvyku. Zmluva o zvyku ti umožňuje špecifikovať sankciu, ktorá bude uložená, ak zmeškáš svoj zvyk, a môže zahŕňať partnera zodpovednosti, ktorý pomáha dohliadať na tvoje ciele."),
        "habitDeleted": MessageLookupByLibrary.simpleMessage("Zvyk vymazaný."),
        "habitLoop": MessageLookupByLibrary.simpleMessage("Zvyková slučka"),
        "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
            "Zvyková slučka je psychologický model popisujúci proces formovania zvykov. Skladá sa z troch komponentov: Cueva, Rutiny a Odmeny. Cueva spúšťa Rutinu (zvykovú akciu), ktorá je potom posilnená Odmenou, vytvárajúc slučku, ktorá robí zvyk viac zakorenený a pravdepodobne sa bude opakovať.\n\n"),
        "habitNotifications":
            MessageLookupByLibrary.simpleMessage("Upozornenia na zvyky"),
        "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
            "Kanál upozornení pre upozornenia na zvyky"),
        "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
            "Názov zvyku nemôže byť prázdny."),
        "habits": MessageLookupByLibrary.simpleMessage("Zvyky:"),
        "habo": MessageLookupByLibrary.simpleMessage("Habo"),
        "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
            "Habo potrebuje povolenie na odosielanie upozornení, aby správne fungoval."),
        "logYourDays":
            MessageLookupByLibrary.simpleMessage("Zaznamenaj svoje dni"),
        "modify": MessageLookupByLibrary.simpleMessage("Upraviť"),
        "month": MessageLookupByLibrary.simpleMessage("Mesiac"),
        "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
            "Nie sú k dispozícii žiadne údaje o zvykoch."),
        "notSoSuccessful":
            MessageLookupByLibrary.simpleMessage("Nie tak úspešný"),
        "notificationTime":
            MessageLookupByLibrary.simpleMessage("Čas upozornenia"),
        "notifications": MessageLookupByLibrary.simpleMessage("Upozornenia"),
        "observeYourProgress":
            MessageLookupByLibrary.simpleMessage("Sleduj svoj pokrok"),
        "ohNoSanction": m1,
        "onboarding": MessageLookupByLibrary.simpleMessage("Onboarding"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage(
            "Zásady ochrany osobných údajov\n"),
        "remainderOfReward": MessageLookupByLibrary.simpleMessage(
            "Zvyšok odmeny po úspešnej Rutine."),
        "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
            "Zvyšok sankcie po neúspešnej Rutine."),
        "reset": MessageLookupByLibrary.simpleMessage("Resetovať"),
        "restore": MessageLookupByLibrary.simpleMessage("Obnoviť"),
        "restoreFailedError": MessageLookupByLibrary.simpleMessage(
            "CHYBA: Obnovenie zálohy zlyhalo."),
        "reward": MessageLookupByLibrary.simpleMessage("Odmena"),
        "rewardDescription": MessageLookupByLibrary.simpleMessage(
            " je výhoda alebo pozitívne pocity, ktoré zažiješ po vykonaní Rutiny. Posilňuje to zvyk."),
        "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Odmena"),
        "routine": MessageLookupByLibrary.simpleMessage("Rutina"),
        "routineDescription": MessageLookupByLibrary.simpleMessage(
            " je akcia, ktorú vykonáš v reakcii na Cue. Toto je samotný zvyk.\n\n"),
        "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rutina"),
        "sanction": MessageLookupByLibrary.simpleMessage("Sankcia"),
        "save": MessageLookupByLibrary.simpleMessage("Uložiť"),
        "setColors": MessageLookupByLibrary.simpleMessage("Nastaviť farby"),
        "settings": MessageLookupByLibrary.simpleMessage("Nastavenia"),
        "showMonthName":
            MessageLookupByLibrary.simpleMessage("Zobraziť názov mesiaca"),
        "showReward": MessageLookupByLibrary.simpleMessage("Zobraziť odmenu"),
        "showSanction":
            MessageLookupByLibrary.simpleMessage("Zobraziť sankciu"),
        "skip": MessageLookupByLibrary.simpleMessage("Preskočiť"),
        "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
            "Preskočiť (neovplyvňuje rekordy)"),
        "soundEffects": MessageLookupByLibrary.simpleMessage("Zvukové efekty"),
        "sourceCode":
            MessageLookupByLibrary.simpleMessage("Zdrojový kód (GitHub)\n"),
        "statistics": MessageLookupByLibrary.simpleMessage("Štatistiky"),
        "successful": MessageLookupByLibrary.simpleMessage("Úspešný"),
        "termsAndConditions":
            MessageLookupByLibrary.simpleMessage("Podmienky používania\n"),
        "theme": MessageLookupByLibrary.simpleMessage("Téma"),
        "themeSelect": m2,
        "topStreak": MessageLookupByLibrary.simpleMessage("Najlepší rekord"),
        "total": MessageLookupByLibrary.simpleMessage("Celkom"),
        "trackYourProgress": MessageLookupByLibrary.simpleMessage(
            "Môžeš sledovať svoj pokrok prostredníctvom kalendára v každom zvyku alebo na stránke so štatistikami."),
        "twoDayRule":
            MessageLookupByLibrary.simpleMessage("Pravidlo dvoch dní"),
        "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
            "S pravidlom dvoch dní môžeš vynechať jeden deň a nezrušíš rekord, ak je nasledujúci deň úspešný."),
        "undo": MessageLookupByLibrary.simpleMessage("Späť"),
        "unknown": MessageLookupByLibrary.simpleMessage("Neznáme"),
        "useTwoDayRule":
            MessageLookupByLibrary.simpleMessage("Použiť pravidlo dvoch dní"),
        "warning": MessageLookupByLibrary.simpleMessage("Upozornenie"),
        "week": MessageLookupByLibrary.simpleMessage("Týždeň"),
        "yourCommentHere":
            MessageLookupByLibrary.simpleMessage("Tvoj komentár tu")
      };
}
