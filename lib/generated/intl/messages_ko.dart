// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m8(current, unit) => "현재: ${current} ${unit}";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m15(target, unit) => "목표: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': '기기 설정', 'light': '라이트', 'dark': '다크', 'oled': 'OLED 블랙', 'materialYou': 'Material You', 'other': '기기 설정'})}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("정보"),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage("목표 달성 파트너"),
    "add": MessageLookupByLibrary.simpleMessage("추가"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage("고급 습관 형성"),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "습관 루프를 활용해 습관을 더욱 구체적으로 정의할 수 있는 섹션입니다. 각 습관의 신호, 반복 행동, 보상을 설정해 보세요.",
    ),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "백업 데이터로 기존의 모든 습관을 덮어씁니다.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("허용"),
    "appNotifications": MessageLookupByLibrary.simpleMessage("앱 알림"),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "앱 알림을 위한 알림 채널",
    ),
    "at7AM": MessageLookupByLibrary.simpleMessage("오전 7시"),
    "backup": MessageLookupByLibrary.simpleMessage("백업"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "백업을 성공적으로 생성했습니다!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage("백업에 실패했습니다!"),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "오류: 백업 생성에 실패했습니다.",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage("체크형 (예/아니오)"),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage("커피 한 잔 후원하기"),
    "cancel": MessageLookupByLibrary.simpleMessage("취소"),
    "check": MessageLookupByLibrary.simpleMessage("완료"),
    "close": MessageLookupByLibrary.simpleMessage("닫기"),
    "complete": MessageLookupByLibrary.simpleMessage("완료"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage("축하합니다! 보상:"),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("생성"),
    "createHabit": MessageLookupByLibrary.simpleMessage("습관 생성"),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "첫 번째 습관을 생성하세요.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("신호"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "은 습관을 시작하게 만드는 계기입니다. 특정 시간, 장소, 기분, 또는 이벤트일 수 있습니다.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. 신호"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("현재 연속 기록"),
    "dan": MessageLookupByLibrary.simpleMessage("홍길동"),
    "date": MessageLookupByLibrary.simpleMessage("날짜"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage("습관 구체화하기"),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "습관을 더 잘 지키기 위해 다음 항목을 설정할 수 있습니다:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("삭제"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("책임 한계 고지"),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("팔굽혀펴기 50회 하기"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "습관을 체크하는 것을 잊지 마세요.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage("자선 단체에 10달러 기부하기"),
    "done": MessageLookupByLibrary.simpleMessage("완료"),
    "editHabit": MessageLookupByLibrary.simpleMessage("습관 수정"),
    "emptyList": MessageLookupByLibrary.simpleMessage("목록이 비어 있습니다"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("수량 입력"),
    "exercise": MessageLookupByLibrary.simpleMessage("운동"),
    "fail": MessageLookupByLibrary.simpleMessage("실패"),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "비디오 게임 15분 하기",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage("파일을 찾을 수 없습니다"),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "파일 용량이 너무 큽니다 (최대 10MB)",
    ),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage("한 주의 시작 요일"),
    "habit": MessageLookupByLibrary.simpleMessage("습관"),
    "habitContract": MessageLookupByLibrary.simpleMessage("습관 계약"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "긍정적 강화가 권장되지만, 습관 계약을 활용할 수도 있습니다. 습관 계약은 습관을 지키지 못했을 때 적용할 제재 사항을 지정하고, 목표 이행을 함께 감독해 줄 조력자를 지정하는 방식입니다.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("습관이 삭제되었습니다."),
    "habitLoop": MessageLookupByLibrary.simpleMessage("습관 루프"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "습관 루프는 습관이 형성되는 과정을 설명하는 심리학 모델입니다. 신호, 반복 행동, 보상이라는 세 가지 요소로 구성됩니다. 신호가 반복 행동(습관적 행동)을 유발하고, 이는 보상을 통해 강화되어 습관이 더욱 정착되고 반복되기 쉽게 만드는 루프를 형성합니다.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage("습관 알림"),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "습관 알림을 위한 알림 채널",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "습관 이름을 입력해 주세요.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("습관 유형"),
    "habits": MessageLookupByLibrary.simpleMessage("습관:"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo가 정상적으로 작동하려면 알림 권한이 필요합니다.",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Habo를 후원하고 싶다면:",
    ),
    "input": MessageLookupByLibrary.simpleMessage("직접 입력"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "올바르지 않은 백업 파일입니다",
    ),
    "logYourDays": MessageLookupByLibrary.simpleMessage("일상 기록하기"),
    "modify": MessageLookupByLibrary.simpleMessage("수정"),
    "month": MessageLookupByLibrary.simpleMessage("월"),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage("습관 데이터가 없습니다."),
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("아쉬운 성과"),
    "note": MessageLookupByLibrary.simpleMessage("메모"),
    "notificationTime": MessageLookupByLibrary.simpleMessage("알림 시간"),
    "notifications": MessageLookupByLibrary.simpleMessage("알림"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("수치형"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "수치형 습관을 사용하면 하루 동안 조금씩 진행 상황을 기록할 수 있습니다.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage("진행 상황 관찰하기"),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage("이런! 제재 사항:"),
    "onboarding": MessageLookupByLibrary.simpleMessage("온보딩"),
    "partialValue": MessageLookupByLibrary.simpleMessage("중간값 / 부분 달성값"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("개인정보 처리방침"),
    "progress": MessageLookupByLibrary.simpleMessage("진행 상황"),
    "progressOf": m13,
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "반복 행동을 성공적으로 마친 후 표시되는 보상 알림입니다.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "반복 행동에 실패했을 때 표시되는 제재 알림입니다.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("재설정"),
    "restore": MessageLookupByLibrary.simpleMessage("복원"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "복원을 성공적으로 완료했습니다!",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage("복원에 실패했습니다!"),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "오류: 백업 복원에 실패했습니다.",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("보상"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "은 반복 행동을 마친 후 느끼는 이점이나 긍정적인 기분입니다. 이는 습관을 강화해 줍니다.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. 보상"),
    "routine": MessageLookupByLibrary.simpleMessage("반복 행동"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "은 신호에 반응하여 취하는 행동입니다. 이것이 습관 그 자체입니다.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. 반복 행동"),
    "sanction": MessageLookupByLibrary.simpleMessage("제재"),
    "save": MessageLookupByLibrary.simpleMessage("저장"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("진행 상황 저장"),
    "setColors": MessageLookupByLibrary.simpleMessage("색상 설정"),
    "settings": MessageLookupByLibrary.simpleMessage("설정"),
    "showMonthName": MessageLookupByLibrary.simpleMessage("월 이름 표시"),
    "showReward": MessageLookupByLibrary.simpleMessage("보상 표시"),
    "showSanction": MessageLookupByLibrary.simpleMessage("제재 표시"),
    "skip": MessageLookupByLibrary.simpleMessage("건너뛰기"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "건너뛰기 (연속 기록에 영향 없음)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("슬라이더"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("효과음"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("소스 코드 (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("통계"),
    "successful": MessageLookupByLibrary.simpleMessage("성공"),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("목표값"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage("이용약관"),
    "theme": MessageLookupByLibrary.simpleMessage("테마"),
    "themeSelect": m0,
    "topStreak": MessageLookupByLibrary.simpleMessage("최고 연속 기록"),
    "total": MessageLookupByLibrary.simpleMessage("전체"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "각 습관의 달력 뷰나 통계 페이지에서 진행 상황을 확인할 수 있습니다.",
    ),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("이틀 법칙"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "이틀 법칙을 사용하면 하루를 거르더라도 다음 날 성공할 경우 연속 기록이 유지됩니다.",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("실행 취소"),
    "unit": MessageLookupByLibrary.simpleMessage("단위"),
    "unknown": MessageLookupByLibrary.simpleMessage("알 수 없음"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage("\'이틀 법칙\' 적용"),
    "warning": MessageLookupByLibrary.simpleMessage("경고"),
    "week": MessageLookupByLibrary.simpleMessage("주"),
    "yourCommentHere": MessageLookupByLibrary.simpleMessage("여기에 메모를 입력하세요"),
  };
}
