// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hans locale. All the
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
  String get localeName => 'zh_Hans';

  static String m1(authMethod) => "请通过 ${authMethod}授权访问 Habo";

  static String m2(authMethod) => "请使用${authMethod} 授权访问你的习惯";

  static String m3(authMethod) => "使用 ${authMethod} 方法保护 应用";

  static String m4(title) => "分类\"${title}\" 已经存在";

  static String m5(title) => "分类\"${title}\"创建成功";

  static String m6(title) => "分类 \"${title}\"删除成功";

  static String m7(title) => "分类 \"${title}\"更新成功";

  static String m8(current, unit) => "当前进度：${current} ${unit}";

  static String m9(title) => "你确定想要删除 \"${title}\"?\n\n这将从所有使用该分类的习惯中移除该分类";

  static String m10(error) => "删除分类失败： ${error}";

  static String m11(error) => "保存分类失败： ${error}";

  static String m12(title) => "没有习惯在 \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m14(count) => "已选中的分类(${count})";

  static String m15(target, unit) => "目标进度： ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': '跟随设备', 'light': '浅色', 'dark': '深色', 'oled': 'OLED 黑色', 'materialYou': 'Material You', 'other': '跟随设备'})}";

  static String m16(version) => "版本 ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage("责任伙伴"),
    "add": MessageLookupByLibrary.simpleMessage("新增"),
    "addCategory": MessageLookupByLibrary.simpleMessage("添加分类"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage("进阶习惯养成"),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "这一部分将帮助你利用“习惯循环”更好地定义自己的习惯。你应该为每一个习惯明确提示因素、行为模式以及奖励机制。",
    ),
    "allCategories": MessageLookupByLibrary.simpleMessage("所有分类"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "所有习惯将被替换为备份中的习惯。",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("允许"),
    "appNotifications": MessageLookupByLibrary.simpleMessage("应用程序通知"),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "应用程序通知的通知方式",
    ),
    "archive": MessageLookupByLibrary.simpleMessage("归档"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("归档习惯"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage("归档的习惯"),
    "at7AM": MessageLookupByLibrary.simpleMessage("早上 7:00"),
    "authenticate": MessageLookupByLibrary.simpleMessage("授权"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "请证实身份访问 Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "授权以启用生物特征识别锁定",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage("授权中…"),
    "authenticationError": MessageLookupByLibrary.simpleMessage("身份验证错误"),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage("需要身份验证"),
    "backup": MessageLookupByLibrary.simpleMessage("备份"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "成功地创建备份！",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage("备份失败！"),
    "backupFailedError": MessageLookupByLibrary.simpleMessage("错误：创建备份失败。"),
    "biometric": MessageLookupByLibrary.simpleMessage("生物特征识别"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "需要生物身份验证",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "生物识别身份验证已成功",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage("生物识别锁定"),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage("生物特征锁定禁用"),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage("生物特征锁定启用"),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "生物识别未被识别，请重试",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage("需要生物识别"),
    "booleanHabit": MessageLookupByLibrary.simpleMessage("布尔型习惯"),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage("构建更好的习惯"),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage("请我喝杯咖啡"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "categories": MessageLookupByLibrary.simpleMessage("分类"),
    "category": MessageLookupByLibrary.simpleMessage("分类"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryUpdatedSuccessfully": m7,
    "check": MessageLookupByLibrary.simpleMessage("勾选"),
    "close": MessageLookupByLibrary.simpleMessage("关闭"),
    "complete": MessageLookupByLibrary.simpleMessage("完成"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage("恭喜你！你的奖励："),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("创建备份"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "创建你的第一个分类来组织你的习惯",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("创建习惯"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "创建习惯并分给这个分类",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage("培养你的第一个习惯。"),
    "cue": MessageLookupByLibrary.simpleMessage("提示"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "是引发你习惯的触发因素。它可能是一个特定的时间、地点、某种感觉，或者是一件事情。",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1.提示"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("目前连续天数"),
    "dan": MessageLookupByLibrary.simpleMessage("小帅"),
    "date": MessageLookupByLibrary.simpleMessage("日期"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage("定义你的习惯"),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "为了更好地坚持你的习惯，你可以定义：",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("删除分类"),
    "deleteCategoryConfirmation": m9,
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage("需要设备凭证"),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "设备 PIN, Pattern, 或者 密码",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("免责声明"),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("做 50 个俯卧撑"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "别忘了检查你的习惯。",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage("捐赠 10 美元给慈善机构"),
    "done": MessageLookupByLibrary.simpleMessage("完成"),
    "editCategory": MessageLookupByLibrary.simpleMessage("编辑分类"),
    "editHabit": MessageLookupByLibrary.simpleMessage("编辑习惯"),
    "emptyList": MessageLookupByLibrary.simpleMessage("空白清单"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("输入数量"),
    "exercise": MessageLookupByLibrary.simpleMessage("锻炼"),
    "fail": MessageLookupByLibrary.simpleMessage("失败"),
    "failedToDeleteCategory": m10,
    "failedToSaveCategory": m11,
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage("隐藏不在跟踪的习惯且不删除"),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("归档"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "使用分类过滤器组织习惯",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage("分类"),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "在首页屏幕瞥一眼你的习惯进度（实验性的）",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "首屏挂件",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "使用Face ID / Touch ID / biometrics保护应用",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage("锁定功能"),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "在习惯按钮上长按快速切换状态",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage("长按切换"),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "动态匹配你的壁纸的颜色",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Material You 主题(Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "跟踪的数目如几杯水或者阅读页数",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage("可调节音量"),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage("玩 15 分钟游戏"),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("文件没找到"),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage("文件太大（最大10MB）"),
    "fingerprint": MessageLookupByLibrary.simpleMessage("指纹"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage("每周的第一天"),
    "habit": MessageLookupByLibrary.simpleMessage("习惯"),
    "habitArchived": MessageLookupByLibrary.simpleMessage("习惯已归档"),
    "habitContract": MessageLookupByLibrary.simpleMessage("习惯契约"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "虽然建议采用正面激励的方式，但有些人可能会选择签订习惯契约。习惯契约能让你制定未养成目标习惯受到的惩罚，而且契约中可能会有一位监督伙伴，帮助你监督自己是否达成目标。",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("习惯已删除。"),
    "habitLoop": MessageLookupByLibrary.simpleMessage("习惯循环"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "习惯循环是一种描述习惯形成过程的心理学模型。它由三个部分组成：提示、惯例（习惯性行为）和奖励。提示会引发惯例（习惯性行为），随后这种行为会得到奖励的强化，从而形成一个循环，使得习惯更加根深蒂固，也更有可能被重复。",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage("习惯通知"),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "习惯通知的通知方式",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage("习惯的标题不能为空。"),
    "habitType": MessageLookupByLibrary.simpleMessage("习惯类型"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage("习惯未归档"),
    "habits": MessageLookupByLibrary.simpleMessage("习惯："),
    "habitsToday": MessageLookupByLibrary.simpleMessage("今日习惯"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo 需要通知权限才能正常运行。",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("即将到来"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "使用 Habo 端到端加密云服务在你所有的设备之间同步习惯。",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "在habo.space/sync上了解更多",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "如果你想支持 Habo ，你可以：",
    ),
    "input": MessageLookupByLibrary.simpleMessage("输入"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage("不合法的备份文件"),
    "logYourDays": MessageLookupByLibrary.simpleMessage("记录你的每日进度"),
    "modify": MessageLookupByLibrary.simpleMessage("修改"),
    "month": MessageLookupByLibrary.simpleMessage("月"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage("未归档的习惯"),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage("还没有创建分类"),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage("没有关于习惯的数据。"),
    "noHabitsInCategory": m12,
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("未成功"),
    "note": MessageLookupByLibrary.simpleMessage("备注"),
    "notificationTime": MessageLookupByLibrary.simpleMessage("提醒时间"),
    "notifications": MessageLookupByLibrary.simpleMessage("通知提醒"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("计数型习惯"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "计数型习惯使你可以通过增量的方式整天跟踪进度。",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage("查看你的进度"),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage("糟糕！你的惩罚："),
    "onboarding": MessageLookupByLibrary.simpleMessage("新手引导"),
    "partialValue": MessageLookupByLibrary.simpleMessage("部分值"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "以更小的增量跟踪进度",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage("请输入分类标题"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "progress": MessageLookupByLibrary.simpleMessage("进度"),
    "progressOf": m13,
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "请重启用 Touch ID 或 Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "成功完成一套动作后的奖励提醒。",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "未成功执行惯例后的惩罚提醒。",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("恢复默认"),
    "restore": MessageLookupByLibrary.simpleMessage("恢复备份"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "成功完成恢复！",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage("恢复失败！"),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage("错误：恢复备份失败。"),
    "reward": MessageLookupByLibrary.simpleMessage("奖励"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "是你在完成习惯性行为之后所体验到的益处或积极感受。它会强化这一习惯。",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3.奖励"),
    "routine": MessageLookupByLibrary.simpleMessage("惯例"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "是你对提示做出的行动。这就是习惯本身。",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2.惯例"),
    "sanction": MessageLookupByLibrary.simpleMessage("惩罚"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("保存进度"),
    "selectCategories": MessageLookupByLibrary.simpleMessage("选择分类"),
    "selectedCategories": m14,
    "setColors": MessageLookupByLibrary.simpleMessage("设置颜色"),
    "settings": MessageLookupByLibrary.simpleMessage("设置"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "请在设置中设定设备凭证",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "请在设备设置中设置指纹或面部解锁",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "请在设置中设置 Touch ID 或 Face ID",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage("显示所有分类"),
    "showMonthName": MessageLookupByLibrary.simpleMessage("显示月份名称"),
    "showReward": MessageLookupByLibrary.simpleMessage("显示奖励"),
    "showSanction": MessageLookupByLibrary.simpleMessage("显示惩罚"),
    "skip": MessageLookupByLibrary.simpleMessage("跳过"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "跳过（不影响连续记录）",
    ),
    "soundEffects": MessageLookupByLibrary.simpleMessage("音效"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("源代码(Github)"),
    "statistics": MessageLookupByLibrary.simpleMessage("统计数据"),
    "successful": MessageLookupByLibrary.simpleMessage("成功"),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("目标值"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage("使用条款"),
    "theme": MessageLookupByLibrary.simpleMessage("主题"),
    "themeSelect": m0,
    "topStreak": MessageLookupByLibrary.simpleMessage("最长连续天数"),
    "total": MessageLookupByLibrary.simpleMessage("合计"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("触控传感器"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "您可以通过每个习惯的日历视图或统计页面来查看您的进度。",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("请重试"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("两天规则"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "使用“两天规则”，你可以有一天没完成任务，但只要第二天成功完成了，就不会中断连续打卡的记录。",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("未归档"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage("未归档习惯"),
    "undo": MessageLookupByLibrary.simpleMessage("恢复"),
    "unit": MessageLookupByLibrary.simpleMessage("单位"),
    "unknown": MessageLookupByLibrary.simpleMessage("未知"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage("使用“两天规则”"),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage("查看归档的习惯"),
    "warning": MessageLookupByLibrary.simpleMessage("警告"),
    "week": MessageLookupByLibrary.simpleMessage("周"),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("更新了什么"),
    "whatsNewVersion": m16,
    "yourCommentHere": MessageLookupByLibrary.simpleMessage("在此输入你的备注"),
  };
}
