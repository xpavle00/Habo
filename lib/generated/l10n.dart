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

  /// `Numeric habit`
  String get numericHabit {
    return Intl.message(
      'Numeric habit',
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

  /// `Boolean habit`
  String get booleanHabit {
    return Intl.message(
      'Boolean habit',
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

  /// `Coming Soon`
  String get haboSyncComingSoon {
    return Intl.message(
      'Coming Soon',
      name: 'haboSyncComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Sync your habits across all your devices with Habo's end-to-end encrypted cloud service.`
  String get haboSyncDescription {
    return Intl.message(
      'Sync your habits across all your devices with Habo\'s end-to-end encrypted cloud service.',
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
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'nb', countryCode: 'NO'),
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
