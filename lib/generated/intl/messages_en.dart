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

  static String m17(error) => "Apple Sign In error: ${error}";

  static String m1(authMethod) =>
      "Please authenticate to access Habo using ${authMethod}";

  static String m2(authMethod) =>
      "Please authenticate using ${authMethod} to access your habits";

  static String m3(authMethod) => "Secure app with ${authMethod}";

  static String m4(title) => "Category \"${title}\" already exists";

  static String m5(title) => "Category \"${title}\" created successfully";

  static String m6(title) => "Category \"${title}\" deleted successfully";

  static String m7(title) => "Category \"${title}\" updated successfully";

  static String m18(e) =>
      "Could not connect to server. Verify the URL, anon key, and that the Habo migration has been applied.\n\nError: ${e}";

  static String m8(current, unit) => "Current: ${current} ${unit}";

  static String m9(title) =>
      "Are you sure you want to delete \"${title}\"?\n\nThis will remove the category from all habits that use it.";

  static String m19(error) => "Error: ${error}";

  static String m10(error) => "Failed to delete category: ${error}";

  static String m20(error) => "Failed to resend: ${error}";

  static String m11(error) => "Failed to save category: ${error}";

  static String m21(count) => "${count} habits";

  static String m22(days, plural) => "Last synced ${days} day${plural} ago";

  static String m23(hours) => "Last synced ${hours} hours ago";

  static String m24(minutes) => "Last synced ${minutes} min ago";

  static String m12(title) => "No habits in \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m25(seconds) => "Resend in ${seconds}s";

  static String m26(date) =>
      "This will replace all current data with the backup from ${date}.\n\nThis action cannot be undone.";

  static String m27(error) => "Restore failed: ${error}";

  static String m14(count) => "Selected Categories (${count})";

  static String m15(target, unit) => "Target: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Device', 'light': 'Light', 'dark': 'Dark', 'oled': 'OLED black', 'materialYou': 'Material You', 'other': 'Device'})}";

  static String m28(time) => "Today at ${time}";

  static String m29(weekday, time) => "${weekday} at ${time}";

  static String m16(version) => "Version ${version}";

  static String m30(time) => "Yesterday at ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accountPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Account password changed successfully",
    ),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Accountability partner",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Add Category"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Advanced habit building",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "This section helps you better define your habits utilizing the Habit loop. You should define cues, routines, and rewards for every habit.",
    ),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "allCategories": MessageLookupByLibrary.simpleMessage("All Categories"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "All habits will be replaced with habits from backup.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Allow"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "anUnexpectedErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred",
    ),
    "anUnexpectedErrorOccurredTryAgain": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again.",
    ),
    "anonKeyIsRequired": MessageLookupByLibrary.simpleMessage(
      "Anon key is required",
    ),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "App notifications",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Notification channel for application notifications",
    ),
    "appleSignInError": m17,
    "archive": MessageLookupByLibrary.simpleMessage("Archive"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Archive habit"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage("Archived Habits"),
    "at7AM": MessageLookupByLibrary.simpleMessage("At 7:00AM"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authenticate"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Please authenticate to access Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Authenticate to enable biometric lock",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage("Authenticating…"),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Authentication error",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Authentication Required",
    ),
    "automaticCloudBackups": MessageLookupByLibrary.simpleMessage(
      "Automatic cloud backups",
    ),
    "backToSignIn": MessageLookupByLibrary.simpleMessage("Back to Sign In"),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Backup created successfully!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage("Backup failed!"),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "ERROR: Creating backup failed.",
    ),
    "backupRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Backup restored successfully!",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biometric"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Biometric authentication required",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
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
    "booleanHabit": MessageLookupByLibrary.simpleMessage("Checkable (Yes/No)"),
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
    "categoryName": MessageLookupByLibrary.simpleMessage("Category name"),
    "categoryUpdatedSuccessfully": m7,
    "changeAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Change Account Password",
    ),
    "changeMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Change Master Password",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "check": MessageLookupByLibrary.simpleMessage("Check"),
    "checkEmailForPasswordReset": MessageLookupByLibrary.simpleMessage(
      "Check your email for a password reset link.",
    ),
    "checkEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Check your email for a password reset link.",
    ),
    "checkYourEmail": MessageLookupByLibrary.simpleMessage("Check your email"),
    "chooseBackupToRestore": MessageLookupByLibrary.simpleMessage(
      "Choose a backup to restore from",
    ),
    "chooseStrongPassword": MessageLookupByLibrary.simpleMessage(
      "Choose a strong password for your account.",
    ),
    "clickLinkInEmailToVerify": MessageLookupByLibrary.simpleMessage(
      "Click the link in the email to verify your account, then come back here and tap the button below.",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "complete": MessageLookupByLibrary.simpleMessage("Complete"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm New Password",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Congratulations! Your reward:",
    ),
    "connectedToCloud": MessageLookupByLibrary.simpleMessage(
      "Connected to Cloud",
    ),
    "connectedToCustomServer": MessageLookupByLibrary.simpleMessage(
      "Connected to a custom server",
    ),
    "connectedToHaboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Connected to Habo Cloud (default)",
    ),
    "continueWithApple": MessageLookupByLibrary.simpleMessage(
      "Continue with Apple",
    ),
    "continueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "couldNotConnectToServer": m18,
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "createAccountToBackupAndSync": MessageLookupByLibrary.simpleMessage(
      "Create an account to backup & sync.",
    ),
    "createCategory": MessageLookupByLibrary.simpleMessage("Create category"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Create your first category to organize your habits",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Create Habit"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Create a habit and assign it to this category",
    ),
    "createMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Create Master Password",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Create your first habit.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Cue"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "is the trigger that initiates your habit. It could be a specific time, location, feeling, or an event.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Cue"),
    "currentPassword": MessageLookupByLibrary.simpleMessage("Current Password"),
    "currentPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Current password is required",
    ),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Current streak"),
    "customServer": MessageLookupByLibrary.simpleMessage("Custom server"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "dataBeingSynchronized": MessageLookupByLibrary.simpleMessage(
      "Your data is being synchronized",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Define your habits",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "To better stick to your habits, you can define:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Account",
    ),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "This action is permanent and cannot be undone. The following data will be permanently deleted:",
    ),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Delete Category"),
    "deleteCategoryConfirmation": m9,
    "deleteCloudBackupsAndSyncData": MessageLookupByLibrary.simpleMessage(
      "Cloud backups and sync data",
    ),
    "deleteEncryptionKeysAndProfile": MessageLookupByLibrary.simpleMessage(
      "Encryption keys and profile",
    ),
    "deleteHabitsAndTrackingData": MessageLookupByLibrary.simpleMessage(
      "All your habits and tracking data",
    ),
    "deleteSubscriptionManagedSeparately": MessageLookupByLibrary.simpleMessage(
      "Subscription (managed separately by store)",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Delete Your Account",
    ),
    "deleteYourAccountAndLoginCredentials":
        MessageLookupByLibrary.simpleMessage(
          "Your account and login credentials",
        ),
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Device credentials required",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "Device PIN, Pattern, or Password",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Disclaimer"),
    "disconnectFromSelfHosted": MessageLookupByLibrary.simpleMessage(
      "This will disconnect from your self-hosted server and switch back to the default Habo Cloud server. You will need to sign in again.",
    ),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Do 50 push ups"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Do not forget to check your habits.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Donate 10\$ to charity",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "dontHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? ",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("Edit Category"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Edit Habit"),
    "emailIsRequired": MessageLookupByLibrary.simpleMessage(
      "Email is required",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailPasswordAndAccount": MessageLookupByLibrary.simpleMessage(
      "Email, password, and account",
    ),
    "emptyList": MessageLookupByLibrary.simpleMessage("Empty list"),
    "endToEndEncryption": MessageLookupByLibrary.simpleMessage(
      "End-to-end encryption",
    ),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Enter amount"),
    "enterCurrentPasswordAndChooseNew": MessageLookupByLibrary.simpleMessage(
      "Enter your current password and choose a new one.",
    ),
    "enterEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Enter your email address and we\'ll send you a link to reset your password.",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email",
    ),
    "enterValidUrl": MessageLookupByLibrary.simpleMessage(
      "Enter a valid URL (e.g., https://your-project.supabase.co)",
    ),
    "enterYourPasswordToConfirm": MessageLookupByLibrary.simpleMessage(
      "Enter your password to confirm",
    ),
    "errorText": MessageLookupByLibrary.simpleMessage("Error"),
    "errorWithDescription": m19,
    "everythingIsSafe": MessageLookupByLibrary.simpleMessage(
      "Everything is safe",
    ),
    "exercise": MessageLookupByLibrary.simpleMessage("Exercise"),
    "fail": MessageLookupByLibrary.simpleMessage("Fail"),
    "failedToDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Failed to delete account",
    ),
    "failedToDeleteCategory": m10,
    "failedToResend": m20,
    "failedToSaveCategory": m11,
    "failedToSendResetLink": MessageLookupByLibrary.simpleMessage(
      "Failed to send reset link. Please try again.",
    ),
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
    "featureHomescreenWidgetDarkModeDesc": MessageLookupByLibrary.simpleMessage(
      "Android home widget now supports light and dark mode backgrounds.",
    ),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "View your habit progress at a glance from your home screen (experimental)",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Homescreen widget",
    ),
    "featureIosSoundMixingDesc": MessageLookupByLibrary.simpleMessage(
      "Habo sounds no longer interrupt your music or podcasts",
    ),
    "featureIosSoundMixingTitle": MessageLookupByLibrary.simpleMessage(
      "Fixed sound mixing",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Secure the app with Face ID / Touch ID / biometrics",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage("Lock feature"),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "Longpress on habit buttons to quickly change status",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage(
      "Longpress check",
    ),
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
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "fromPreviousBackups": MessageLookupByLibrary.simpleMessage(
      "From previous backups",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
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
    "habitUnarchived": MessageLookupByLibrary.simpleMessage("Habit unarchived"),
    "habits": MessageLookupByLibrary.simpleMessage("Habits:"),
    "habitsCount": m21,
    "habitsToday": MessageLookupByLibrary.simpleMessage("Habits today"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Habo Cloud (default)",
    ),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo needs permission to send notifications to work properly.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Coming Soon"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Habo Sync is here! Sync and backup your habits across all your devices with end-to-end encrypted cloud sync.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Learn more at habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "If you want to support Habo you can:",
    ),
    "importantCannotBeRecovered": MessageLookupByLibrary.simpleMessage(
      "Important: Cannot be recovered",
    ),
    "incorrectCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Incorrect current password",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Incorrect password",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Input"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Invalid backup file",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Iris"),
    "iveVerifiedMyEmail": MessageLookupByLibrary.simpleMessage(
      "I\'ve verified my email",
    ),
    "keepHabitsSafeAndSynced": MessageLookupByLibrary.simpleMessage(
      "Keep your habits safe and synced across all your devices.",
    ),
    "lastSyncedDaysAgo": m22,
    "lastSyncedHoursAgo": m23,
    "lastSyncedJustNow": MessageLookupByLibrary.simpleMessage(
      "Last synced just now",
    ),
    "lastSyncedMinsAgo": m24,
    "logYourDays": MessageLookupByLibrary.simpleMessage("Log your days"),
    "manageSubscription": MessageLookupByLibrary.simpleMessage(
      "Manage Subscription",
    ),
    "masterPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Master password changed successfully",
    ),
    "masterPasswordDescriptionSetup": MessageLookupByLibrary.simpleMessage(
      "Your master password encrypts all your data before it leaves your device. Choose something strong and memorable.",
    ),
    "masterPasswordDescriptionUnlock": MessageLookupByLibrary.simpleMessage(
      "Enter your master password to decrypt your data and enable sync.",
    ),
    "masterPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Master Password",
    ),
    "masterPasswordWarning": MessageLookupByLibrary.simpleMessage(
      "We do not store your password. If you forget it, your data cannot be recovered. Write it down somewhere safe!",
    ),
    "minimum8Characters": MessageLookupByLibrary.simpleMessage(
      "Minimum 8 characters",
    ),
    "modify": MessageLookupByLibrary.simpleMessage("Modify"),
    "month": MessageLookupByLibrary.simpleMessage("Month"),
    "neverSynced": MessageLookupByLibrary.simpleMessage("Never synced"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "newPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "New password is required",
    ),
    "newPasswordMustBeDifferent": MessageLookupByLibrary.simpleMessage(
      "New password must be different from current",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "No archived habits",
    ),
    "noBackupsAvailable": MessageLookupByLibrary.simpleMessage(
      "No backups available yet.\nBackups are created automatically during sync.",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "No categories yet",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "There is no data about habits.",
    ),
    "noHabitsInCategory": m12,
    "noPreviousPurchasesFound": MessageLookupByLibrary.simpleMessage(
      "No previous purchases found.",
    ),
    "notActive": MessageLookupByLibrary.simpleMessage("Not active"),
    "notConfigured": MessageLookupByLibrary.simpleMessage("Not configured"),
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage(
      "Not so successful",
    ),
    "note": MessageLookupByLibrary.simpleMessage("Note"),
    "notificationTime": MessageLookupByLibrary.simpleMessage(
      "Notification time",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Progressive"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Numeric habits let you track progress in increments throughout the day.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Observe your progress",
    ),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Oh no! Your sanction:",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding": MessageLookupByLibrary.simpleMessage("Onboarding"),
    "oneTapCheck": MessageLookupByLibrary.simpleMessage("Single tap to check"),
    "or": MessageLookupByLibrary.simpleMessage("or"),
    "orContinueWith": MessageLookupByLibrary.simpleMessage("or continue with"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Partial value"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "To track progress in smaller increments",
    ),
    "passwordCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Password cannot be empty",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordMinLengthError": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "passwordResetSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Your password has been reset successfully. You can now sign in with your new password.",
    ),
    "passwordUpdated": MessageLookupByLibrary.simpleMessage(
      "Password Updated!",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "pauseSyncing": MessageLookupByLibrary.simpleMessage("Pause Syncing"),
    "paused": MessageLookupByLibrary.simpleMessage("Paused"),
    "pausesSyncingAndBackup": MessageLookupByLibrary.simpleMessage(
      "Pauses syncing and backup",
    ),
    "permanentlyDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Permanently Delete Account",
    ),
    "permanentlyDeleteYourAccountAndData": MessageLookupByLibrary.simpleMessage(
      "Permanently delete your account and data",
    ),
    "pleaseConfirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Please confirm your password",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Please enter a category title",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email address",
    ),
    "pleaseSignInWithEmailAndPassword": MessageLookupByLibrary.simpleMessage(
      "Please sign in with your email and password.",
    ),
    "pleaseTypeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Please type DELETE to confirm",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "progress": MessageLookupByLibrary.simpleMessage("Progress"),
    "progressOf": m13,
    "purchasesRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Purchases restored successfully!",
    ),
    "realTimeSyncAcrossDevices": MessageLookupByLibrary.simpleMessage(
      "Real-time sync across devices",
    ),
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Please reenable your Touch ID or Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "The reminder of the reward after a successful routine.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "The reminder of the sanction after a unsuccessful routine.",
    ),
    "resendInSeconds": m25,
    "resendVerificationEmail": MessageLookupByLibrary.simpleMessage(
      "Resend verification email",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetAction": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "resetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Enter your email address and we\'ll send you a link to reset your password.",
    ),
    "resetToHaboCloud": MessageLookupByLibrary.simpleMessage(
      "Reset to Habo Cloud",
    ),
    "resetToHaboCloudQuestion": MessageLookupByLibrary.simpleMessage(
      "Reset to Habo Cloud?",
    ),
    "restEasy": MessageLookupByLibrary.simpleMessage("Rest Easy"),
    "restEasyDesc": MessageLookupByLibrary.simpleMessage(
      "We securely snapshot your entire progress history to the cloud. Total peace of mind, automatically.",
    ),
    "restartRequired": MessageLookupByLibrary.simpleMessage("Restart Required"),
    "restartRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Please close and reopen the app to connect to the new server.",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Restore"),
    "restoreBackupConfirmation": m26,
    "restoreBackupQuestion": MessageLookupByLibrary.simpleMessage(
      "Restore Backup?",
    ),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Restore completed successfully!",
    ),
    "restoreData": MessageLookupByLibrary.simpleMessage("Restore Data"),
    "restoreFailed": MessageLookupByLibrary.simpleMessage("Restore failed!"),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "ERROR: Restoring backup failed.",
    ),
    "restoreFailedTryAgain": MessageLookupByLibrary.simpleMessage(
      "Restore failed. Please try again.",
    ),
    "restoreFailedWithError": m27,
    "restorePurchases": MessageLookupByLibrary.simpleMessage(
      "Restore Purchases",
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
    "seamlessContinuity": MessageLookupByLibrary.simpleMessage(
      "Seamless Continuity",
    ),
    "seamlessContinuityDesc": MessageLookupByLibrary.simpleMessage(
      "Your habits, flawlessly synchronized across everywhere. Start tracking on your phone, tick off on your tablet seamlessly.",
    ),
    "searchIcons": MessageLookupByLibrary.simpleMessage("Search"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Select Categories",
    ),
    "selectIcon": MessageLookupByLibrary.simpleMessage("Pick an icon"),
    "selectedCategories": m14,
    "selfHostDescription": MessageLookupByLibrary.simpleMessage(
      "Self-host your own Supabase backend for full sync access without a subscription. See the self-hosting guide for setup instructions.",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage("Send Reset Link"),
    "server": MessageLookupByLibrary.simpleMessage("Server"),
    "serverConfiguration": MessageLookupByLibrary.simpleMessage(
      "Server Configuration",
    ),
    "setColors": MessageLookupByLibrary.simpleMessage("Set colors"),
    "setNewPassword": MessageLookupByLibrary.simpleMessage("Set New Password"),
    "setPassword": MessageLookupByLibrary.simpleMessage("Set Password"),
    "setUpSyncToEnable": MessageLookupByLibrary.simpleMessage(
      "Set up sync to enable",
    ),
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
    "showCategories": MessageLookupByLibrary.simpleMessage("Show Categories"),
    "showMonthName": MessageLookupByLibrary.simpleMessage("Show month name"),
    "showReward": MessageLookupByLibrary.simpleMessage("Show reward"),
    "showSanction": MessageLookupByLibrary.simpleMessage("Show sanction"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signInFailedPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Sign in failed. Please try again.",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
    "signOutConfirmationContent": MessageLookupByLibrary.simpleMessage(
      "You will need to enter your master password again to access your synced data.",
    ),
    "signOutQuestion": MessageLookupByLibrary.simpleMessage("Sign Out?"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Skip (does not affect streaks)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Slider"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Sound effects"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Source code (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
    "subscribeToEnableSync": MessageLookupByLibrary.simpleMessage(
      "Subscribe to enable Habo Sync",
    ),
    "subscriptionNeeded": MessageLookupByLibrary.simpleMessage(
      "Subscription needed",
    ),
    "successful": MessageLookupByLibrary.simpleMessage("Successful"),
    "syncAndBackup": MessageLookupByLibrary.simpleMessage("Sync & Backup"),
    "syncAndBackupYourData": MessageLookupByLibrary.simpleMessage(
      "Sync and backup your data",
    ),
    "syncError": MessageLookupByLibrary.simpleMessage("Sync Error"),
    "syncNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Sync not available",
    ),
    "syncNow": MessageLookupByLibrary.simpleMessage("Sync Now"),
    "syncTitle": MessageLookupByLibrary.simpleMessage("Sync"),
    "syncingHero": MessageLookupByLibrary.simpleMessage("Syncing..."),
    "syncingPaused": MessageLookupByLibrary.simpleMessage("Syncing Paused"),
    "syncingPausedDesc": MessageLookupByLibrary.simpleMessage("Paused"),
    "syncingToCloud": MessageLookupByLibrary.simpleMessage("Syncing to Cloud"),
    "tapCheckLongPressMenu": MessageLookupByLibrary.simpleMessage(
      "Tap to check, long press for menu",
    ),
    "tapSyncNowToRetry": MessageLookupByLibrary.simpleMessage(
      "Tap Sync Now to retry",
    ),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Target value"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Terms and Conditions",
    ),
    "testConnectionAndSave": MessageLookupByLibrary.simpleMessage(
      "Test Connection & Save",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeSelect": m0,
    "thisChangesYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "This changes your login password for Habo.",
    ),
    "todayAt": m28,
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
    "typeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Type DELETE to confirm",
    ),
    "unableToVerifyIdentity": MessageLookupByLibrary.simpleMessage(
      "Unable to verify identity",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Unarchive"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage("Unarchive habit"),
    "undo": MessageLookupByLibrary.simpleMessage("Undo"),
    "unexpectedErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again.",
    ),
    "unit": MessageLookupByLibrary.simpleMessage("Unit"),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unlockAndSync": MessageLookupByLibrary.simpleMessage("Unlock & Sync"),
    "unlockPasswordExplanation": MessageLookupByLibrary.simpleMessage(
      "This is the password you created when you first set up sync on another device.",
    ),
    "unlockSyncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Unlock Sync & Backup",
    ),
    "unlockYourData": MessageLookupByLibrary.simpleMessage("Unlock Your Data"),
    "updateYourEncryptionPassword": MessageLookupByLibrary.simpleMessage(
      "Update your encryption password",
    ),
    "updateYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Update your login password",
    ),
    "urlIsRequired": MessageLookupByLibrary.simpleMessage("URL is required"),
    "urlMustStartWithHttpOrHttps": MessageLookupByLibrary.simpleMessage(
      "URL must start with https:// or http://",
    ),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage("Use Two day rule"),
    "verificationEmailResent": MessageLookupByLibrary.simpleMessage(
      "Verification email resent!",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "View archived habits",
    ),
    "viewOrCancelYourPlan": MessageLookupByLibrary.simpleMessage(
      "View or cancel your plan",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Warning"),
    "weSentVerificationLinkTo": MessageLookupByLibrary.simpleMessage(
      "We sent a verification link to",
    ),
    "week": MessageLookupByLibrary.simpleMessage("Week"),
    "weekdayAt": m29,
    "welcomeBackStayConsistent": MessageLookupByLibrary.simpleMessage(
      "Welcome back! Let\'s stay consistent.",
    ),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("What\'s New"),
    "whatsNewVersion": m16,
    "willSyncWhenConnected": MessageLookupByLibrary.simpleMessage(
      "Will sync when connected",
    ),
    "yesterdayAt": m30,
    "youAreOffline": MessageLookupByLibrary.simpleMessage("You\'re offline"),
    "yourCommentHere": MessageLookupByLibrary.simpleMessage("Your note here"),
    "zeroKnowledgePrivacy": MessageLookupByLibrary.simpleMessage(
      "Zero-Knowledge Privacy",
    ),
    "zeroKnowledgePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "State-of-the-art End-to-End Encryption. Only you hold the master key — we can never read or access your personal data.",
    ),
  };
}
