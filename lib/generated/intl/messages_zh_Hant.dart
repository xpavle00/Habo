// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hant locale. All the
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
  String get localeName => 'zh_Hant';

  static String m0(theme) => "${Intl.select(theme, {
            'device': '裝置',
            'light': '淺色',
            'dark': '深色',
            'oled': 'OLED 黑色',
            'other': '裝置'
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("關於"),
        "accountabilityPartner": MessageLookupByLibrary.simpleMessage("責任夥伴"),
        "add": MessageLookupByLibrary.simpleMessage("新增"),
        "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage("進階習慣養成"),
        "advancedHabitBuildingDescription":
            MessageLookupByLibrary.simpleMessage(
          "此區塊幫助你利用習慣迴圈，更具體地定義你的習慣。你應該為每個習慣定義提示、慣例與獎勵。",
        ),
        "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
          "所有習慣都將會被備份中的習慣取代。",
        ),
        "allow": MessageLookupByLibrary.simpleMessage("允許"),
        "appNotifications": MessageLookupByLibrary.simpleMessage("應用程式通知"),
        "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
          "應用程式通知的通知管道",
        ),
        "at7AM": MessageLookupByLibrary.simpleMessage("早上 7:00"),
        "backup": MessageLookupByLibrary.simpleMessage("備份"),
        "backupFailedError": MessageLookupByLibrary.simpleMessage("錯誤：建立備份失敗。"),
        "buyMeACoffee": MessageLookupByLibrary.simpleMessage("請我喝杯咖啡"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "check": MessageLookupByLibrary.simpleMessage("勾選"),
        "close": MessageLookupByLibrary.simpleMessage("關閉"),
        "congratulationsReward":
            MessageLookupByLibrary.simpleMessage("恭喜！你的獎勵："),
        "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
        "create": MessageLookupByLibrary.simpleMessage("建立"),
        "createHabit": MessageLookupByLibrary.simpleMessage("建立習慣"),
        "createYourFirstHabit":
            MessageLookupByLibrary.simpleMessage("建立你的第一個習慣。"),
        "cue": MessageLookupByLibrary.simpleMessage("提示"),
        "cueDescription": MessageLookupByLibrary.simpleMessage(
          "是啟動你習慣的觸發因素。它可以是特定的時間、地點、感受或事件。",
        ),
        "cueNumbered": MessageLookupByLibrary.simpleMessage("1. 提示"),
        "currentStreak": MessageLookupByLibrary.simpleMessage("目前連續天數"),
        "dan": MessageLookupByLibrary.simpleMessage("Dan"),
        "date": MessageLookupByLibrary.simpleMessage("日期"),
        "defineYourHabits": MessageLookupByLibrary.simpleMessage("定義你的習慣"),
        "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
          "為了更好地維持習慣，你可以定義：",
        ),
        "delete": MessageLookupByLibrary.simpleMessage("刪除"),
        "disclaimer": MessageLookupByLibrary.simpleMessage("免責聲明"),
        "do50PushUps": MessageLookupByLibrary.simpleMessage("做 50 下伏地挺身"),
        "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
          "別忘了檢視你的習慣。",
        ),
        "donateToCharity": MessageLookupByLibrary.simpleMessage("捐 10 美元給慈善機構"),
        "done": MessageLookupByLibrary.simpleMessage("完成"),
        "editHabit": MessageLookupByLibrary.simpleMessage("編輯習慣"),
        "emptyList": MessageLookupByLibrary.simpleMessage("空白清單"),
        "exercise": MessageLookupByLibrary.simpleMessage("運動"),
        "fail": MessageLookupByLibrary.simpleMessage("失敗"),
        "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
          "玩 15 分鐘電玩遊戲",
        ),
        "firstDayOfWeek": MessageLookupByLibrary.simpleMessage("每週的第一天"),
        "habit": MessageLookupByLibrary.simpleMessage("習慣"),
        "habitContract": MessageLookupByLibrary.simpleMessage("習慣契約"),
        "habitContractDescription": MessageLookupByLibrary.simpleMessage(
          "雖然建議使用正面強化，但有些人可能會選擇習慣契約。習慣契約允許你指定未達成習慣時的懲罰，並可能涉及一位責任夥伴協助監督你的目標。",
        ),
        "habitDeleted": MessageLookupByLibrary.simpleMessage("習慣已刪除。"),
        "habitLoop": MessageLookupByLibrary.simpleMessage("習慣迴圈"),
        "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
          "習慣迴圈是一個描述習慣養成過程的心理模型。它由三個要素組成：提示、慣例與獎勵。提示啟動慣例（習慣行為），隨後藉由獎勵強化，形成一個迴圈，使習慣更加根深蒂固，並更容易被重複。",
        ),
        "habitNotifications": MessageLookupByLibrary.simpleMessage("習慣通知"),
        "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
          "習慣通知的通知管道",
        ),
        "habitTitleEmptyError":
            MessageLookupByLibrary.simpleMessage("習慣的標題不以可空白。"),
        "habits": MessageLookupByLibrary.simpleMessage("習慣："),
        "habo": MessageLookupByLibrary.simpleMessage("Habo"),
        "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
          "Habo 需要權限才能傳送通知並正常運作。",
        ),
        "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
          "如果你想支持 Habo，你可以：",
        ),
        "logYourDays": MessageLookupByLibrary.simpleMessage("記錄你的每日進度"),
        "modify": MessageLookupByLibrary.simpleMessage("修改"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "noDataAboutHabits": MessageLookupByLibrary.simpleMessage("沒有關於習慣的資料。"),
        "notSoSuccessful": MessageLookupByLibrary.simpleMessage("未成功"),
        "note": MessageLookupByLibrary.simpleMessage("備註"),
        "notificationTime": MessageLookupByLibrary.simpleMessage("通知時間"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "observeYourProgress": MessageLookupByLibrary.simpleMessage("觀察你的進度"),
        "ohNoSanction": MessageLookupByLibrary.simpleMessage("糟糕！你的懲罰："),
        "onboarding": MessageLookupByLibrary.simpleMessage("新手導覽"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("隱私權政策"),
        "remainderOfReward":
            MessageLookupByLibrary.simpleMessage("成功執行慣例後的獎勵提醒。"),
        "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
          "未成功執行慣例後的懲罰提醒。",
        ),
        "reset": MessageLookupByLibrary.simpleMessage("重設"),
        "restore": MessageLookupByLibrary.simpleMessage("還原"),
        "restoreFailedError":
            MessageLookupByLibrary.simpleMessage("錯誤：還原備份失敗。"),
        "reward": MessageLookupByLibrary.simpleMessage("獎勵"),
        "rewardDescription": MessageLookupByLibrary.simpleMessage(
          "是你在執行慣例後獲得的好處或正面感受，這能強化習慣。",
        ),
        "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. 獎勵"),
        "routine": MessageLookupByLibrary.simpleMessage("慣例"),
        "routineDescription": MessageLookupByLibrary.simpleMessage(
          "是你回應提示所採取的行動。這就是習慣本身。",
        ),
        "routineNumbered": MessageLookupByLibrary.simpleMessage("2. 慣例"),
        "sanction": MessageLookupByLibrary.simpleMessage("懲罰"),
        "save": MessageLookupByLibrary.simpleMessage("儲存"),
        "setColors": MessageLookupByLibrary.simpleMessage("設定顏色"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "showMonthName": MessageLookupByLibrary.simpleMessage("顯示月份名稱"),
        "showReward": MessageLookupByLibrary.simpleMessage("顯示獎勵"),
        "showSanction": MessageLookupByLibrary.simpleMessage("顯示懲罰"),
        "skip": MessageLookupByLibrary.simpleMessage("跳過"),
        "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
          "跳過（不影響連續紀錄）",
        ),
        "soundEffects": MessageLookupByLibrary.simpleMessage("音效"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("原始碼 (GitHub)"),
        "statistics": MessageLookupByLibrary.simpleMessage("統計資料"),
        "successful": MessageLookupByLibrary.simpleMessage("成功"),
        "termsAndConditions": MessageLookupByLibrary.simpleMessage("使用條款"),
        "theme": MessageLookupByLibrary.simpleMessage("主題"),
        "themeSelect": m0,
        "topStreak": MessageLookupByLibrary.simpleMessage("最長連續天數"),
        "total": MessageLookupByLibrary.simpleMessage("總計"),
        "trackYourProgress": MessageLookupByLibrary.simpleMessage(
          "你可以透過每個習慣中的日曆檢視或統計頁面來追蹤你的進度。",
        ),
        "twoDayRule": MessageLookupByLibrary.simpleMessage("兩天規則"),
        "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
          "使用兩天規則，你可以錯過一天，只要隔天成功，連續紀錄就不會中斷。",
        ),
        "undo": MessageLookupByLibrary.simpleMessage("復原"),
        "unknown": MessageLookupByLibrary.simpleMessage("未知"),
        "useTwoDayRule": MessageLookupByLibrary.simpleMessage("使用兩天規則"),
        "warning": MessageLookupByLibrary.simpleMessage("警告"),
        "week": MessageLookupByLibrary.simpleMessage("週"),
        "yourCommentHere": MessageLookupByLibrary.simpleMessage("在此輸入你的備註"),
      };
}
