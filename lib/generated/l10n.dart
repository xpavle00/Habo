// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Habits:`
  String get habits {
    return Intl.message(
      'Habits:',
      name: 'habits',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Empty list`
  String get emptyList {
    return Intl.message(
      'Empty list',
      name: 'emptyList',
      desc: '',
      args: [],
    );
  }

  /// `There are no data about habits.`
  String get noDataAboutHabits {
    return Intl.message(
      'There are no data about habits.',
      name: 'noDataAboutHabits',
      desc: '',
      args: [],
    );
  }

  /// `Top streak`
  String get topStreak {
    return Intl.message(
      'Top streak',
      name: 'topStreak',
      desc: '',
      args: [],
    );
  }

  /// `Actual streak`
  String get actualStreak {
    return Intl.message(
      'Actual streak',
      name: 'actualStreak',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `All habits will be replaced with habits from backup.`
  String get allHabitsWillBeReplaced {
    return Intl.message(
      'All habits will be replaced with habits from backup.',
      name: 'allHabitsWillBeReplaced',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message(
      'Restore',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `First day of the week`
  String get firstDayOfWeek {
    return Intl.message(
      'First day of the week',
      name: 'firstDayOfWeek',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Notification time`
  String get notificationTime {
    return Intl.message(
      'Notification time',
      name: 'notificationTime',
      desc: '',
      args: [],
    );
  }

  /// `Sound effects`
  String get soundEffects {
    return Intl.message(
      'Sound effects',
      name: 'soundEffects',
      desc: '',
      args: [],
    );
  }

  /// `Show month name`
  String get showMonthName {
    return Intl.message(
      'Show month name',
      name: 'showMonthName',
      desc: '',
      args: [],
    );
  }

  /// `Set colors`
  String get setColors {
    return Intl.message(
      'Set colors',
      name: 'setColors',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message(
      'Backup',
      name: 'backup',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Onboarding`
  String get onboarding {
    return Intl.message(
      'Onboarding',
      name: 'onboarding',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Habo`
  String get habo {
    return Intl.message(
      'Habo',
      name: 'habo',
      desc: '',
      args: [],
    );
  }

  /// `©2023 Habo`
  String get copyright {
    return Intl.message(
      '©2023 Habo',
      name: 'copyright',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions\n`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions\n',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy\n`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy\n',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Disclaimer\n`
  String get disclaimer {
    return Intl.message(
      'Disclaimer\n',
      name: 'disclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Source code (GitHub)\n`
  String get sourceCode {
    return Intl.message(
      'Source code (GitHub)\n',
      name: 'sourceCode',
      desc: '',
      args: [],
    );
  }

  /// `Buy me a coffee\n`
  String get buyMeACoffee {
    return Intl.message(
      'Buy me a coffee\n',
      name: 'buyMeACoffee',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Congratulation! Your reward:\n{reward}`
  String congratulationReward(String reward) {
    return Intl.message(
      'Congratulation! Your reward:\n$reward',
      name: 'congratulationReward',
      desc: '',
      args: [reward],
    );
  }

  /// `Oh no! Your sanction:\n{sanction}`
  String ohNoSanction(String sanction) {
    return Intl.message(
      'Oh no! Your sanction:\n$sanction',
      name: 'ohNoSanction',
      desc: '',
      args: [sanction],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Habit loop`
  String get habitLoop {
    return Intl.message(
      'Habit loop',
      name: 'habitLoop',
      desc: '',
      args: [],
    );
  }

  /// `Habit Loop is a psychological model describing the process of habit formation. It consists of three components: Cue, Routine, and Reward. The Cue triggers the Routine (habitual action), which is then reinforced by the Reward, creating a loop that makes the habit more ingrained and likely to be repeated.\n\n`
  String get habitLoopDescription {
    return Intl.message(
      'Habit Loop is a psychological model describing the process of habit formation. It consists of three components: Cue, Routine, and Reward. The Cue triggers the Routine (habitual action), which is then reinforced by the Reward, creating a loop that makes the habit more ingrained and likely to be repeated.\n\n',
      name: 'habitLoopDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cue`
  String get cue {
    return Intl.message(
      'Cue',
      name: 'cue',
      desc: '',
      args: [],
    );
  }

  /// ` is the trigger that initiates your habit. It could be a specific time, location, feeling, or an event.\n\n`
  String get cueDescription {
    return Intl.message(
      ' is the trigger that initiates your habit. It could be a specific time, location, feeling, or an event.\n\n',
      name: 'cueDescription',
      desc: '',
      args: [],
    );
  }

  /// `Routine`
  String get routine {
    return Intl.message(
      'Routine',
      name: 'routine',
      desc: '',
      args: [],
    );
  }

  /// ` is the action you take in response to the cue. This is the habit itself.\n\n`
  String get routineDescription {
    return Intl.message(
      ' is the action you take in response to the cue. This is the habit itself.\n\n',
      name: 'routineDescription',
      desc: '',
      args: [],
    );
  }

  /// `Reward`
  String get reward {
    return Intl.message(
      'Reward',
      name: 'reward',
      desc: '',
      args: [],
    );
  }

  /// ` is the benefit or positive feeling you experience after performing the routine. It reinforces the habit.`
  String get rewardDescription {
    return Intl.message(
      ' is the benefit or positive feeling you experience after performing the routine. It reinforces the habit.',
      name: 'rewardDescription',
      desc: '',
      args: [],
    );
  }

  /// `Edit Habit`
  String get editHabit {
    return Intl.message(
      'Edit Habit',
      name: 'editHabit',
      desc: '',
      args: [],
    );
  }

  /// `Create Habit`
  String get createHabit {
    return Intl.message(
      'Create Habit',
      name: 'createHabit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `The habit title can not be empty.`
  String get habitTitleEmptyError {
    return Intl.message(
      'The habit title can not be empty.',
      name: 'habitTitleEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get exercise {
    return Intl.message(
      'Exercise',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `Habit`
  String get habit {
    return Intl.message(
      'Habit',
      name: 'habit',
      desc: '',
      args: [],
    );
  }

  /// `Use Two day rule`
  String get useTwoDayRule {
    return Intl.message(
      'Use Two day rule',
      name: 'useTwoDayRule',
      desc: '',
      args: [],
    );
  }

  /// `Two day rule`
  String get twoDayRule {
    return Intl.message(
      'Two day rule',
      name: 'twoDayRule',
      desc: '',
      args: [],
    );
  }

  /// `With two day rule, you can miss one day and do not lose a streak if the next day is successful.`
  String get twoDayRuleDescription {
    return Intl.message(
      'With two day rule, you can miss one day and do not lose a streak if the next day is successful.',
      name: 'twoDayRuleDescription',
      desc: '',
      args: [],
    );
  }

  /// `Advanced habit building`
  String get advancedHabitBuilding {
    return Intl.message(
      'Advanced habit building',
      name: 'advancedHabitBuilding',
      desc: '',
      args: [],
    );
  }

  /// `This section helps you better define your habits utilizing the Habit loop. You should define cues, routines, and rewards for every habit.`
  String get advancedHabitBuildingDescription {
    return Intl.message(
      'This section helps you better define your habits utilizing the Habit loop. You should define cues, routines, and rewards for every habit.',
      name: 'advancedHabitBuildingDescription',
      desc: '',
      args: [],
    );
  }

  /// `At 7:00AM`
  String get at7AM {
    return Intl.message(
      'At 7:00AM',
      name: 'at7AM',
      desc: '',
      args: [],
    );
  }

  /// `Do 50 push ups`
  String get do50PushUps {
    return Intl.message(
      'Do 50 push ups',
      name: 'do50PushUps',
      desc: '',
      args: [],
    );
  }

  /// `15 min. of video games`
  String get fifteenMinOfVideoGames {
    return Intl.message(
      '15 min. of video games',
      name: 'fifteenMinOfVideoGames',
      desc: '',
      args: [],
    );
  }

  /// `Show reward`
  String get showReward {
    return Intl.message(
      'Show reward',
      name: 'showReward',
      desc: '',
      args: [],
    );
  }

  /// `The remainder of the reward after a successful routine.`
  String get remainderOfReward {
    return Intl.message(
      'The remainder of the reward after a successful routine.',
      name: 'remainderOfReward',
      desc: '',
      args: [],
    );
  }

  /// `Habit contract`
  String get habitContract {
    return Intl.message(
      'Habit contract',
      name: 'habitContract',
      desc: '',
      args: [],
    );
  }

  /// `While positive reinforcement is recommended, some people may opt for a habit contract. A habit contract allows you to specify a sanction that will be imposed if you miss your habit, and may involve an accountability partner who helps supervise your goals.`
  String get habitContractDescription {
    return Intl.message(
      'While positive reinforcement is recommended, some people may opt for a habit contract. A habit contract allows you to specify a sanction that will be imposed if you miss your habit, and may involve an accountability partner who helps supervise your goals.',
      name: 'habitContractDescription',
      desc: '',
      args: [],
    );
  }

  /// `Donate 10$ to charity`
  String get donateToCharity {
    return Intl.message(
      'Donate 10\$ to charity',
      name: 'donateToCharity',
      desc: '',
      args: [],
    );
  }

  /// `Sanction`
  String get sanction {
    return Intl.message(
      'Sanction',
      name: 'sanction',
      desc: '',
      args: [],
    );
  }

  /// `Show sanction`
  String get showSanction {
    return Intl.message(
      'Show sanction',
      name: 'showSanction',
      desc: '',
      args: [],
    );
  }

  /// `The remainder of the sanction after a unsuccessful routine.`
  String get remainderOfSanction {
    return Intl.message(
      'The remainder of the sanction after a unsuccessful routine.',
      name: 'remainderOfSanction',
      desc: '',
      args: [],
    );
  }

  /// `Dan`
  String get dan {
    return Intl.message(
      'Dan',
      name: 'dan',
      desc: '',
      args: [],
    );
  }

  /// `Accountability partner`
  String get accountabilityPartner {
    return Intl.message(
      'Accountability partner',
      name: 'accountabilityPartner',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Habo needs permission to send notifications to work properly.`
  String get haboNeedsPermission {
    return Intl.message(
      'Habo needs permission to send notifications to work properly.',
      name: 'haboNeedsPermission',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message(
      'Allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get check {
    return Intl.message(
      'Check',
      name: 'check',
      desc: '',
      args: [],
    );
  }

  /// `Fail`
  String get fail {
    return Intl.message(
      'Fail',
      name: 'fail',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Your comment here`
  String get yourCommentHere {
    return Intl.message(
      'Your comment here',
      name: 'yourCommentHere',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Create your first habit.`
  String get createYourFirstHabit {
    return Intl.message(
      'Create your first habit.',
      name: 'createYourFirstHabit',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get modify {
    return Intl.message(
      'Modify',
      name: 'modify',
      desc: '',
      args: [],
    );
  }

  /// `ERROR: Creating backup failed.`
  String get backupFailedError {
    return Intl.message(
      'ERROR: Creating backup failed.',
      name: 'backupFailedError',
      desc: '',
      args: [],
    );
  }

  /// `ERROR: Restoring backup failed.`
  String get restoreFailedError {
    return Intl.message(
      'ERROR: Restoring backup failed.',
      name: 'restoreFailedError',
      desc: '',
      args: [],
    );
  }

  /// `Habit deleted.`
  String get habitDeleted {
    return Intl.message(
      'Habit deleted.',
      name: 'habitDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `App notifications`
  String get appNotifications {
    return Intl.message(
      'App notifications',
      name: 'appNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Notification channel for application notifications`
  String get appNotificationsChannel {
    return Intl.message(
      'Notification channel for application notifications',
      name: 'appNotificationsChannel',
      desc: '',
      args: [],
    );
  }

  /// `Habit notifications`
  String get habitNotifications {
    return Intl.message(
      'Habit notifications',
      name: 'habitNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Notification channel for habit notifications`
  String get habitNotificationsChannel {
    return Intl.message(
      'Notification channel for habit notifications',
      name: 'habitNotificationsChannel',
      desc: '',
      args: [],
    );
  }

  /// `Do not forget to check your habits.`
  String get doNotForgetToCheckYourHabits {
    return Intl.message(
      'Do not forget to check your habits.',
      name: 'doNotForgetToCheckYourHabits',
      desc: '',
      args: [],
    );
  }

  /// `{theme, select, device {Device} light {Light} dark {Dark} oled {Oled black} other{}}`
  String themeSelect(String theme) {
    return Intl.select(
      theme,
      {
        'device': 'Device',
        'light': 'Light',
        'dark': 'Dark',
        'oled': 'Oled black',
        'other': '',
      },
      name: 'themeSelect',
      desc: '',
      args: [theme],
    );
  }

  /// `Define your habits`
  String get defineYourHabits {
    return Intl.message(
      'Define your habits',
      name: 'defineYourHabits',
      desc: '',
      args: [],
    );
  }

  /// `To better stick to your habits, you can define:`
  String get defineYourHabitsDescription {
    return Intl.message(
      'To better stick to your habits, you can define:',
      name: 'defineYourHabitsDescription',
      desc: '',
      args: [],
    );
  }

  /// `1. Cue`
  String get cueNumbered {
    return Intl.message(
      '1. Cue',
      name: 'cueNumbered',
      desc: '',
      args: [],
    );
  }

  /// `2. Routine`
  String get routineNumbered {
    return Intl.message(
      '2. Routine',
      name: 'routineNumbered',
      desc: '',
      args: [],
    );
  }

  /// `3. Reward`
  String get rewardNumbered {
    return Intl.message(
      '3. Reward',
      name: 'rewardNumbered',
      desc: '',
      args: [],
    );
  }

  /// `Log your days`
  String get logYourDays {
    return Intl.message(
      'Log your days',
      name: 'logYourDays',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get successful {
    return Intl.message(
      'Successful',
      name: 'successful',
      desc: '',
      args: [],
    );
  }

  /// `Not so successful`
  String get notSoSuccessful {
    return Intl.message(
      'Not so successful',
      name: 'notSoSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Skip (does not affect streaks)`
  String get skipDoesNotAffectStreaks {
    return Intl.message(
      'Skip (does not affect streaks)',
      name: 'skipDoesNotAffectStreaks',
      desc: '',
      args: [],
    );
  }

  /// `Observe your progress`
  String get observeYourProgress {
    return Intl.message(
      'Observe your progress',
      name: 'observeYourProgress',
      desc: '',
      args: [],
    );
  }

  /// `You can track your progress through the calendar view in every habit or on the statistics page.`
  String get trackYourProgress {
    return Intl.message(
      'You can track your progress through the calendar view in every habit or on the statistics page.',
      name: 'trackYourProgress',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
