// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  String get localeName => 'id';

  static String m17(error) => "Kesalahan Sign In Apple: ${error}";

  static String m1(authMethod) =>
      "Silakan autentikasi menggunakan ${authMethod} untuk mengakses Habo";

  static String m2(authMethod) =>
      "Silakan autentikasi menggunakan ${authMethod} untuk mengakses kebiasaan Anda";

  static String m3(authMethod) => "Amankan aplikasi dengan ${authMethod}";

  static String m4(title) => "Kategori \"${title}\" sudah ada";

  static String m5(title) => "Kategori \"${title}\" berhasil dibuat";

  static String m6(title) => "Kategori \"${title}\" berhasil dihapus";

  static String m7(title) => "Kategori \"${title}\" berhasil diperbarui";

  static String m18(e) =>
      "Tidak dapat terhubung ke server. Periksa URL, anon key, dan pastikan migrasi Habo sudah diterapkan.\n\nKesalahan: ${e}";

  static String m8(current, unit) => "Saat ini: ${current} ${unit}";

  static String m9(title) =>
      "Apakah Anda yakin ingin menghapus \"${title}\"?\n\nIni akan menghapus kategori dari semua kebiasaan yang menggunakannya.";

  static String m19(error) => "Kesalahan: ${error}";

  static String m10(error) => "Gagal menghapus kategori: ${error}";

  static String m20(error) => "Gagal mengirim ulang: ${error}";

  static String m11(error) => "Gagal menyimpan kategori: ${error}";

  static String m21(count) => "${count} kebiasaan";

  static String m22(days, plural) =>
      "Terakhir disinkronkan ${days} hari${plural} lalu";

  static String m23(hours) => "Terakhir disinkronkan ${hours} jam lalu";

  static String m24(minutes) => "Terakhir disinkronkan ${minutes} menit lalu";

  static String m12(title) => "Tidak ada kebiasaan di \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m25(seconds) => "Kirim ulang dalam ${seconds}d";

  static String m26(date) =>
      "Ini akan mengganti semua data saat ini dengan cadangan dari ${date}.\n\nTindakan ini tidak dapat dibatalkan.";

  static String m27(error) => "Pemulihan gagal: ${error}";

  static String m14(count) => "Kategori Terpilih (${count})";

  static String m15(target, unit) => "Target: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Perangkat', 'light': 'Terang', 'dark': 'Gelap', 'oled': 'Hitam OLED', 'materialYou': 'Material You', 'other': 'Perangkat'})}";

  static String m28(time) => "Hari ini pukul ${time}";

  static String m29(weekday, time) => "${weekday} pukul ${time}";

  static String m16(version) => "Versi ${version}";

  static String m30(time) => "Kemarin pukul ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Tentang"),
    "accountPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Kata sandi akun berhasil diubah",
    ),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Mitra akuntabilitas",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Tambah"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Tambah Kategori"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Pengembangan kebiasaan tingkat lanjut",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Bagian ini membantu Anda mendefinisikan kebiasaan dengan lebih baik menggunakan siklus kebiasaan. Anda sebaiknya mendefinisikan pemicu, rutinitas, dan hadiah untuk setiap kebiasaan.",
    ),
    "all": MessageLookupByLibrary.simpleMessage("Semua"),
    "allCategories": MessageLookupByLibrary.simpleMessage("Semua Kategori"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Semua kebiasaan akan diganti dengan kebiasaan dari cadangan.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Izinkan"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Sudah punya akun? ",
    ),
    "anUnexpectedErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "Terjadi kesalahan yang tidak terduga",
    ),
    "anUnexpectedErrorOccurredTryAgain": MessageLookupByLibrary.simpleMessage(
      "Terjadi kesalahan yang tidak terduga. Silakan coba lagi.",
    ),
    "anonKeyIsRequired": MessageLookupByLibrary.simpleMessage(
      "Anon key wajib diisi",
    ),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifikasi aplikasi",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Channel notifikasi untuk notifikasi aplikasi",
    ),
    "appleSignInError": m17,
    "archive": MessageLookupByLibrary.simpleMessage("Arsipkan"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Arsipkan kebiasaan"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan yang Diarsipkan",
    ),
    "at7AM": MessageLookupByLibrary.simpleMessage("Pukul 7:00 pagi"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autentikasi"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Silakan autentikasi untuk mengakses Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Autentikasi untuk mengaktifkan kunci biometrik",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage(
      "Sedang mengautentikasi…",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Kesalahan autentikasi",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autentikasi Diperlukan",
    ),
    "automaticCloudBackups": MessageLookupByLibrary.simpleMessage(
      "Cadangan cloud otomatis",
    ),
    "backToSignIn": MessageLookupByLibrary.simpleMessage("Kembali ke Masuk"),
    "backup": MessageLookupByLibrary.simpleMessage("Cadangan"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Cadangan berhasil dibuat!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage(
      "Cadangan gagal dibuat!",
    ),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "ERROR: Gagal membuat cadangan.",
    ),
    "backupRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Cadangan berhasil dipulihkan!",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biometrik"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autentikasi biometrik diperlukan",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Autentikasi biometrik berhasil",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage("Kunci Biometrik"),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Kunci biometrik dinonaktifkan",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Kunci biometrik diaktifkan",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "Biometrik tidak dikenali, coba lagi",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "Biometrik diperlukan",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage(
      "Dapat dicentang (Ya/Tidak)",
    ),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Membangun Kebiasaan yang Lebih Baik",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage("Belikan saya kopi"),
    "cancel": MessageLookupByLibrary.simpleMessage("Batal"),
    "categories": MessageLookupByLibrary.simpleMessage("Kategori"),
    "category": MessageLookupByLibrary.simpleMessage("Kategori"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryName": MessageLookupByLibrary.simpleMessage("Nama kategori"),
    "categoryUpdatedSuccessfully": m7,
    "changeAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Ubah Kata Sandi Akun",
    ),
    "changeMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Ubah Kata Sandi Utama",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Ubah Kata Sandi"),
    "check": MessageLookupByLibrary.simpleMessage("Centang"),
    "checkEmailForPasswordReset": MessageLookupByLibrary.simpleMessage(
      "Periksa email Anda untuk tautan pengaturan ulang kata sandi.",
    ),
    "checkEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Periksa email Anda untuk tautan pengaturan ulang kata sandi.",
    ),
    "checkYourEmail": MessageLookupByLibrary.simpleMessage(
      "Periksa email Anda",
    ),
    "chooseBackupToRestore": MessageLookupByLibrary.simpleMessage(
      "Pilih cadangan yang ingin dipulihkan",
    ),
    "chooseStrongPassword": MessageLookupByLibrary.simpleMessage(
      "Pilih kata sandi yang kuat untuk akun Anda.",
    ),
    "clickLinkInEmailToVerify": MessageLookupByLibrary.simpleMessage(
      "Klik tautan di email untuk memverifikasi akun Anda, lalu kembali ke sini dan ketuk tombol di bawah.",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Tutup"),
    "complete": MessageLookupByLibrary.simpleMessage("Selesai"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Konfirmasi Kata Sandi Baru",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Konfirmasi Kata Sandi",
    ),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Selamat! Hadiah Anda:",
    ),
    "connectedToCloud": MessageLookupByLibrary.simpleMessage(
      "Terhubung ke Cloud",
    ),
    "connectedToCustomServer": MessageLookupByLibrary.simpleMessage(
      "Terhubung ke server kustom",
    ),
    "connectedToHaboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Terhubung ke Habo Cloud (default)",
    ),
    "continueWithApple": MessageLookupByLibrary.simpleMessage(
      "Lanjutkan dengan Apple",
    ),
    "continueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Lanjutkan dengan Google",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "couldNotConnectToServer": m18,
    "create": MessageLookupByLibrary.simpleMessage("Buat"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Buat Akun"),
    "createAccountToBackupAndSync": MessageLookupByLibrary.simpleMessage(
      "Buat akun untuk mencadangkan & menyinkronkan.",
    ),
    "createCategory": MessageLookupByLibrary.simpleMessage("Buat kategori"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Buat kategori pertama Anda untuk mengatur kebiasaan",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Buat Kebiasaan"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Buat kebiasaan dan tetapkan ke kategori ini",
    ),
    "createMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Buat Kata Sandi Utama",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Buat kebiasaan pertama Anda.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Pemicu"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "adalah pemicu yang memulai kebiasaan Anda. Ini bisa berupa waktu tertentu, lokasi, perasaan, atau suatu peristiwa.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Pemicu"),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "Kata Sandi Saat Ini",
    ),
    "currentPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Kata sandi saat ini wajib diisi",
    ),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Streak saat ini"),
    "customServer": MessageLookupByLibrary.simpleMessage("Server kustom"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "dataBeingSynchronized": MessageLookupByLibrary.simpleMessage(
      "Data Anda sedang disinkronkan",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Tanggal"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Tentukan kebiasaan Anda",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Agar lebih konsisten menjalankan kebiasaan, Anda dapat menentukan:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Hapus"),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage("Hapus Akun"),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Tindakan ini bersifat permanen dan tidak dapat dibatalkan. Data berikut akan dihapus secara permanen:",
    ),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Hapus Kategori"),
    "deleteCategoryConfirmation": m9,
    "deleteCloudBackupsAndSyncData": MessageLookupByLibrary.simpleMessage(
      "Cadangan cloud dan data sinkronisasi",
    ),
    "deleteEncryptionKeysAndProfile": MessageLookupByLibrary.simpleMessage(
      "Kunci enkripsi dan profil",
    ),
    "deleteHabitsAndTrackingData": MessageLookupByLibrary.simpleMessage(
      "Semua kebiasaan dan data pelacakan Anda",
    ),
    "deleteSubscriptionManagedSeparately": MessageLookupByLibrary.simpleMessage(
      "Langganan (dikelola terpisah oleh store)",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Hapus Akun Anda",
    ),
    "deleteYourAccountAndLoginCredentials":
        MessageLookupByLibrary.simpleMessage("Akun Anda dan kredensial login"),
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Kredensial perangkat diperlukan",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "PIN, Pola, atau Kata Sandi perangkat",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Penafian"),
    "disconnectFromSelfHosted": MessageLookupByLibrary.simpleMessage(
      "Ini akan memutuskan koneksi dari server self-hosted Anda dan beralih kembali ke server default Habo Cloud. Anda perlu masuk lagi.",
    ),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Lakukan 50 push-up"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Jangan lupa untuk memeriksa kebiasaan Anda.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Donasikan \$10 ke badan amal",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Selesai"),
    "dontHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Belum punya akun? ",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("Ubah Kategori"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Ubah Kebiasaan"),
    "emailIsRequired": MessageLookupByLibrary.simpleMessage(
      "Email wajib diisi",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "emailPasswordAndAccount": MessageLookupByLibrary.simpleMessage(
      "Email, kata sandi, dan akun",
    ),
    "emptyList": MessageLookupByLibrary.simpleMessage("Daftar kosong"),
    "endToEndEncryption": MessageLookupByLibrary.simpleMessage(
      "Enkripsi end-to-end",
    ),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Masukkan jumlah"),
    "enterCurrentPasswordAndChooseNew": MessageLookupByLibrary.simpleMessage(
      "Masukkan kata sandi Anda saat ini dan pilih yang baru.",
    ),
    "enterEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Masukkan alamat email Anda dan kami akan mengirimkan tautan untuk mengatur ulang kata sandi Anda.",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Masukkan email yang valid",
    ),
    "enterValidUrl": MessageLookupByLibrary.simpleMessage(
      "Masukkan URL yang valid (misalnya, https://your-project.supabase.co)",
    ),
    "enterYourPasswordToConfirm": MessageLookupByLibrary.simpleMessage(
      "Masukkan kata sandi Anda untuk konfirmasi",
    ),
    "errorText": MessageLookupByLibrary.simpleMessage("Kesalahan"),
    "errorWithDescription": m19,
    "everythingIsSafe": MessageLookupByLibrary.simpleMessage("Semuanya aman"),
    "exercise": MessageLookupByLibrary.simpleMessage("Olahraga"),
    "fail": MessageLookupByLibrary.simpleMessage("Gagal"),
    "failedToDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Gagal menghapus akun",
    ),
    "failedToDeleteCategory": m10,
    "failedToResend": m20,
    "failedToSaveCategory": m11,
    "failedToSendResetLink": MessageLookupByLibrary.simpleMessage(
      "Gagal mengirim tautan reset. Silakan coba lagi.",
    ),
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Sembunyikan kebiasaan yang აღარ lagi Anda lacak tanpa menghapusnya",
    ),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Arsip"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Atur kebiasaan dengan filter kategori",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage("Kategori"),
    "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
      "Buka Habo langsung ke layar seperti pengaturan atau buat",
    ),
    "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
      "Skema URL (deep link)",
    ),
    "featureHomescreenWidgetDarkModeDesc": MessageLookupByLibrary.simpleMessage(
      "Widget layar utama Android kini mendukung latar belakang mode terang dan gelap.",
    ),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "Lihat progres kebiasaan Anda sekilas dari layar utama (eksperimental)",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Widget layar utama",
    ),
    "featureIosSoundMixingDesc": MessageLookupByLibrary.simpleMessage(
      "Suara Habo tidak lagi mengganggu musik atau podcast Anda",
    ),
    "featureIosSoundMixingTitle": MessageLookupByLibrary.simpleMessage(
      "Perbaikan pencampuran suara",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Amankan aplikasi dengan Face ID / Touch ID / biometrik",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage("Fitur kunci"),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "Tekan lama pada tombol kebiasaan untuk mengubah status dengan cepat",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage(
      "Centang dengan tekan lama",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Warna dinamis yang menyesuaikan wallpaper Anda",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Tema Material You (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Lacak jumlah seperti gelas air yang diminum atau halaman yang dibaca",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Nilai numerik pada kebiasaan",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Volume yang dapat disesuaikan",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Mesin suara baru",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 menit bermain video game",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "File tidak ditemukan",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "File terlalu besar (maks. 10MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Sidik jari"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage(
      "Hari pertama dalam seminggu",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Lupa kata sandi?"),
    "fromPreviousBackups": MessageLookupByLibrary.simpleMessage(
      "Dari cadangan sebelumnya",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Mulai"),
    "habit": MessageLookupByLibrary.simpleMessage("Kebiasaan"),
    "habitArchived": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan diarsipkan",
    ),
    "habitContract": MessageLookupByLibrary.simpleMessage("Kontrak kebiasaan"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Meskipun penguatan positif direkomendasikan, sebagian orang mungkin memilih kontrak kebiasaan. Kontrak kebiasaan memungkinkan Anda menetapkan sanksi yang akan diberlakukan jika Anda melewatkan kebiasaan, dan dapat melibatkan mitra akuntabilitas yang membantu mengawasi tujuan Anda.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("Kebiasaan dihapus."),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Siklus kebiasaan"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "Siklus kebiasaan adalah model psikologis yang menjelaskan proses pembentukan kebiasaan. Model ini terdiri dari tiga komponen: Pemicu, Rutinitas, dan Hadiah. Pemicu memicu Rutinitas (tindakan yang menjadi kebiasaan), yang kemudian diperkuat oleh Hadiah, sehingga membentuk siklus yang membuat kebiasaan semakin tertanam dan lebih mungkin diulang.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifikasi kebiasaan",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Channel notifikasi untuk notifikasi kebiasaan",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "Judul kebiasaan tidak boleh kosong.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Jenis kebiasaan"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Arsip kebiasaan dibatalkan",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Kebiasaan:"),
    "habitsCount": m21,
    "habitsToday": MessageLookupByLibrary.simpleMessage("Kebiasaan hari ini"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Habo Cloud (default)",
    ),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo memerlukan izin untuk mengirim notifikasi agar dapat berfungsi dengan baik.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Segera Hadir"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Habo Sync telah hadir! Sinkronkan dan cadangkan kebiasaan Anda di semua perangkat dengan sinkronisasi cloud terenkripsi end-to-end.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Pelajari lebih lanjut di habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Jika Anda ingin mendukung Habo, Anda dapat:",
    ),
    "importantCannotBeRecovered": MessageLookupByLibrary.simpleMessage(
      "Penting: Tidak dapat dipulihkan",
    ),
    "incorrectCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Kata sandi saat ini salah",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Kata sandi salah",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Input"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "File cadangan tidak valid",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Iris"),
    "iveVerifiedMyEmail": MessageLookupByLibrary.simpleMessage(
      "Saya sudah memverifikasi email saya",
    ),
    "keepHabitsSafeAndSynced": MessageLookupByLibrary.simpleMessage(
      "Jaga kebiasaan Anda tetap aman dan tersinkron di semua perangkat Anda.",
    ),
    "lastSyncedDaysAgo": m22,
    "lastSyncedHoursAgo": m23,
    "lastSyncedJustNow": MessageLookupByLibrary.simpleMessage(
      "Terakhir disinkronkan baru saja",
    ),
    "lastSyncedMinsAgo": m24,
    "logYourDays": MessageLookupByLibrary.simpleMessage("Catat hari-hari Anda"),
    "manageSubscription": MessageLookupByLibrary.simpleMessage(
      "Kelola Langganan",
    ),
    "masterPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Kata sandi utama berhasil diubah",
    ),
    "masterPasswordDescriptionSetup": MessageLookupByLibrary.simpleMessage(
      "Kata sandi utama Anda mengenkripsi semua data sebelum meninggalkan perangkat Anda. Pilih sesuatu yang kuat dan mudah diingat.",
    ),
    "masterPasswordDescriptionUnlock": MessageLookupByLibrary.simpleMessage(
      "Masukkan kata sandi utama Anda untuk mendekripsi data dan mengaktifkan sinkronisasi.",
    ),
    "masterPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Kata Sandi Utama",
    ),
    "masterPasswordWarning": MessageLookupByLibrary.simpleMessage(
      "Kami tidak menyimpan kata sandi Anda. Jika Anda lupa, data Anda tidak dapat dipulihkan. Tulis dan simpan di tempat yang aman!",
    ),
    "minimum8Characters": MessageLookupByLibrary.simpleMessage(
      "Minimal 8 karakter",
    ),
    "modify": MessageLookupByLibrary.simpleMessage("Ubah"),
    "month": MessageLookupByLibrary.simpleMessage("Bulan"),
    "neverSynced": MessageLookupByLibrary.simpleMessage(
      "Belum pernah disinkronkan",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("Kata Sandi Baru"),
    "newPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Kata sandi baru wajib diisi",
    ),
    "newPasswordMustBeDifferent": MessageLookupByLibrary.simpleMessage(
      "Kata sandi baru harus berbeda dari yang saat ini",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Berikutnya"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Tidak ada kebiasaan yang diarsipkan",
    ),
    "noBackupsAvailable": MessageLookupByLibrary.simpleMessage(
      "Belum ada cadangan yang tersedia.\nCadangan dibuat secara otomatis saat sinkronisasi.",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Belum ada kategori",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Tidak ada data tentang kebiasaan.",
    ),
    "noHabitsInCategory": m12,
    "noPreviousPurchasesFound": MessageLookupByLibrary.simpleMessage(
      "Tidak ditemukan pembelian sebelumnya.",
    ),
    "notActive": MessageLookupByLibrary.simpleMessage("Tidak aktif"),
    "notConfigured": MessageLookupByLibrary.simpleMessage(
      "Belum dikonfigurasi",
    ),
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("Kurang berhasil"),
    "note": MessageLookupByLibrary.simpleMessage("Catatan"),
    "notificationTime": MessageLookupByLibrary.simpleMessage(
      "Waktu notifikasi",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifikasi"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Progresif"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan numerik memungkinkan Anda melacak progres secara bertahap sepanjang hari.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Amati progres Anda",
    ),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Oh tidak! Sanksi Anda:",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding": MessageLookupByLibrary.simpleMessage("Onboarding"),
    "oneTapCheck": MessageLookupByLibrary.simpleMessage(
      "Satu ketukan untuk centang",
    ),
    "or": MessageLookupByLibrary.simpleMessage("atau"),
    "orContinueWith": MessageLookupByLibrary.simpleMessage(
      "atau lanjutkan dengan",
    ),
    "partialValue": MessageLookupByLibrary.simpleMessage("Nilai parsial"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Untuk melacak progres dalam peningkatan yang lebih kecil",
    ),
    "passwordCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Kata sandi tidak boleh kosong",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "Kata sandi wajib diisi",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Kata Sandi"),
    "passwordMinLengthError": MessageLookupByLibrary.simpleMessage(
      "Kata sandi harus terdiri dari minimal 8 karakter",
    ),
    "passwordResetSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Kata sandi Anda berhasil diatur ulang. Anda sekarang dapat masuk dengan kata sandi baru.",
    ),
    "passwordUpdated": MessageLookupByLibrary.simpleMessage(
      "Kata Sandi Diperbarui!",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Kata sandi tidak cocok",
    ),
    "pauseSyncing": MessageLookupByLibrary.simpleMessage("Jeda Sinkronisasi"),
    "paused": MessageLookupByLibrary.simpleMessage("Dijeda"),
    "pausesSyncingAndBackup": MessageLookupByLibrary.simpleMessage(
      "Menjeda sinkronisasi dan pencadangan",
    ),
    "permanentlyDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Hapus Akun Secara Permanen",
    ),
    "permanentlyDeleteYourAccountAndData": MessageLookupByLibrary.simpleMessage(
      "Hapus akun dan data Anda secara permanen",
    ),
    "pleaseConfirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Silakan konfirmasi kata sandi Anda",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Silakan masukkan judul kategori",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Silakan masukkan alamat email yang valid",
    ),
    "pleaseSignInWithEmailAndPassword": MessageLookupByLibrary.simpleMessage(
      "Silakan masuk dengan email dan kata sandi Anda.",
    ),
    "pleaseTypeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Silakan ketik DELETE untuk konfirmasi",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Kebijakan Privasi"),
    "profile": MessageLookupByLibrary.simpleMessage("Profil"),
    "progress": MessageLookupByLibrary.simpleMessage("Progres"),
    "progressOf": m13,
    "purchasesRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Pembelian berhasil dipulihkan!",
    ),
    "realTimeSyncAcrossDevices": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi real-time di semua perangkat",
    ),
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Silakan aktifkan kembali Touch ID atau Face ID Anda",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Pengingat hadiah setelah rutinitas berhasil.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "Pengingat sanksi setelah rutinitas tidak berhasil.",
    ),
    "resendInSeconds": m25,
    "resendVerificationEmail": MessageLookupByLibrary.simpleMessage(
      "Kirim ulang email verifikasi",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Atur ulang"),
    "resetAction": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Atur Ulang Kata Sandi",
    ),
    "resetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Masukkan alamat email Anda dan kami akan mengirimkan tautan untuk mengatur ulang kata sandi Anda.",
    ),
    "resetToHaboCloud": MessageLookupByLibrary.simpleMessage(
      "Reset ke Habo Cloud",
    ),
    "resetToHaboCloudQuestion": MessageLookupByLibrary.simpleMessage(
      "Reset ke Habo Cloud?",
    ),
    "restEasy": MessageLookupByLibrary.simpleMessage("Tenang Saja"),
    "restEasyDesc": MessageLookupByLibrary.simpleMessage(
      "Kami membuat snapshot aman dari seluruh riwayat progres Anda ke cloud. Ketenangan total, secara otomatis.",
    ),
    "restartRequired": MessageLookupByLibrary.simpleMessage(
      "Perlu Mulai Ulang",
    ),
    "restartRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Silakan tutup dan buka kembali aplikasi untuk terhubung ke server baru.",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Pulihkan"),
    "restoreBackupConfirmation": m26,
    "restoreBackupQuestion": MessageLookupByLibrary.simpleMessage(
      "Pulihkan Cadangan?",
    ),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Pemulihan berhasil diselesaikan!",
    ),
    "restoreData": MessageLookupByLibrary.simpleMessage("Pulihkan Data"),
    "restoreFailed": MessageLookupByLibrary.simpleMessage("Pemulihan gagal!"),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "ERROR: Gagal memulihkan cadangan.",
    ),
    "restoreFailedTryAgain": MessageLookupByLibrary.simpleMessage(
      "Pemulihan gagal. Silakan coba lagi.",
    ),
    "restoreFailedWithError": m27,
    "restorePurchases": MessageLookupByLibrary.simpleMessage(
      "Pulihkan Pembelian",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Hadiah"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "adalah manfaat atau perasaan positif yang Anda alami setelah melakukan rutinitas. Ini memperkuat kebiasaan.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Hadiah"),
    "routine": MessageLookupByLibrary.simpleMessage("Rutinitas"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "adalah tindakan yang Anda lakukan sebagai respons terhadap pemicu. Inilah kebiasaan itu sendiri.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rutinitas"),
    "sanction": MessageLookupByLibrary.simpleMessage("Sanksi"),
    "save": MessageLookupByLibrary.simpleMessage("Simpan"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Simpan Progres"),
    "seamlessContinuity": MessageLookupByLibrary.simpleMessage(
      "Kontinuitas Tanpa Hambatan",
    ),
    "seamlessContinuityDesc": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan Anda, tersinkron sempurna di mana pun. Mulai mencatat di ponsel Anda, lalu centang di tablet Anda tanpa hambatan.",
    ),
    "searchIcons": MessageLookupByLibrary.simpleMessage("Cari"),
    "selectCategories": MessageLookupByLibrary.simpleMessage("Pilih Kategori"),
    "selectIcon": MessageLookupByLibrary.simpleMessage("Pilih ikon"),
    "selectedCategories": m14,
    "selfHostDescription": MessageLookupByLibrary.simpleMessage(
      "Host sendiri backend Supabase Anda untuk akses sinkronisasi penuh tanpa langganan. Lihat panduan self-hosting untuk petunjuk penyiapan.",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage("Kirim Tautan Reset"),
    "server": MessageLookupByLibrary.simpleMessage("Server"),
    "serverConfiguration": MessageLookupByLibrary.simpleMessage(
      "Konfigurasi Server",
    ),
    "setColors": MessageLookupByLibrary.simpleMessage("Atur warna"),
    "setNewPassword": MessageLookupByLibrary.simpleMessage(
      "Tetapkan Kata Sandi Baru",
    ),
    "setPassword": MessageLookupByLibrary.simpleMessage("Tetapkan Kata Sandi"),
    "setUpSyncToEnable": MessageLookupByLibrary.simpleMessage(
      "Siapkan sinkronisasi untuk mengaktifkan",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Silakan atur kredensial perangkat di pengaturan",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Silakan atur sidik jari atau face unlock di pengaturan perangkat",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Silakan atur Touch ID atau Face ID Anda di pengaturan perangkat",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage(
      "Tampilkan Kategori",
    ),
    "showMonthName": MessageLookupByLibrary.simpleMessage(
      "Tampilkan nama bulan",
    ),
    "showReward": MessageLookupByLibrary.simpleMessage("Tampilkan hadiah"),
    "showSanction": MessageLookupByLibrary.simpleMessage("Tampilkan sanksi"),
    "signIn": MessageLookupByLibrary.simpleMessage("Masuk"),
    "signInFailedPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Gagal masuk. Silakan coba lagi.",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Keluar"),
    "signOutConfirmationContent": MessageLookupByLibrary.simpleMessage(
      "Anda perlu memasukkan lagi kata sandi utama untuk mengakses data yang tersinkron.",
    ),
    "signOutQuestion": MessageLookupByLibrary.simpleMessage("Keluar?"),
    "signUp": MessageLookupByLibrary.simpleMessage("Daftar"),
    "skip": MessageLookupByLibrary.simpleMessage("Lewati"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Lewati (tidak memengaruhi streak)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Slider"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Efek suara"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Kode sumber (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistik"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Berlangganan"),
    "subscribeToEnableSync": MessageLookupByLibrary.simpleMessage(
      "Berlangganan untuk mengaktifkan Habo Sync",
    ),
    "subscriptionNeeded": MessageLookupByLibrary.simpleMessage(
      "Perlu berlangganan",
    ),
    "successful": MessageLookupByLibrary.simpleMessage("Berhasil"),
    "syncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi & Cadangan",
    ),
    "syncAndBackupYourData": MessageLookupByLibrary.simpleMessage(
      "Sinkronkan dan cadangkan data Anda",
    ),
    "syncError": MessageLookupByLibrary.simpleMessage("Kesalahan Sinkronisasi"),
    "syncNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi tidak tersedia",
    ),
    "syncNow": MessageLookupByLibrary.simpleMessage("Sinkronkan Sekarang"),
    "syncTitle": MessageLookupByLibrary.simpleMessage("Sinkronisasi"),
    "syncingHero": MessageLookupByLibrary.simpleMessage("Menyinkronkan..."),
    "syncingPaused": MessageLookupByLibrary.simpleMessage(
      "Sinkronisasi Dijeda",
    ),
    "syncingPausedDesc": MessageLookupByLibrary.simpleMessage("Dijeda"),
    "syncingToCloud": MessageLookupByLibrary.simpleMessage(
      "Menyinkronkan ke Cloud",
    ),
    "tapCheckLongPressMenu": MessageLookupByLibrary.simpleMessage(
      "Ketuk untuk centang, tekan lama untuk menu",
    ),
    "tapSyncNowToRetry": MessageLookupByLibrary.simpleMessage(
      "Ketuk Sinkronkan Sekarang untuk mencoba lagi",
    ),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Nilai target"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Syarat dan Ketentuan",
    ),
    "testConnectionAndSave": MessageLookupByLibrary.simpleMessage(
      "Uji Koneksi & Simpan",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeSelect": m0,
    "thisChangesYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Ini akan mengubah kata sandi login Anda untuk Habo.",
    ),
    "todayAt": m28,
    "topStreak": MessageLookupByLibrary.simpleMessage("Rekor streak"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Sentuh sensor"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Anda dapat melacak progres melalui tampilan kalender di setiap kebiasaan atau di halaman statistik.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Coba Lagi"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Aturan dua hari"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Dengan aturan dua hari, Anda dapat melewatkan satu hari dan tidak kehilangan streak jika hari berikutnya berhasil.",
    ),
    "typeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Ketik DELETE untuk konfirmasi",
    ),
    "unableToVerifyIdentity": MessageLookupByLibrary.simpleMessage(
      "Tidak dapat memverifikasi identitas",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Batalkan arsip"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Batalkan arsip kebiasaan",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Urungkan"),
    "unexpectedErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Terjadi kesalahan yang tidak terduga. Silakan coba lagi.",
    ),
    "unit": MessageLookupByLibrary.simpleMessage("Satuan"),
    "unknown": MessageLookupByLibrary.simpleMessage("Tidak diketahui"),
    "unlockAndSync": MessageLookupByLibrary.simpleMessage("Buka & Sinkronkan"),
    "unlockPasswordExplanation": MessageLookupByLibrary.simpleMessage(
      "Ini adalah kata sandi yang Anda buat saat pertama kali menyiapkan sinkronisasi di perangkat lain.",
    ),
    "unlockSyncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Buka Sinkronisasi & Cadangan",
    ),
    "unlockYourData": MessageLookupByLibrary.simpleMessage("Buka Data Anda"),
    "updateYourEncryptionPassword": MessageLookupByLibrary.simpleMessage(
      "Perbarui kata sandi enkripsi Anda",
    ),
    "updateYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Perbarui kata sandi login Anda",
    ),
    "urlIsRequired": MessageLookupByLibrary.simpleMessage("URL wajib diisi"),
    "urlMustStartWithHttpOrHttps": MessageLookupByLibrary.simpleMessage(
      "URL harus diawali dengan https:// atau http://",
    ),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Gunakan aturan dua hari",
    ),
    "verificationEmailResent": MessageLookupByLibrary.simpleMessage(
      "Email verifikasi berhasil dikirim ulang!",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Lihat kebiasaan yang diarsipkan",
    ),
    "viewOrCancelYourPlan": MessageLookupByLibrary.simpleMessage(
      "Lihat atau batalkan paket Anda",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Peringatan"),
    "weSentVerificationLinkTo": MessageLookupByLibrary.simpleMessage(
      "Kami mengirim tautan verifikasi ke",
    ),
    "week": MessageLookupByLibrary.simpleMessage("Minggu"),
    "weekdayAt": m29,
    "welcomeBackStayConsistent": MessageLookupByLibrary.simpleMessage(
      "Selamat datang kembali! Mari tetap konsisten.",
    ),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Yang Baru"),
    "whatsNewVersion": m16,
    "willSyncWhenConnected": MessageLookupByLibrary.simpleMessage(
      "Akan disinkronkan saat terhubung",
    ),
    "yesterdayAt": m30,
    "youAreOffline": MessageLookupByLibrary.simpleMessage(
      "Anda sedang offline",
    ),
    "yourCommentHere": MessageLookupByLibrary.simpleMessage(
      "Catatan Anda di sini",
    ),
    "zeroKnowledgePrivacy": MessageLookupByLibrary.simpleMessage(
      "Privasi Zero-Knowledge",
    ),
    "zeroKnowledgePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "Enkripsi End-to-End mutakhir. Hanya Anda yang memegang kunci utama — kami tidak pernah dapat membaca atau mengakses data pribadi Anda.",
    ),
  };
}
