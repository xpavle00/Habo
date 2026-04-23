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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Habits:`
  String get habits {
    return Intl.message('Habits:', name: 'habits', desc: '', args: []);
  }

  /// `Statistics`
  String get statistics {
    return Intl.message('Statistics', name: 'statistics', desc: '', args: []);
  }

  /// `Empty list`
  String get emptyList {
    return Intl.message('Empty list', name: 'emptyList', desc: '', args: []);
  }

  /// `There is no data about habits.`
  String get noDataAboutHabits {
    return Intl.message(
      'There is no data about habits.',
      name: 'noDataAboutHabits',
      desc: '',
      args: [],
    );
  }

  /// `Top streak`
  String get topStreak {
    return Intl.message('Top streak', name: 'topStreak', desc: '', args: []);
  }

  /// `Current streak`
  String get currentStreak {
    return Intl.message(
      'Current streak',
      name: 'currentStreak',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Warning`
  String get warning {
    return Intl.message('Warning', name: 'warning', desc: '', args: []);
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
    return Intl.message('Restore', name: 'restore', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
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
    return Intl.message('Set colors', name: 'setColors', desc: '', args: []);
  }

  /// `Backup`
  String get backup {
    return Intl.message('Backup', name: 'backup', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Onboarding`
  String get onboarding {
    return Intl.message('Onboarding', name: 'onboarding', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Habo`
  String get habo {
    return Intl.message('Habo', name: 'habo', desc: '', args: []);
  }

  /// `©2023 Habo`
  String get copyright {
    return Intl.message('©2023 Habo', name: 'copyright', desc: '', args: []);
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Disclaimer`
  String get disclaimer {
    return Intl.message('Disclaimer', name: 'disclaimer', desc: '', args: []);
  }

  /// `Source code (GitHub)`
  String get sourceCode {
    return Intl.message(
      'Source code (GitHub)',
      name: 'sourceCode',
      desc: '',
      args: [],
    );
  }

  /// `If you want to support Habo you can:`
  String get ifYouWantToSupport {
    return Intl.message(
      'If you want to support Habo you can:',
      name: 'ifYouWantToSupport',
      desc: '',
      args: [],
    );
  }

  /// `Buy me a coffee`
  String get buyMeACoffee {
    return Intl.message(
      'Buy me a coffee',
      name: 'buyMeACoffee',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Congratulations! Your reward:`
  String get congratulationsReward {
    return Intl.message(
      'Congratulations! Your reward:',
      name: 'congratulationsReward',
      desc: '',
      args: [],
    );
  }

  /// `Oh no! Your sanction:`
  String get ohNoSanction {
    return Intl.message(
      'Oh no! Your sanction:',
      name: 'ohNoSanction',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message('Month', name: 'month', desc: '', args: []);
  }

  /// `Week`
  String get week {
    return Intl.message('Week', name: 'week', desc: '', args: []);
  }

  /// `Habit loop`
  String get habitLoop {
    return Intl.message('Habit loop', name: 'habitLoop', desc: '', args: []);
  }

  /// `Habit Loop is a psychological model describing the process of habit formation. It consists of three components: Cue, Routine, and Reward. The Cue triggers the Routine (habitual action), which is then reinforced by the Reward, creating a loop that makes the habit more ingrained and likely to be repeated.`
  String get habitLoopDescription {
    return Intl.message(
      'Habit Loop is a psychological model describing the process of habit formation. It consists of three components: Cue, Routine, and Reward. The Cue triggers the Routine (habitual action), which is then reinforced by the Reward, creating a loop that makes the habit more ingrained and likely to be repeated.',
      name: 'habitLoopDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cue`
  String get cue {
    return Intl.message('Cue', name: 'cue', desc: '', args: []);
  }

  /// `is the trigger that initiates your habit. It could be a specific time, location, feeling, or an event.`
  String get cueDescription {
    return Intl.message(
      'is the trigger that initiates your habit. It could be a specific time, location, feeling, or an event.',
      name: 'cueDescription',
      desc: '',
      args: [],
    );
  }

  /// `Routine`
  String get routine {
    return Intl.message('Routine', name: 'routine', desc: '', args: []);
  }

  /// `is the action you take in response to the cue. This is the habit itself.`
  String get routineDescription {
    return Intl.message(
      'is the action you take in response to the cue. This is the habit itself.',
      name: 'routineDescription',
      desc: '',
      args: [],
    );
  }

  /// `Reward`
  String get reward {
    return Intl.message('Reward', name: 'reward', desc: '', args: []);
  }

  /// `is the benefit or positive feeling you experience after performing the routine. It reinforces the habit.`
  String get rewardDescription {
    return Intl.message(
      'is the benefit or positive feeling you experience after performing the routine. It reinforces the habit.',
      name: 'rewardDescription',
      desc: '',
      args: [],
    );
  }

  /// `Edit Habit`
  String get editHabit {
    return Intl.message('Edit Habit', name: 'editHabit', desc: '', args: []);
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
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
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
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Exercise`
  String get exercise {
    return Intl.message('Exercise', name: 'exercise', desc: '', args: []);
  }

  /// `Habit`
  String get habit {
    return Intl.message('Habit', name: 'habit', desc: '', args: []);
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
    return Intl.message('Two day rule', name: 'twoDayRule', desc: '', args: []);
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
    return Intl.message('At 7:00AM', name: 'at7AM', desc: '', args: []);
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
    return Intl.message('Show reward', name: 'showReward', desc: '', args: []);
  }

  /// `The reminder of the reward after a successful routine.`
  String get remainderOfReward {
    return Intl.message(
      'The reminder of the reward after a successful routine.',
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
    return Intl.message('Sanction', name: 'sanction', desc: '', args: []);
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

  /// `The reminder of the sanction after a unsuccessful routine.`
  String get remainderOfSanction {
    return Intl.message(
      'The reminder of the sanction after a unsuccessful routine.',
      name: 'remainderOfSanction',
      desc: '',
      args: [],
    );
  }

  /// `Dan`
  String get dan {
    return Intl.message('Dan', name: 'dan', desc: '', args: []);
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
    return Intl.message('Add', name: 'add', desc: '', args: []);
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
    return Intl.message('Allow', name: 'allow', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Check`
  String get check {
    return Intl.message('Check', name: 'check', desc: '', args: []);
  }

  /// `Fail`
  String get fail {
    return Intl.message('Fail', name: 'fail', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Note`
  String get note {
    return Intl.message('Note', name: 'note', desc: '', args: []);
  }

  /// `Your note here`
  String get yourCommentHere {
    return Intl.message(
      'Your note here',
      name: 'yourCommentHere',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
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
    return Intl.message('Modify', name: 'modify', desc: '', args: []);
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
    return Intl.message('Undo', name: 'undo', desc: '', args: []);
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

  /// `{theme, select, device {Device} light {Light} dark {Dark} oled {OLED black} materialYou {Material You} other{Device}}`
  String themeSelect(String theme) {
    return Intl.select(
      theme,
      {
        'device': 'Device',
        'light': 'Light',
        'dark': 'Dark',
        'oled': 'OLED black',
        'materialYou': 'Material You',
        'other': 'Device',
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
    return Intl.message('1. Cue', name: 'cueNumbered', desc: '', args: []);
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
    return Intl.message('Successful', name: 'successful', desc: '', args: []);
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

  /// `Backup created successfully!`
  String get backupCreatedSuccessfully {
    return Intl.message(
      'Backup created successfully!',
      name: 'backupCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Backup failed!`
  String get backupFailed {
    return Intl.message(
      'Backup failed!',
      name: 'backupFailed',
      desc: '',
      args: [],
    );
  }

  /// `Restore completed successfully!`
  String get restoreCompletedSuccessfully {
    return Intl.message(
      'Restore completed successfully!',
      name: 'restoreCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Restore failed!`
  String get restoreFailed {
    return Intl.message(
      'Restore failed!',
      name: 'restoreFailed',
      desc: '',
      args: [],
    );
  }

  /// `File not found`
  String get fileNotFound {
    return Intl.message(
      'File not found',
      name: 'fileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `File too large (max 10MB)`
  String get fileTooLarge {
    return Intl.message(
      'File too large (max 10MB)',
      name: 'fileTooLarge',
      desc: '',
      args: [],
    );
  }

  /// `Invalid backup file`
  String get invalidBackupFile {
    return Intl.message(
      'Invalid backup file',
      name: 'invalidBackupFile',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message('Progress', name: 'progress', desc: '', args: []);
  }

  /// `Enter amount`
  String get enterAmount {
    return Intl.message(
      'Enter amount',
      name: 'enterAmount',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message('Complete', name: 'complete', desc: '', args: []);
  }

  /// `Save Progress`
  String get saveProgress {
    return Intl.message(
      'Save Progress',
      name: 'saveProgress',
      desc: '',
      args: [],
    );
  }

  /// `Current: {current} {unit}`
  String currentProgress(String current, String unit) {
    return Intl.message(
      'Current: $current $unit',
      name: 'currentProgress',
      desc: '',
      args: [current, unit],
    );
  }

  /// `Target: {target} {unit}`
  String targetProgress(String target, String unit) {
    return Intl.message(
      'Target: $target $unit',
      name: 'targetProgress',
      desc: '',
      args: [target, unit],
    );
  }

  /// `{current} / {target} {unit}`
  String progressOf(String current, String target, String unit) {
    return Intl.message(
      '$current / $target $unit',
      name: 'progressOf',
      desc: '',
      args: [current, target, unit],
    );
  }

  /// `Progressive`
  String get numericHabit {
    return Intl.message(
      'Progressive',
      name: 'numericHabit',
      desc: '',
      args: [],
    );
  }

  /// `Target value`
  String get targetValue {
    return Intl.message(
      'Target value',
      name: 'targetValue',
      desc: '',
      args: [],
    );
  }

  /// `Partial value`
  String get partialValue {
    return Intl.message(
      'Partial value',
      name: 'partialValue',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message('Unit', name: 'unit', desc: '', args: []);
  }

  /// `Habit type`
  String get habitType {
    return Intl.message('Habit type', name: 'habitType', desc: '', args: []);
  }

  /// `Checkable (Yes/No)`
  String get booleanHabit {
    return Intl.message(
      'Checkable (Yes/No)',
      name: 'booleanHabit',
      desc: '',
      args: [],
    );
  }

  /// `Slider`
  String get slider {
    return Intl.message('Slider', name: 'slider', desc: '', args: []);
  }

  /// `Input`
  String get input {
    return Intl.message('Input', name: 'input', desc: '', args: []);
  }

  /// `Numeric habits let you track progress in increments throughout the day.`
  String get numericHabitDescription {
    return Intl.message(
      'Numeric habits let you track progress in increments throughout the day.',
      name: 'numericHabitDescription',
      desc: '',
      args: [],
    );
  }

  /// `To track progress in smaller increments`
  String get partialValueDescription {
    return Intl.message(
      'To track progress in smaller increments',
      name: 'partialValueDescription',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Edit Category`
  String get editCategory {
    return Intl.message(
      'Edit Category',
      name: 'editCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `No categories yet`
  String get noCategoriesYet {
    return Intl.message(
      'No categories yet',
      name: 'noCategoriesYet',
      desc: '',
      args: [],
    );
  }

  /// `Create your first category to organize your habits`
  String get createFirstCategory {
    return Intl.message(
      'Create your first category to organize your habits',
      name: 'createFirstCategory',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a category title`
  String get pleaseEnterCategoryTitle {
    return Intl.message(
      'Please enter a category title',
      name: 'pleaseEnterCategoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Category "{title}" already exists`
  String categoryAlreadyExists(String title) {
    return Intl.message(
      'Category "$title" already exists',
      name: 'categoryAlreadyExists',
      desc: '',
      args: [title],
    );
  }

  /// `Category "{title}" created successfully`
  String categoryCreatedSuccessfully(String title) {
    return Intl.message(
      'Category "$title" created successfully',
      name: 'categoryCreatedSuccessfully',
      desc: '',
      args: [title],
    );
  }

  /// `Category "{title}" updated successfully`
  String categoryUpdatedSuccessfully(String title) {
    return Intl.message(
      'Category "$title" updated successfully',
      name: 'categoryUpdatedSuccessfully',
      desc: '',
      args: [title],
    );
  }

  /// `Category "{title}" deleted successfully`
  String categoryDeletedSuccessfully(String title) {
    return Intl.message(
      'Category "$title" deleted successfully',
      name: 'categoryDeletedSuccessfully',
      desc: '',
      args: [title],
    );
  }

  /// `Failed to save category: {error}`
  String failedToSaveCategory(String error) {
    return Intl.message(
      'Failed to save category: $error',
      name: 'failedToSaveCategory',
      desc: '',
      args: [error],
    );
  }

  /// `Failed to delete category: {error}`
  String failedToDeleteCategory(String error) {
    return Intl.message(
      'Failed to delete category: $error',
      name: 'failedToDeleteCategory',
      desc: '',
      args: [error],
    );
  }

  /// `Select Categories`
  String get selectCategories {
    return Intl.message(
      'Select Categories',
      name: 'selectCategories',
      desc: '',
      args: [],
    );
  }

  /// `Selected Categories ({count})`
  String selectedCategories(int count) {
    return Intl.message(
      'Selected Categories ($count)',
      name: 'selectedCategories',
      desc: '',
      args: [count],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Delete Category`
  String get deleteCategory {
    return Intl.message(
      'Delete Category',
      name: 'deleteCategory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete "{title}"?\n\nThis will remove the category from all habits that use it.`
  String deleteCategoryConfirmation(String title) {
    return Intl.message(
      'Are you sure you want to delete "$title"?\n\nThis will remove the category from all habits that use it.',
      name: 'deleteCategoryConfirmation',
      desc: '',
      args: [title],
    );
  }

  /// `No habits in "{title}"`
  String noHabitsInCategory(String title) {
    return Intl.message(
      'No habits in "$title"',
      name: 'noHabitsInCategory',
      desc: '',
      args: [title],
    );
  }

  /// `Create a habit and assign it to this category`
  String get createHabitForCategory {
    return Intl.message(
      'Create a habit and assign it to this category',
      name: 'createHabitForCategory',
      desc: '',
      args: [],
    );
  }

  /// `Show Categories`
  String get showCategories {
    return Intl.message(
      'Show Categories',
      name: 'showCategories',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive {
    return Intl.message('Archive', name: 'archive', desc: '', args: []);
  }

  /// `Unarchive`
  String get unarchive {
    return Intl.message('Unarchive', name: 'unarchive', desc: '', args: []);
  }

  /// `Archive habit`
  String get archiveHabit {
    return Intl.message(
      'Archive habit',
      name: 'archiveHabit',
      desc: '',
      args: [],
    );
  }

  /// `Unarchive habit`
  String get unarchiveHabit {
    return Intl.message(
      'Unarchive habit',
      name: 'unarchiveHabit',
      desc: '',
      args: [],
    );
  }

  /// `Archived Habits`
  String get archivedHabits {
    return Intl.message(
      'Archived Habits',
      name: 'archivedHabits',
      desc: '',
      args: [],
    );
  }

  /// `No archived habits`
  String get noArchivedHabits {
    return Intl.message(
      'No archived habits',
      name: 'noArchivedHabits',
      desc: '',
      args: [],
    );
  }

  /// `View archived habits`
  String get viewArchivedHabits {
    return Intl.message(
      'View archived habits',
      name: 'viewArchivedHabits',
      desc: '',
      args: [],
    );
  }

  /// `Habit archived`
  String get habitArchived {
    return Intl.message(
      'Habit archived',
      name: 'habitArchived',
      desc: '',
      args: [],
    );
  }

  /// `Habit unarchived`
  String get habitUnarchived {
    return Intl.message(
      'Habit unarchived',
      name: 'habitUnarchived',
      desc: '',
      args: [],
    );
  }

  /// `Biometric`
  String get biometric {
    return Intl.message('Biometric', name: 'biometric', desc: '', args: []);
  }

  /// `Biometric lock enabled`
  String get biometricLockEnabled {
    return Intl.message(
      'Biometric lock enabled',
      name: 'biometricLockEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Biometric lock disabled`
  String get biometricLockDisabled {
    return Intl.message(
      'Biometric lock disabled',
      name: 'biometricLockDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Authentication error`
  String get authenticationError {
    return Intl.message(
      'Authentication error',
      name: 'authenticationError',
      desc: '',
      args: [],
    );
  }

  /// `Biometric authentication required`
  String get biometricAuthenticationRequired {
    return Intl.message(
      'Biometric authentication required',
      name: 'biometricAuthenticationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please set up your fingerprint or face unlock in device settings`
  String get setupFingerprintFaceUnlock {
    return Intl.message(
      'Please set up your fingerprint or face unlock in device settings',
      name: 'setupFingerprintFaceUnlock',
      desc: '',
      args: [],
    );
  }

  /// `Touch sensor`
  String get touchSensor {
    return Intl.message(
      'Touch sensor',
      name: 'touchSensor',
      desc: '',
      args: [],
    );
  }

  /// `Biometric not recognized, try again`
  String get biometricNotRecognized {
    return Intl.message(
      'Biometric not recognized, try again',
      name: 'biometricNotRecognized',
      desc: '',
      args: [],
    );
  }

  /// `Biometric required`
  String get biometricRequired {
    return Intl.message(
      'Biometric required',
      name: 'biometricRequired',
      desc: '',
      args: [],
    );
  }

  /// `Biometric authentication succeeded`
  String get biometricAuthenticationSucceeded {
    return Intl.message(
      'Biometric authentication succeeded',
      name: 'biometricAuthenticationSucceeded',
      desc: '',
      args: [],
    );
  }

  /// `Device credentials required`
  String get deviceCredentialsRequired {
    return Intl.message(
      'Device credentials required',
      name: 'deviceCredentialsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please set up device credentials in settings`
  String get setupDeviceCredentials {
    return Intl.message(
      'Please set up device credentials in settings',
      name: 'setupDeviceCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Please set up your Touch ID or Face ID in device settings`
  String get setupTouchIdFaceId {
    return Intl.message(
      'Please set up your Touch ID or Face ID in device settings',
      name: 'setupTouchIdFaceId',
      desc: '',
      args: [],
    );
  }

  /// `Please reenable your Touch ID or Face ID`
  String get reenableTouchIdFaceId {
    return Intl.message(
      'Please reenable your Touch ID or Face ID',
      name: 'reenableTouchIdFaceId',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Lock`
  String get biometricLock {
    return Intl.message(
      'Biometric Lock',
      name: 'biometricLock',
      desc: '',
      args: [],
    );
  }

  /// `Secure app with {authMethod}`
  String biometricLockDescription(String authMethod) {
    return Intl.message(
      'Secure app with $authMethod',
      name: 'biometricLockDescription',
      desc: '',
      args: [authMethod],
    );
  }

  /// `Authenticate to enable biometric lock`
  String get authenticateToEnable {
    return Intl.message(
      'Authenticate to enable biometric lock',
      name: 'authenticateToEnable',
      desc: '',
      args: [],
    );
  }

  /// `Please authenticate to access Habo`
  String get authenticateToAccess {
    return Intl.message(
      'Please authenticate to access Habo',
      name: 'authenticateToAccess',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Required`
  String get authenticationRequired {
    return Intl.message(
      'Authentication Required',
      name: 'authenticationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please authenticate to access Habo using {authMethod}`
  String authenticationFailedMessage(String authMethod) {
    return Intl.message(
      'Please authenticate to access Habo using $authMethod',
      name: 'authenticationFailedMessage',
      desc: '',
      args: [authMethod],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Authenticating…`
  String get authenticating {
    return Intl.message(
      'Authenticating…',
      name: 'authenticating',
      desc: '',
      args: [],
    );
  }

  /// `Authenticate`
  String get authenticate {
    return Intl.message(
      'Authenticate',
      name: 'authenticate',
      desc: '',
      args: [],
    );
  }

  /// `Building Better Habits`
  String get buildingBetterHabits {
    return Intl.message(
      'Building Better Habits',
      name: 'buildingBetterHabits',
      desc: '',
      args: [],
    );
  }

  /// `Please authenticate using {authMethod} to access your habits`
  String authenticationPrompt(String authMethod) {
    return Intl.message(
      'Please authenticate using $authMethod to access your habits',
      name: 'authenticationPrompt',
      desc: '',
      args: [authMethod],
    );
  }

  /// `Device PIN, Pattern, or Password`
  String get devicePinPatternPassword {
    return Intl.message(
      'Device PIN, Pattern, or Password',
      name: 'devicePinPatternPassword',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint`
  String get fingerprint {
    return Intl.message('Fingerprint', name: 'fingerprint', desc: '', args: []);
  }

  /// `Iris`
  String get iris {
    return Intl.message('Iris', name: 'iris', desc: '', args: []);
  }

  /// `What's New`
  String get whatsNewTitle {
    return Intl.message(
      'What\'s New',
      name: 'whatsNewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Version {version}`
  String whatsNewVersion(String version) {
    return Intl.message(
      'Version $version',
      name: 'whatsNewVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Numeric values in habits`
  String get featureNumericTitle {
    return Intl.message(
      'Numeric values in habits',
      name: 'featureNumericTitle',
      desc: '',
      args: [],
    );
  }

  /// `Track counts like glasses of water or pages read`
  String get featureNumericDesc {
    return Intl.message(
      'Track counts like glasses of water or pages read',
      name: 'featureNumericDesc',
      desc: '',
      args: [],
    );
  }

  /// `URL scheme (deep links)`
  String get featureDeepLinksTitle {
    return Intl.message(
      'URL scheme (deep links)',
      name: 'featureDeepLinksTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open Habo directly to screens like settings or create`
  String get featureDeepLinksDesc {
    return Intl.message(
      'Open Habo directly to screens like settings or create',
      name: 'featureDeepLinksDesc',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get featureCategoriesTitle {
    return Intl.message(
      'Categories',
      name: 'featureCategoriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Organize habits with category filters`
  String get featureCategoriesDesc {
    return Intl.message(
      'Organize habits with category filters',
      name: 'featureCategoriesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get featureArchiveTitle {
    return Intl.message(
      'Archive',
      name: 'featureArchiveTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hide habits you no longer track without deleting`
  String get featureArchiveDesc {
    return Intl.message(
      'Hide habits you no longer track without deleting',
      name: 'featureArchiveDesc',
      desc: '',
      args: [],
    );
  }

  /// `Material You theme (Android)`
  String get featureMaterialYouTitle {
    return Intl.message(
      'Material You theme (Android)',
      name: 'featureMaterialYouTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic colors that match your wallpaper`
  String get featureMaterialYouDesc {
    return Intl.message(
      'Dynamic colors that match your wallpaper',
      name: 'featureMaterialYouDesc',
      desc: '',
      args: [],
    );
  }

  /// `New sound engine`
  String get featureSoundTitle {
    return Intl.message(
      'New sound engine',
      name: 'featureSoundTitle',
      desc: '',
      args: [],
    );
  }

  /// `Adjustable volume`
  String get featureSoundDesc {
    return Intl.message(
      'Adjustable volume',
      name: 'featureSoundDesc',
      desc: '',
      args: [],
    );
  }

  /// `Lock feature`
  String get featureLockTitle {
    return Intl.message(
      'Lock feature',
      name: 'featureLockTitle',
      desc: '',
      args: [],
    );
  }

  /// `Secure the app with Face ID / Touch ID / biometrics`
  String get featureLockDesc {
    return Intl.message(
      'Secure the app with Face ID / Touch ID / biometrics',
      name: 'featureLockDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fixed sound mixing`
  String get featureIosSoundMixingTitle {
    return Intl.message(
      'Fixed sound mixing',
      name: 'featureIosSoundMixingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Habo sounds no longer interrupt your music or podcasts`
  String get featureIosSoundMixingDesc {
    return Intl.message(
      'Habo sounds no longer interrupt your music or podcasts',
      name: 'featureIosSoundMixingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Homescreen widget`
  String get featureHomescreenWidgetTitle {
    return Intl.message(
      'Homescreen widget',
      name: 'featureHomescreenWidgetTitle',
      desc: '',
      args: [],
    );
  }

  /// `View your habit progress at a glance from your home screen (experimental)`
  String get featureHomescreenWidgetDesc {
    return Intl.message(
      'View your habit progress at a glance from your home screen (experimental)',
      name: 'featureHomescreenWidgetDesc',
      desc: '',
      args: [],
    );
  }

  /// `Longpress check`
  String get featureLongpressCheckTitle {
    return Intl.message(
      'Longpress check',
      name: 'featureLongpressCheckTitle',
      desc: '',
      args: [],
    );
  }

  /// `Longpress on habit buttons to quickly change status`
  String get featureLongpressCheckDesc {
    return Intl.message(
      'Longpress on habit buttons to quickly change status',
      name: 'featureLongpressCheckDesc',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get haboSyncComingSoon {
    return Intl.message(
      'Coming Soon',
      name: 'haboSyncComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Habo Sync is here! Sync and backup your habits across all your devices with end-to-end encrypted cloud sync.`
  String get haboSyncDescription {
    return Intl.message(
      'Habo Sync is here! Sync and backup your habits across all your devices with end-to-end encrypted cloud sync.',
      name: 'haboSyncDescription',
      desc: '',
      args: [],
    );
  }

  /// `Learn more at habo.space/sync`
  String get haboSyncLearnMore {
    return Intl.message(
      'Learn more at habo.space/sync',
      name: 'haboSyncLearnMore',
      desc: '',
      args: [],
    );
  }

  /// `Habits today`
  String get habitsToday {
    return Intl.message(
      'Habits today',
      name: 'habitsToday',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Single tap to check`
  String get oneTapCheck {
    return Intl.message(
      'Single tap to check',
      name: 'oneTapCheck',
      desc: '',
      args: [],
    );
  }

  /// `Tap to check, long press for menu`
  String get tapCheckLongPressMenu {
    return Intl.message(
      'Tap to check, long press for menu',
      name: 'tapCheckLongPressMenu',
      desc: '',
      args: [],
    );
  }

  /// `Category name`
  String get categoryName {
    return Intl.message(
      'Category name',
      name: 'categoryName',
      desc: '',
      args: [],
    );
  }

  /// `Create category`
  String get createCategory {
    return Intl.message(
      'Create category',
      name: 'createCategory',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Pick an icon`
  String get selectIcon {
    return Intl.message('Pick an icon', name: 'selectIcon', desc: '', args: []);
  }

  /// `Search`
  String get searchIcons {
    return Intl.message('Search', name: 'searchIcons', desc: '', args: []);
  }

  /// `Sync`
  String get syncTitle {
    return Intl.message('Sync', name: 'syncTitle', desc: '', args: []);
  }

  /// `Sync and backup your data`
  String get syncAndBackupYourData {
    return Intl.message(
      'Sync and backup your data',
      name: 'syncAndBackupYourData',
      desc: '',
      args: [],
    );
  }

  /// `Server`
  String get server {
    return Intl.message('Server', name: 'server', desc: '', args: []);
  }

  /// `Custom server`
  String get customServer {
    return Intl.message(
      'Custom server',
      name: 'customServer',
      desc: '',
      args: [],
    );
  }

  /// `Habo Cloud (default)`
  String get haboCloudDefault {
    return Intl.message(
      'Habo Cloud (default)',
      name: 'haboCloudDefault',
      desc: '',
      args: [],
    );
  }

  /// `Sync not available`
  String get syncNotAvailable {
    return Intl.message(
      'Sync not available',
      name: 'syncNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Sync Now`
  String get syncNow {
    return Intl.message('Sync Now', name: 'syncNow', desc: '', args: []);
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message('Subscribe', name: 'subscribe', desc: '', args: []);
  }

  /// `Restore Backup?`
  String get restoreBackupQuestion {
    return Intl.message(
      'Restore Backup?',
      name: 'restoreBackupQuestion',
      desc: '',
      args: [],
    );
  }

  /// `{count} habits`
  String habitsCount(int count) {
    return Intl.message(
      '$count habits',
      name: 'habitsCount',
      desc: '',
      args: [count],
    );
  }

  /// `An unexpected error occurred`
  String get anUnexpectedErrorOccurred {
    return Intl.message(
      'An unexpected error occurred',
      name: 'anUnexpectedErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get anUnexpectedErrorOccurredTryAgain {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'anUnexpectedErrorOccurredTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get sendResetLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for a password reset link.`
  String get checkEmailForResetLink {
    return Intl.message(
      'Check your email for a password reset link.',
      name: 'checkEmailForResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send reset link. Please try again.`
  String get failedToSendResetLink {
    return Intl.message(
      'Failed to send reset link. Please try again.',
      name: 'failedToSendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Apple Sign In error: {error}`
  String appleSignInError(String error) {
    return Intl.message(
      'Apple Sign In error: $error',
      name: 'appleSignInError',
      desc: '',
      args: [error],
    );
  }

  /// `Sign in failed. Please try again.`
  String get signInFailedPleaseTryAgain {
    return Intl.message(
      'Sign in failed. Please try again.',
      name: 'signInFailedPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we'll send you a link to reset your password.`
  String get enterEmailForResetLink {
    return Intl.message(
      'Enter your email address and we\'ll send you a link to reset your password.',
      name: 'enterEmailForResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create an account to backup & sync.`
  String get createAccountToBackupAndSync {
    return Intl.message(
      'Create an account to backup & sync.',
      name: 'createAccountToBackupAndSync',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back! Let's stay consistent.`
  String get welcomeBackStayConsistent {
    return Intl.message(
      'Welcome back! Let\'s stay consistent.',
      name: 'welcomeBackStayConsistent',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get enterValidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordMinLengthError {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordMinLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Already have an account? `
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `or continue with`
  String get orContinueWith {
    return Intl.message(
      'or continue with',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get continueWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'continueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Pause Syncing`
  String get pauseSyncing {
    return Intl.message(
      'Pause Syncing',
      name: 'pauseSyncing',
      desc: '',
      args: [],
    );
  }

  /// `Pauses syncing and backup`
  String get pausesSyncingAndBackup {
    return Intl.message(
      'Pauses syncing and backup',
      name: 'pausesSyncingAndBackup',
      desc: '',
      args: [],
    );
  }

  /// `Restore Data`
  String get restoreData {
    return Intl.message(
      'Restore Data',
      name: 'restoreData',
      desc: '',
      args: [],
    );
  }

  /// `From previous backups`
  String get fromPreviousBackups {
    return Intl.message(
      'From previous backups',
      name: 'fromPreviousBackups',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Email, password, and account`
  String get emailPasswordAndAccount {
    return Intl.message(
      'Email, password, and account',
      name: 'emailPasswordAndAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }

  /// `Syncing Paused`
  String get syncingPaused {
    return Intl.message(
      'Syncing Paused',
      name: 'syncingPaused',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get syncingPausedDesc {
    return Intl.message(
      'Paused',
      name: 'syncingPausedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Never synced`
  String get neverSynced {
    return Intl.message(
      'Never synced',
      name: 'neverSynced',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get paused {
    return Intl.message('Paused', name: 'paused', desc: '', args: []);
  }

  /// `Syncing...`
  String get syncingHero {
    return Intl.message('Syncing...', name: 'syncingHero', desc: '', args: []);
  }

  /// `Your data is being synchronized`
  String get dataBeingSynchronized {
    return Intl.message(
      'Your data is being synchronized',
      name: 'dataBeingSynchronized',
      desc: '',
      args: [],
    );
  }

  /// `Syncing to Cloud`
  String get syncingToCloud {
    return Intl.message(
      'Syncing to Cloud',
      name: 'syncingToCloud',
      desc: '',
      args: [],
    );
  }

  /// `Everything is safe`
  String get everythingIsSafe {
    return Intl.message(
      'Everything is safe',
      name: 'everythingIsSafe',
      desc: '',
      args: [],
    );
  }

  /// `Connected to Cloud`
  String get connectedToCloud {
    return Intl.message(
      'Connected to Cloud',
      name: 'connectedToCloud',
      desc: '',
      args: [],
    );
  }

  /// `Sync Error`
  String get syncError {
    return Intl.message('Sync Error', name: 'syncError', desc: '', args: []);
  }

  /// `Tap Sync Now to retry`
  String get tapSyncNowToRetry {
    return Intl.message(
      'Tap Sync Now to retry',
      name: 'tapSyncNowToRetry',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorText {
    return Intl.message('Error', name: 'errorText', desc: '', args: []);
  }

  /// `You're offline`
  String get youAreOffline {
    return Intl.message(
      'You\'re offline',
      name: 'youAreOffline',
      desc: '',
      args: [],
    );
  }

  /// `Will sync when connected`
  String get willSyncWhenConnected {
    return Intl.message(
      'Will sync when connected',
      name: 'willSyncWhenConnected',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline {
    return Intl.message('Offline', name: 'offline', desc: '', args: []);
  }

  /// `Not configured`
  String get notConfigured {
    return Intl.message(
      'Not configured',
      name: 'notConfigured',
      desc: '',
      args: [],
    );
  }

  /// `Set up sync to enable`
  String get setUpSyncToEnable {
    return Intl.message(
      'Set up sync to enable',
      name: 'setUpSyncToEnable',
      desc: '',
      args: [],
    );
  }

  /// `Subscription needed`
  String get subscriptionNeeded {
    return Intl.message(
      'Subscription needed',
      name: 'subscriptionNeeded',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to enable Habo Sync`
  String get subscribeToEnableSync {
    return Intl.message(
      'Subscribe to enable Habo Sync',
      name: 'subscribeToEnableSync',
      desc: '',
      args: [],
    );
  }

  /// `Not active`
  String get notActive {
    return Intl.message('Not active', name: 'notActive', desc: '', args: []);
  }

  /// `Sync & Backup`
  String get syncAndBackup {
    return Intl.message(
      'Sync & Backup',
      name: 'syncAndBackup',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Sync & Backup`
  String get unlockSyncAndBackup {
    return Intl.message(
      'Unlock Sync & Backup',
      name: 'unlockSyncAndBackup',
      desc: '',
      args: [],
    );
  }

  /// `Keep your habits safe and synced across all your devices.`
  String get keepHabitsSafeAndSynced {
    return Intl.message(
      'Keep your habits safe and synced across all your devices.',
      name: 'keepHabitsSafeAndSynced',
      desc: '',
      args: [],
    );
  }

  /// `Real-time sync across devices`
  String get realTimeSyncAcrossDevices {
    return Intl.message(
      'Real-time sync across devices',
      name: 'realTimeSyncAcrossDevices',
      desc: '',
      args: [],
    );
  }

  /// `Automatic cloud backups`
  String get automaticCloudBackups {
    return Intl.message(
      'Automatic cloud backups',
      name: 'automaticCloudBackups',
      desc: '',
      args: [],
    );
  }

  /// `End-to-end encryption`
  String get endToEndEncryption {
    return Intl.message(
      'End-to-end encryption',
      name: 'endToEndEncryption',
      desc: '',
      args: [],
    );
  }

  /// `Restore Purchases`
  String get restorePurchases {
    return Intl.message(
      'Restore Purchases',
      name: 'restorePurchases',
      desc: '',
      args: [],
    );
  }

  /// `Last synced just now`
  String get lastSyncedJustNow {
    return Intl.message(
      'Last synced just now',
      name: 'lastSyncedJustNow',
      desc: '',
      args: [],
    );
  }

  /// `Last synced {minutes} min ago`
  String lastSyncedMinsAgo(int minutes) {
    return Intl.message(
      'Last synced $minutes min ago',
      name: 'lastSyncedMinsAgo',
      desc: '',
      args: [minutes],
    );
  }

  /// `Last synced {hours} hours ago`
  String lastSyncedHoursAgo(int hours) {
    return Intl.message(
      'Last synced $hours hours ago',
      name: 'lastSyncedHoursAgo',
      desc: '',
      args: [hours],
    );
  }

  /// `Last synced {days} day{plural} ago`
  String lastSyncedDaysAgo(int days, String plural) {
    return Intl.message(
      'Last synced $days day$plural ago',
      name: 'lastSyncedDaysAgo',
      desc: '',
      args: [days, plural],
    );
  }

  /// `Today at {time}`
  String todayAt(String time) {
    return Intl.message(
      'Today at $time',
      name: 'todayAt',
      desc: '',
      args: [time],
    );
  }

  /// `Yesterday at {time}`
  String yesterdayAt(String time) {
    return Intl.message(
      'Yesterday at $time',
      name: 'yesterdayAt',
      desc: '',
      args: [time],
    );
  }

  /// `{weekday} at {time}`
  String weekdayAt(String weekday, String time) {
    return Intl.message(
      '$weekday at $time',
      name: 'weekdayAt',
      desc: '',
      args: [weekday, time],
    );
  }

  /// `This will replace all current data with the backup from {date}.\n\nThis action cannot be undone.`
  String restoreBackupConfirmation(String date) {
    return Intl.message(
      'This will replace all current data with the backup from $date.\n\nThis action cannot be undone.',
      name: 'restoreBackupConfirmation',
      desc: '',
      args: [date],
    );
  }

  /// `Backup restored successfully!`
  String get backupRestoredSuccessfully {
    return Intl.message(
      'Backup restored successfully!',
      name: 'backupRestoredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Restore failed: {error}`
  String restoreFailedWithError(String error) {
    return Intl.message(
      'Restore failed: $error',
      name: 'restoreFailedWithError',
      desc: '',
      args: [error],
    );
  }

  /// `Restore failed. Please try again.`
  String get restoreFailedTryAgain {
    return Intl.message(
      'Restore failed. Please try again.',
      name: 'restoreFailedTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Choose a backup to restore from`
  String get chooseBackupToRestore {
    return Intl.message(
      'Choose a backup to restore from',
      name: 'chooseBackupToRestore',
      desc: '',
      args: [],
    );
  }

  /// `No backups available yet.\nBackups are created automatically during sync.`
  String get noBackupsAvailable {
    return Intl.message(
      'No backups available yet.\nBackups are created automatically during sync.',
      name: 'noBackupsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Purchases restored successfully!`
  String get purchasesRestoredSuccessfully {
    return Intl.message(
      'Purchases restored successfully!',
      name: 'purchasesRestoredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No previous purchases found.`
  String get noPreviousPurchasesFound {
    return Intl.message(
      'No previous purchases found.',
      name: 'noPreviousPurchasesFound',
      desc: '',
      args: [],
    );
  }

  /// `Verification email resent!`
  String get verificationEmailResent {
    return Intl.message(
      'Verification email resent!',
      name: 'verificationEmailResent',
      desc: '',
      args: [],
    );
  }

  /// `Failed to resend: {error}`
  String failedToResend(String error) {
    return Intl.message(
      'Failed to resend: $error',
      name: 'failedToResend',
      desc: '',
      args: [error],
    );
  }

  /// `I've verified my email`
  String get iveVerifiedMyEmail {
    return Intl.message(
      'I\'ve verified my email',
      name: 'iveVerifiedMyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Seamless Continuity`
  String get seamlessContinuity {
    return Intl.message(
      'Seamless Continuity',
      name: 'seamlessContinuity',
      desc: '',
      args: [],
    );
  }

  /// `Your habits, flawlessly synchronized across everywhere. Start tracking on your phone, tick off on your tablet seamlessly.`
  String get seamlessContinuityDesc {
    return Intl.message(
      'Your habits, flawlessly synchronized across everywhere. Start tracking on your phone, tick off on your tablet seamlessly.',
      name: 'seamlessContinuityDesc',
      desc: '',
      args: [],
    );
  }

  /// `Zero-Knowledge Privacy`
  String get zeroKnowledgePrivacy {
    return Intl.message(
      'Zero-Knowledge Privacy',
      name: 'zeroKnowledgePrivacy',
      desc: '',
      args: [],
    );
  }

  /// `State-of-the-art End-to-End Encryption. Only you hold the master key — we can never read or access your personal data.`
  String get zeroKnowledgePrivacyDesc {
    return Intl.message(
      'State-of-the-art End-to-End Encryption. Only you hold the master key — we can never read or access your personal data.',
      name: 'zeroKnowledgePrivacyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Rest Easy`
  String get restEasy {
    return Intl.message('Rest Easy', name: 'restEasy', desc: '', args: []);
  }

  /// `We securely snapshot your entire progress history to the cloud. Total peace of mind, automatically.`
  String get restEasyDesc {
    return Intl.message(
      'We securely snapshot your entire progress history to the cloud. Total peace of mind, automatically.',
      name: 'restEasyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Password cannot be empty`
  String get passwordCannotBeEmpty {
    return Intl.message(
      'Password cannot be empty',
      name: 'passwordCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmYourPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create Master Password`
  String get createMasterPassword {
    return Intl.message(
      'Create Master Password',
      name: 'createMasterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Your Data`
  String get unlockYourData {
    return Intl.message(
      'Unlock Your Data',
      name: 'unlockYourData',
      desc: '',
      args: [],
    );
  }

  /// `Your master password encrypts all your data before it leaves your device. Choose something strong and memorable.`
  String get masterPasswordDescriptionSetup {
    return Intl.message(
      'Your master password encrypts all your data before it leaves your device. Choose something strong and memorable.',
      name: 'masterPasswordDescriptionSetup',
      desc: '',
      args: [],
    );
  }

  /// `Enter your master password to decrypt your data and enable sync.`
  String get masterPasswordDescriptionUnlock {
    return Intl.message(
      'Enter your master password to decrypt your data and enable sync.',
      name: 'masterPasswordDescriptionUnlock',
      desc: '',
      args: [],
    );
  }

  /// `Important: Cannot be recovered`
  String get importantCannotBeRecovered {
    return Intl.message(
      'Important: Cannot be recovered',
      name: 'importantCannotBeRecovered',
      desc: '',
      args: [],
    );
  }

  /// `We do not store your password. If you forget it, your data cannot be recovered. Write it down somewhere safe!`
  String get masterPasswordWarning {
    return Intl.message(
      'We do not store your password. If you forget it, your data cannot be recovered. Write it down somewhere safe!',
      name: 'masterPasswordWarning',
      desc: '',
      args: [],
    );
  }

  /// `Master Password`
  String get masterPasswordLabel {
    return Intl.message(
      'Master Password',
      name: 'masterPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Minimum 8 characters`
  String get minimum8Characters {
    return Intl.message(
      'Minimum 8 characters',
      name: 'minimum8Characters',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get setPassword {
    return Intl.message(
      'Set Password',
      name: 'setPassword',
      desc: '',
      args: [],
    );
  }

  /// `Unlock & Sync`
  String get unlockAndSync {
    return Intl.message(
      'Unlock & Sync',
      name: 'unlockAndSync',
      desc: '',
      args: [],
    );
  }

  /// `This is the password you created when you first set up sync on another device.`
  String get unlockPasswordExplanation {
    return Intl.message(
      'This is the password you created when you first set up sync on another device.',
      name: 'unlockPasswordExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Master password changed successfully`
  String get masterPasswordChangedSuccessfully {
    return Intl.message(
      'Master password changed successfully',
      name: 'masterPasswordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error: {error}`
  String errorWithDescription(String error) {
    return Intl.message(
      'Error: $error',
      name: 'errorWithDescription',
      desc: '',
      args: [error],
    );
  }

  /// `Change Master Password`
  String get changeMasterPassword {
    return Intl.message(
      'Change Master Password',
      name: 'changeMasterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Account password changed successfully`
  String get accountPasswordChangedSuccessfully {
    return Intl.message(
      'Account password changed successfully',
      name: 'accountPasswordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Change Account Password`
  String get changeAccountPassword {
    return Intl.message(
      'Change Account Password',
      name: 'changeAccountPassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccountTitle {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get unexpectedErrorPleaseTryAgain {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'unexpectedErrorPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for a password reset link.`
  String get checkEmailForPasswordReset {
    return Intl.message(
      'Check your email for a password reset link.',
      name: 'checkEmailForPasswordReset',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out?`
  String get signOutQuestion {
    return Intl.message(
      'Sign Out?',
      name: 'signOutQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Reset to Habo Cloud?`
  String get resetToHaboCloudQuestion {
    return Intl.message(
      'Reset to Habo Cloud?',
      name: 'resetToHaboCloudQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get resetAction {
    return Intl.message('Reset', name: 'resetAction', desc: '', args: []);
  }

  /// `Restart Required`
  String get restartRequired {
    return Intl.message(
      'Restart Required',
      name: 'restartRequired',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Server Configuration`
  String get serverConfiguration {
    return Intl.message(
      'Server Configuration',
      name: 'serverConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Test Connection & Save`
  String get testConnectionAndSave {
    return Intl.message(
      'Test Connection & Save',
      name: 'testConnectionAndSave',
      desc: '',
      args: [],
    );
  }

  /// `Reset to Habo Cloud`
  String get resetToHaboCloud {
    return Intl.message(
      'Reset to Habo Cloud',
      name: 'resetToHaboCloud',
      desc: '',
      args: [],
    );
  }

  /// `Current password is required`
  String get currentPasswordIsRequired {
    return Intl.message(
      'Current password is required',
      name: 'currentPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `New password is required`
  String get newPasswordIsRequired {
    return Intl.message(
      'New password is required',
      name: 'newPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `New password must be different from current`
  String get newPasswordMustBeDifferent {
    return Intl.message(
      'New password must be different from current',
      name: 'newPasswordMustBeDifferent',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect current password`
  String get incorrectCurrentPassword {
    return Intl.message(
      'Incorrect current password',
      name: 'incorrectCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your current password and choose a new one.`
  String get enterCurrentPasswordAndChooseNew {
    return Intl.message(
      'Enter your current password and choose a new one.',
      name: 'enterCurrentPasswordAndChooseNew',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `This changes your login password for Habo.`
  String get thisChangesYourLoginPassword {
    return Intl.message(
      'This changes your login password for Habo.',
      name: 'thisChangesYourLoginPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password Updated!`
  String get passwordUpdated {
    return Intl.message(
      'Password Updated!',
      name: 'passwordUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been reset successfully. You can now sign in with your new password.`
  String get passwordResetSuccessMessage {
    return Intl.message(
      'Your password has been reset successfully. You can now sign in with your new password.',
      name: 'passwordResetSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Set New Password`
  String get setNewPassword {
    return Intl.message(
      'Set New Password',
      name: 'setNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Choose a strong password for your account.`
  String get chooseStrongPassword {
    return Intl.message(
      'Choose a strong password for your account.',
      name: 'chooseStrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please type DELETE to confirm`
  String get pleaseTypeDeleteToConfirm {
    return Intl.message(
      'Please type DELETE to confirm',
      name: 'pleaseTypeDeleteToConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Unable to verify identity`
  String get unableToVerifyIdentity {
    return Intl.message(
      'Unable to verify identity',
      name: 'unableToVerifyIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get incorrectPassword {
    return Intl.message(
      'Incorrect password',
      name: 'incorrectPassword',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete account`
  String get failedToDeleteAccount {
    return Intl.message(
      'Failed to delete account',
      name: 'failedToDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete Your Account`
  String get deleteYourAccount {
    return Intl.message(
      'Delete Your Account',
      name: 'deleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `This action is permanent and cannot be undone. The following data will be permanently deleted:`
  String get deleteAccountWarning {
    return Intl.message(
      'This action is permanent and cannot be undone. The following data will be permanently deleted:',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `All your habits and tracking data`
  String get deleteHabitsAndTrackingData {
    return Intl.message(
      'All your habits and tracking data',
      name: 'deleteHabitsAndTrackingData',
      desc: '',
      args: [],
    );
  }

  /// `Cloud backups and sync data`
  String get deleteCloudBackupsAndSyncData {
    return Intl.message(
      'Cloud backups and sync data',
      name: 'deleteCloudBackupsAndSyncData',
      desc: '',
      args: [],
    );
  }

  /// `Encryption keys and profile`
  String get deleteEncryptionKeysAndProfile {
    return Intl.message(
      'Encryption keys and profile',
      name: 'deleteEncryptionKeysAndProfile',
      desc: '',
      args: [],
    );
  }

  /// `Your account and login credentials`
  String get deleteYourAccountAndLoginCredentials {
    return Intl.message(
      'Your account and login credentials',
      name: 'deleteYourAccountAndLoginCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Subscription (managed separately by store)`
  String get deleteSubscriptionManagedSeparately {
    return Intl.message(
      'Subscription (managed separately by store)',
      name: 'deleteSubscriptionManagedSeparately',
      desc: '',
      args: [],
    );
  }

  /// `Type DELETE to confirm`
  String get typeDeleteToConfirm {
    return Intl.message(
      'Type DELETE to confirm',
      name: 'typeDeleteToConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password to confirm`
  String get enterYourPasswordToConfirm {
    return Intl.message(
      'Enter your password to confirm',
      name: 'enterYourPasswordToConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Permanently Delete Account`
  String get permanentlyDeleteAccount {
    return Intl.message(
      'Permanently Delete Account',
      name: 'permanentlyDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we'll send you a link to reset your password.`
  String get resetPasswordDescription {
    return Intl.message(
      'Enter your email address and we\'ll send you a link to reset your password.',
      name: 'resetPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Update your encryption password`
  String get updateYourEncryptionPassword {
    return Intl.message(
      'Update your encryption password',
      name: 'updateYourEncryptionPassword',
      desc: '',
      args: [],
    );
  }

  /// `Update your login password`
  String get updateYourLoginPassword {
    return Intl.message(
      'Update your login password',
      name: 'updateYourLoginPassword',
      desc: '',
      args: [],
    );
  }

  /// `Manage Subscription`
  String get manageSubscription {
    return Intl.message(
      'Manage Subscription',
      name: 'manageSubscription',
      desc: '',
      args: [],
    );
  }

  /// `View or cancel your plan`
  String get viewOrCancelYourPlan {
    return Intl.message(
      'View or cancel your plan',
      name: 'viewOrCancelYourPlan',
      desc: '',
      args: [],
    );
  }

  /// `Permanently delete your account and data`
  String get permanentlyDeleteYourAccountAndData {
    return Intl.message(
      'Permanently delete your account and data',
      name: 'permanentlyDeleteYourAccountAndData',
      desc: '',
      args: [],
    );
  }

  /// `You will need to enter your master password again to access your synced data.`
  String get signOutConfirmationContent {
    return Intl.message(
      'You will need to enter your master password again to access your synced data.',
      name: 'signOutConfirmationContent',
      desc: '',
      args: [],
    );
  }

  /// `Could not connect to server. Verify the URL, anon key, and that the Habo migration has been applied.\n\nError: {e}`
  String couldNotConnectToServer(String e) {
    return Intl.message(
      'Could not connect to server. Verify the URL, anon key, and that the Habo migration has been applied.\n\nError: $e',
      name: 'couldNotConnectToServer',
      desc: '',
      args: [e],
    );
  }

  /// `This will disconnect from your self-hosted server and switch back to the default Habo Cloud server. You will need to sign in again.`
  String get disconnectFromSelfHosted {
    return Intl.message(
      'This will disconnect from your self-hosted server and switch back to the default Habo Cloud server. You will need to sign in again.',
      name: 'disconnectFromSelfHosted',
      desc: '',
      args: [],
    );
  }

  /// `Please close and reopen the app to connect to the new server.`
  String get restartRequiredContent {
    return Intl.message(
      'Please close and reopen the app to connect to the new server.',
      name: 'restartRequiredContent',
      desc: '',
      args: [],
    );
  }

  /// `Connected to a custom server`
  String get connectedToCustomServer {
    return Intl.message(
      'Connected to a custom server',
      name: 'connectedToCustomServer',
      desc: '',
      args: [],
    );
  }

  /// `Connected to Habo Cloud (default)`
  String get connectedToHaboCloudDefault {
    return Intl.message(
      'Connected to Habo Cloud (default)',
      name: 'connectedToHaboCloudDefault',
      desc: '',
      args: [],
    );
  }

  /// `Self-host your own Supabase backend for full sync access without a subscription. See the self-hosting guide for setup instructions.`
  String get selfHostDescription {
    return Intl.message(
      'Self-host your own Supabase backend for full sync access without a subscription. See the self-hosting guide for setup instructions.',
      name: 'selfHostDescription',
      desc: '',
      args: [],
    );
  }

  /// `URL is required`
  String get urlIsRequired {
    return Intl.message(
      'URL is required',
      name: 'urlIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid URL (e.g., https://your-project.supabase.co)`
  String get enterValidUrl {
    return Intl.message(
      'Enter a valid URL (e.g., https://your-project.supabase.co)',
      name: 'enterValidUrl',
      desc: '',
      args: [],
    );
  }

  /// `URL must start with https:// or http://`
  String get urlMustStartWithHttpOrHttps {
    return Intl.message(
      'URL must start with https:// or http://',
      name: 'urlMustStartWithHttpOrHttps',
      desc: '',
      args: [],
    );
  }

  /// `Anon key is required`
  String get anonKeyIsRequired {
    return Intl.message(
      'Anon key is required',
      name: 'anonKeyIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in with your email and password.`
  String get pleaseSignInWithEmailAndPassword {
    return Intl.message(
      'Please sign in with your email and password.',
      name: 'pleaseSignInWithEmailAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get checkYourEmail {
    return Intl.message(
      'Check your email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `We sent a verification link to`
  String get weSentVerificationLinkTo {
    return Intl.message(
      'We sent a verification link to',
      name: 'weSentVerificationLinkTo',
      desc: '',
      args: [],
    );
  }

  /// `Click the link in the email to verify your account, then come back here and tap the button below.`
  String get clickLinkInEmailToVerify {
    return Intl.message(
      'Click the link in the email to verify your account, then come back here and tap the button below.',
      name: 'clickLinkInEmailToVerify',
      desc: '',
      args: [],
    );
  }

  /// `Resend in {seconds}s`
  String resendInSeconds(int seconds) {
    return Intl.message(
      'Resend in ${seconds}s',
      name: 'resendInSeconds',
      desc: '',
      args: [seconds],
    );
  }

  /// `Resend verification email`
  String get resendVerificationEmail {
    return Intl.message(
      'Resend verification email',
      name: 'resendVerificationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Back to Sign In`
  String get backToSignIn {
    return Intl.message(
      'Back to Sign In',
      name: 'backToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Android home widget now supports light and dark mode backgrounds.`
  String get featureHomescreenWidgetDarkModeDesc {
    return Intl.message(
      'Android home widget now supports light and dark mode backgrounds.',
      name: 'featureHomescreenWidgetDarkModeDesc',
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
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'ckb'),
      Locale.fromSubtags(languageCode: 'cs'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'eo'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'he'),
      Locale.fromSubtags(languageCode: 'ia'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'nb', countryCode: 'NO'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'sk'),
      Locale.fromSubtags(languageCode: 'sv'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
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
