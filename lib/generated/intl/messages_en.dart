// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m1(authMethod) =>
      "Please authenticate to access Habo using ${authMethod}";

  static String m2(authMethod) =>
      "Please authenticate using ${authMethod} to access your habits";

  static String m3(authMethod) => "Secure app with ${authMethod}";

  static String m4(title) => "Category \"${title}\" already exists";

  static String m5(title) => "Category \"${title}\" created successfully";

  static String m6(title) => "Category \"${title}\" deleted successfully";

  static String m7(title) => "Category \"${title}\" updated successfully";

  static String m8(current, unit) => "Current: ${current} ${unit}";

  static String m9(title) =>
      "Are you sure you want to delete \"${title}\"?\n\nThis will remove the category from all habits that use it.";

  static String m10(error) => "Failed to delete category: ${error}";

  static String m11(error) => "Failed to save category: ${error}";

  static String m12(title) => "No habits in \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m14(count) => "Selected Categories (${count})";

  static String m15(target, unit) => "Target: ${target} ${unit}";

  static String m0(theme) => "${Intl.select(theme, {
            'device': 'Device',
            'light': 'Light',
            'dark': 'Dark',
            'oled': 'OLED black',
            'materialYou': 'Material You',
            'other': 'Device'
          })}";

  static String m16(version) => "Version ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
          "Accountability partner",
        ),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addCategory": MessageLookupByLibrary.simpleMessage("Add Category"),
        "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
          "Advanced habit building",
        ),
        "advancedHabitBuildingDescription":
            MessageLookupByLibrary.simpleMessage(
          "This section helps you better define your habits utilizing the Habit loop. You should define cues, routines, and rewards for every habit.",
        ),
        "allCategories": MessageLookupByLibrary.simpleMessage("All Categories"),
        "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
          "All habits will be replaced with habits from backup.",
        ),
        "allow": MessageLookupByLibrary.simpleMessage("Allow"),
        "appNotifications": MessageLookupByLibrary.simpleMessage(
          "App notifications",
        ),
        "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
          "Notification channel for application notifications",
        ),
        "archive": MessageLookupByLibrary.simpleMessage("Archive"),
        "archiveHabit": MessageLookupByLibrary.simpleMessage("Archive habit"),
        "archivedHabits":
            MessageLookupByLibrary.simpleMessage("Archived Habits"),
        "at7AM": MessageLookupByLibrary.simpleMessage("At 7:00AM"),
        "authenticate": MessageLookupByLibrary.simpleMessage("Authenticate"),
        "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
          "Please authenticate to access Habo",
        ),
        "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
          "Authenticate to enable biometric lock",
        ),
        "authenticating":
            MessageLookupByLibrary.simpleMessage("Authenticating…"),
        "authenticationError": MessageLookupByLibrary.simpleMessage(
          "Authentication error",
        ),
        "authenticationFailedMessage": m1,
        "authenticationPrompt": m2,
        "authenticationRequired": MessageLookupByLibrary.simpleMessage(
          "Authentication Required",
        ),
        "backup": MessageLookupByLibrary.simpleMessage("Backup"),
        "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
          "Backup created successfully!",
        ),
        "backupFailed": MessageLookupByLibrary.simpleMessage("Backup failed!"),
        "backupFailedError": MessageLookupByLibrary.simpleMessage(
          "ERROR: Creating backup failed.",
        ),
        "biometric": MessageLookupByLibrary.simpleMessage("Biometric"),
        "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
          "Biometric authentication required",
        ),
        "biometricAuthenticationSucceeded":
            MessageLookupByLibrary.simpleMessage(
          "Biometric authentication succeeded",
        ),
        "biometricLock": MessageLookupByLibrary.simpleMessage("Biometric Lock"),
        "biometricLockDescription": m3,
        "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
          "Biometric lock disabled",
        ),
        "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
          "Biometric lock enabled",
        ),
        "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
          "Biometric not recognized, try again",
        ),
        "biometricRequired": MessageLookupByLibrary.simpleMessage(
          "Biometric required",
        ),
        "booleanHabit": MessageLookupByLibrary.simpleMessage("Boolean habit"),
        "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
          "Building Better Habits",
        ),
        "buyMeACoffee": MessageLookupByLibrary.simpleMessage("Buy me a coffee"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "categories": MessageLookupByLibrary.simpleMessage("Categories"),
        "category": MessageLookupByLibrary.simpleMessage("Category"),
        "categoryAlreadyExists": m4,
        "categoryCreatedSuccessfully": m5,
        "categoryDeletedSuccessfully": m6,
        "categoryUpdatedSuccessfully": m7,
        "check": MessageLookupByLibrary.simpleMessage("Check"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "complete": MessageLookupByLibrary.simpleMessage("Complete"),
        "congratulationsReward": MessageLookupByLibrary.simpleMessage(
          "Congratulations! Your reward:",
        ),
        "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createFirstCategory": MessageLookupByLibrary.simpleMessage(
          "Create your first category to organize your habits",
        ),
        "createHabit": MessageLookupByLibrary.simpleMessage("Create Habit"),
        "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
          "Create a habit and assign it to this category",
        ),
        "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
          "Create your first habit.",
        ),
        "cue": MessageLookupByLibrary.simpleMessage("Cue"),
        "cueDescription": MessageLookupByLibrary.simpleMessage(
          "is the trigger that initiates your habit. It could be a specific time, location, feeling, or an event.",
        ),
        "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Cue"),
        "currentProgress": m8,
        "currentStreak": MessageLookupByLibrary.simpleMessage("Current streak"),
        "dan": MessageLookupByLibrary.simpleMessage("Dan"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "defineYourHabits": MessageLookupByLibrary.simpleMessage(
          "Define your habits",
        ),
        "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
          "To better stick to your habits, you can define:",
        ),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteCategory":
            MessageLookupByLibrary.simpleMessage("Delete Category"),
        "deleteCategoryConfirmation": m9,
        "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
          "Device credentials required",
        ),
        "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
          "Device PIN, Pattern, or Password",
        ),
        "disclaimer": MessageLookupByLibrary.simpleMessage("Disclaimer"),
        "do50PushUps": MessageLookupByLibrary.simpleMessage("Do 50 push ups"),
        "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
          "Do not forget to check your habits.",
        ),
        "donateToCharity": MessageLookupByLibrary.simpleMessage(
          "Donate 10\$ to charity",
        ),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "editCategory": MessageLookupByLibrary.simpleMessage("Edit Category"),
        "editHabit": MessageLookupByLibrary.simpleMessage("Edit Habit"),
        "emptyList": MessageLookupByLibrary.simpleMessage("Empty list"),
        "enterAmount": MessageLookupByLibrary.simpleMessage("Enter amount"),
        "exercise": MessageLookupByLibrary.simpleMessage("Exercise"),
        "fail": MessageLookupByLibrary.simpleMessage("Fail"),
        "failedToDeleteCategory": m10,
        "failedToSaveCategory": m11,
        "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
          "Hide habits you no longer track without deleting",
        ),
        "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Archive"),
        "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
          "Organize habits with category filters",
        ),
        "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage(
          "Categories",
        ),
        "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
          "Open Habo directly to screens like settings or create",
        ),
        "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
          "URL scheme (deep links)",
        ),
        "featureLockDesc": MessageLookupByLibrary.simpleMessage(
          "Secure the app with Face ID / Touch ID / biometrics",
        ),
        "featureLockTitle":
            MessageLookupByLibrary.simpleMessage("Lock feature"),
        "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
          "Dynamic colors that match your wallpaper",
        ),
        "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
          "Material You theme (Android)",
        ),
        "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
          "Track counts like glasses of water or pages read",
        ),
        "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
          "Numeric values in habits",
        ),
        "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
          "Adjustable volume",
        ),
        "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
          "New sound engine",
        ),
        "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
          "15 min. of video games",
        ),
        "fileNotFound": MessageLookupByLibrary.simpleMessage("File not found"),
        "fileTooLarge": MessageLookupByLibrary.simpleMessage(
          "File too large (max 10MB)",
        ),
        "fingerprint": MessageLookupByLibrary.simpleMessage("Fingerprint"),
        "firstDayOfWeek": MessageLookupByLibrary.simpleMessage(
          "First day of the week",
        ),
        "habit": MessageLookupByLibrary.simpleMessage("Habit"),
        "habitArchived": MessageLookupByLibrary.simpleMessage("Habit archived"),
        "habitContract": MessageLookupByLibrary.simpleMessage("Habit contract"),
        "habitContractDescription": MessageLookupByLibrary.simpleMessage(
          "While positive reinforcement is recommended, some people may opt for a habit contract. A habit contract allows you to specify a sanction that will be imposed if you miss your habit, and may involve an accountability partner who helps supervise your goals.",
        ),
        "habitDeleted": MessageLookupByLibrary.simpleMessage("Habit deleted."),
        "habitLoop": MessageLookupByLibrary.simpleMessage("Habit loop"),
        "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
          "Habit Loop is a psychological model describing the process of habit formation. It consists of three components: Cue, Routine, and Reward. The Cue triggers the Routine (habitual action), which is then reinforced by the Reward, creating a loop that makes the habit more ingrained and likely to be repeated.",
        ),
        "habitNotifications": MessageLookupByLibrary.simpleMessage(
          "Habit notifications",
        ),
        "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
          "Notification channel for habit notifications",
        ),
        "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
          "The habit title can not be empty.",
        ),
        "habitType": MessageLookupByLibrary.simpleMessage("Habit type"),
        "habitUnarchived":
            MessageLookupByLibrary.simpleMessage("Habit unarchived"),
        "habits": MessageLookupByLibrary.simpleMessage("Habits:"),
        "habitsToday": MessageLookupByLibrary.simpleMessage("Habits today"),
        "habo": MessageLookupByLibrary.simpleMessage("Habo"),
        "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
          "Habo needs permission to send notifications to work properly.",
        ),
        "haboSyncComingSoon":
            MessageLookupByLibrary.simpleMessage("Coming Soon"),
        "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
          "Sync your habits across all your devices with Habo\'s end-to-end encrypted cloud service.",
        ),
        "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
          "Learn more at habo.space/sync",
        ),
        "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
          "If you want to support Habo you can:",
        ),
        "input": MessageLookupByLibrary.simpleMessage("Input"),
        "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
          "Invalid backup file",
        ),
        "iris": MessageLookupByLibrary.simpleMessage("Iris"),
        "logYourDays": MessageLookupByLibrary.simpleMessage("Log your days"),
        "modify": MessageLookupByLibrary.simpleMessage("Modify"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
          "No archived habits",
        ),
        "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
          "No categories yet",
        ),
        "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
          "There is no data about habits.",
        ),
        "noHabitsInCategory": m12,
        "notSoSuccessful": MessageLookupByLibrary.simpleMessage(
          "Not so successful",
        ),
        "note": MessageLookupByLibrary.simpleMessage("Note"),
        "notificationTime": MessageLookupByLibrary.simpleMessage(
          "Notification time",
        ),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "numericHabit": MessageLookupByLibrary.simpleMessage("Numeric habit"),
        "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
          "Numeric habits let you track progress in increments throughout the day.",
        ),
        "observeYourProgress": MessageLookupByLibrary.simpleMessage(
          "Observe your progress",
        ),
        "ohNoSanction": MessageLookupByLibrary.simpleMessage(
          "Oh no! Your sanction:",
        ),
        "onboarding": MessageLookupByLibrary.simpleMessage("Onboarding"),
        "partialValue": MessageLookupByLibrary.simpleMessage("Partial value"),
        "partialValueDescription": MessageLookupByLibrary.simpleMessage(
          "To track progress in smaller increments",
        ),
        "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
          "Please enter a category title",
        ),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "progress": MessageLookupByLibrary.simpleMessage("Progress"),
        "progressOf": m13,
        "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
          "Please reenable your Touch ID or Face ID",
        ),
        "remainderOfReward": MessageLookupByLibrary.simpleMessage(
          "The reminder of the reward after a successful routine.",
        ),
        "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
          "The reminder of the sanction after a unsuccessful routine.",
        ),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "restore": MessageLookupByLibrary.simpleMessage("Restore"),
        "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
          "Restore completed successfully!",
        ),
        "restoreFailed":
            MessageLookupByLibrary.simpleMessage("Restore failed!"),
        "restoreFailedError": MessageLookupByLibrary.simpleMessage(
          "ERROR: Restoring backup failed.",
        ),
        "reward": MessageLookupByLibrary.simpleMessage("Reward"),
        "rewardDescription": MessageLookupByLibrary.simpleMessage(
          "is the benefit or positive feeling you experience after performing the routine. It reinforces the habit.",
        ),
        "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Reward"),
        "routine": MessageLookupByLibrary.simpleMessage("Routine"),
        "routineDescription": MessageLookupByLibrary.simpleMessage(
          "is the action you take in response to the cue. This is the habit itself.",
        ),
        "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Routine"),
        "sanction": MessageLookupByLibrary.simpleMessage("Sanction"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveProgress": MessageLookupByLibrary.simpleMessage("Save Progress"),
        "selectCategories": MessageLookupByLibrary.simpleMessage(
          "Select Categories",
        ),
        "selectedCategories": m14,
        "setColors": MessageLookupByLibrary.simpleMessage("Set colors"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
          "Please set up device credentials in settings",
        ),
        "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
          "Please set up your fingerprint or face unlock in device settings",
        ),
        "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
          "Please set up your Touch ID or Face ID in device settings",
        ),
        "showCategories":
            MessageLookupByLibrary.simpleMessage("Show Categories"),
        "showMonthName":
            MessageLookupByLibrary.simpleMessage("Show month name"),
        "showReward": MessageLookupByLibrary.simpleMessage("Show reward"),
        "showSanction": MessageLookupByLibrary.simpleMessage("Show sanction"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
          "Skip (does not affect streaks)",
        ),
        "slider": MessageLookupByLibrary.simpleMessage("Slider"),
        "soundEffects": MessageLookupByLibrary.simpleMessage("Sound effects"),
        "sourceCode":
            MessageLookupByLibrary.simpleMessage("Source code (GitHub)"),
        "statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
        "successful": MessageLookupByLibrary.simpleMessage("Successful"),
        "targetProgress": m15,
        "targetValue": MessageLookupByLibrary.simpleMessage("Target value"),
        "termsAndConditions": MessageLookupByLibrary.simpleMessage(
          "Terms and Conditions",
        ),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "themeSelect": m0,
        "topStreak": MessageLookupByLibrary.simpleMessage("Top streak"),
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "touchSensor": MessageLookupByLibrary.simpleMessage("Touch sensor"),
        "trackYourProgress": MessageLookupByLibrary.simpleMessage(
          "You can track your progress through the calendar view in every habit or on the statistics page.",
        ),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
        "twoDayRule": MessageLookupByLibrary.simpleMessage("Two day rule"),
        "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
          "With two day rule, you can miss one day and do not lose a streak if the next day is successful.",
        ),
        "unarchive": MessageLookupByLibrary.simpleMessage("Unarchive"),
        "unarchiveHabit":
            MessageLookupByLibrary.simpleMessage("Unarchive habit"),
        "undo": MessageLookupByLibrary.simpleMessage("Undo"),
        "unit": MessageLookupByLibrary.simpleMessage("Unit"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "useTwoDayRule":
            MessageLookupByLibrary.simpleMessage("Use Two day rule"),
        "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
          "View archived habits",
        ),
        "warning": MessageLookupByLibrary.simpleMessage("Warning"),
        "week": MessageLookupByLibrary.simpleMessage("Week"),
        "whatsNewTitle": MessageLookupByLibrary.simpleMessage("What\'s New"),
        "whatsNewVersion": m16,
        "yourCommentHere":
            MessageLookupByLibrary.simpleMessage("Your note here"),
      };
}
