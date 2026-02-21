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

  static String m1(authMethod) =>
      "Silakan autentikasi untuk mengakses Habo menggunakan ${authMethod}";

  static String m2(authMethod) =>
      "Silakan autentikasi menggunakan ${authMethod} untuk mengakses kebiasaan Anda";

  static String m3(authMethod) => "Amankan aplikasi dengan ${authMethod}";

  static String m4(title) => "Kategori \"${title}\" sudah ada";

  static String m5(title) => "Kategori \"${title}\" berhasil dibuat";

  static String m6(title) => "Kategori \"${title}\" berhasil dihapus";

  static String m7(title) => "Kategori \"${title}\" berhasil diperbarui";

  static String m8(current, unit) => "Saat ini: ${current} ${unit}";

  static String m9(title) =>
      "Apakah Anda yakin ingin menghapus \"${title}\"?\n\nIni akan menghapus kategori dari semua kebiasaan yang menggunakannya.";

  static String m10(error) => "Gagal menghapus kategori: ${error}";

  static String m11(error) => "Gagal menyimpan kategori: ${error}";

  static String m12(title) => "Tidak ada kebiasaan di \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m14(count) => "Kategori Terpilih ${count}";

  static String m15(target, unit) => "Target : ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Perangkat', 'light': 'Terang', 'dark': 'Gelap', 'oled': 'Gelap OLED', 'materialYou': 'Material You', 'other': 'Perangkat'})}";

  static String m16(version) => "Versi ${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Tentang"),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Teman Penanggungjawab",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Tambah"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Tambah Kategori"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Membangun kebiasaan tingkat lanjut",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Bagian ini membantu kamu mendefinisikan kebiasaan dengan lebih jelas menggunakan Kebiasaan Berulang. Kamu perlu menentukan pemicu, rutinitas, dan hadiah untuk setiap kebiasaan.",
    ),
    "allCategories": MessageLookupByLibrary.simpleMessage("Semua Kategori"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan Anda akan diganti dengan data cadangan.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Izinkan"),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifikasi aplikasi",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Saluran notifikasi untuk notifikasi aplikasi",
    ),
    "archive": MessageLookupByLibrary.simpleMessage("Arsipkan"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Arsipkan Kebiasaan"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage("Kebiasaan Diarsip"),
    "at7AM": MessageLookupByLibrary.simpleMessage("Jam 7 Pagi"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Mengautentikasi"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Silakan autentikasi untuk mengakses Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Autentikasi untuk mengaktifkan kunci biometrik",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage("Mengautentikasi…"),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Kesalahan autentikasi",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Otentikasi Diperlukan",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Cadangan"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Cadangan berhasil dibuat!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage("Pencadangan gagal!"),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "EROR: Gagal membuat cadangan.",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biometrik"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Diperlukan otentikasi biometrik",
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
      "Diperlukan biometrik",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage("Kebiasaan Sederhana"),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Membangun Kebiasaan yang Lebih Baik",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage(
      "Membelikan aku segelas kopi",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Batal"),
    "categories": MessageLookupByLibrary.simpleMessage("Kategori"),
    "category": MessageLookupByLibrary.simpleMessage("Kategori"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryUpdatedSuccessfully": m7,
    "check": MessageLookupByLibrary.simpleMessage("Cek"),
    "close": MessageLookupByLibrary.simpleMessage("Tutup"),
    "complete": MessageLookupByLibrary.simpleMessage("Tercapai"),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Selamat! Kamu mendapatkan:",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("©2023 Habo"),
    "create": MessageLookupByLibrary.simpleMessage("Buat"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Buat kategori pertamamu untuk mengelola kebiasaan",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Buat Kebiasaan"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Buat kebiasaan dan tetapkan ke kategori ini",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Buat kebiasaan pertama Anda.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Pemicu"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "adalah hal yang memulai kebiasaanmu. Bisa berupa: waktu tertentu, lokasi, perasaan, atau sebuah kejadian.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Pemicu"),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Streak saat ini"),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "date": MessageLookupByLibrary.simpleMessage("Tanggal"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Tentukan kebiasaan Anda",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Untuk lebih berpegang teguh pada kebiasaanmu, kamu dapat mendefinisikan:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Hapus"),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Hapus Kategori"),
    "deleteCategoryConfirmation": m9,
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Kredensial perangkat diperlukan",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "PIN, Pola, atau Kata Sandi Perangkat",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Pernyataan Penting"),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Lakukan 50 push up"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Jangan lupa untuk memeriksa kebiasaan Anda.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Donasikan 10\$ untuk amal",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Selesai"),
    "editCategory": MessageLookupByLibrary.simpleMessage("Edit Kategori"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Edit Kebiasaan"),
    "emptyList": MessageLookupByLibrary.simpleMessage("Daftar kosong"),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Masukkan jumlah"),
    "exercise": MessageLookupByLibrary.simpleMessage("Latihan"),
    "fail": MessageLookupByLibrary.simpleMessage("Gagal"),
    "failedToDeleteCategory": m10,
    "failedToSaveCategory": m11,
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Sembunyikan kebiasaan yang tidak Anda lacak lagi tanpa dihapus",
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
      "Skema URL (tautan dalam)",
    ),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "Melihat kemajuan kebiasaan Anda secara sekilas dari layar utama (eksperimental)",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Widget layar utama",
    ),
    "featureIosSoundMixingDesc": MessageLookupByLibrary.simpleMessage(
      "Suara Habo tidak lagi mengganggu musik atau podcast Anda",
    ),
    "featureIosSoundMixingTitle": MessageLookupByLibrary.simpleMessage(
      "Pencampuran suara tetap",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Amankan aplikasi dengan Face ID / Touch ID / biometrik",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage("Fitur kunci"),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "Tekan lama pada kebiasaan untuk mengubah status dengan cepat",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage(
      "Periksa tekan lama",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Warna dinamis yang cocok dengan wallpaper Anda",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Tema Material You (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Lacak jumlah seperti halaman buku yang dibaca atau berapa gelas air yang diminum",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Nilai numerik dalam kebiasaan",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Volume yang dapat disesuaikan",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Mesin suara baru",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 menit bermain game",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "File tidak ditemukan",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "File terlalu besar (maks 10MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Sidik jari"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage(
      "Hari pertama dalam minggu",
    ),
    "habit": MessageLookupByLibrary.simpleMessage("Kebiasaan"),
    "habitArchived": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan yang diarsipkan",
    ),
    "habitContract": MessageLookupByLibrary.simpleMessage("Kontrak kebiasaaan"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Meskipun penguatan positif lebih dianjurkan, sebagian orang memilih menggunakan kontrak kebiasaan. Kontrak kebiasaan memungkinkan kamu menentukan sanksi yang akan diberlakukan jika melewatkan kebiasaan, dan dapat melibatkan teman yang membantu mengawasi tujuanmu.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan telah dihapus.",
    ),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Kebiasaan Berulang"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan Berulang adalah model psikologis yang menjelaskan bahwa kebiasaan terbentuk melalui lingkaran Isyarat → Rutinitas → Hadiah yang saling memperkuat sehingga kebiasaan semakin tertanam dan mudah diulangi.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifikasi Kebiasaan",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Saluran notifikasi untuk notifikasi kebiasaan",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "Judul kebiasaan tidak boleh dikosongi.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Jenis kebiasaan"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan yang tidak diarsipkan",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Kebiasaan:"),
    "habitsToday": MessageLookupByLibrary.simpleMessage("Kebiasaan hari ini"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "Habo membutuhkan izin untuk mengirim notifikasi agar berfungsi dengan baik.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Segera Hadir"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "Sinkronkan kebiasaan Anda di semua perangkat dengan layanan cloud terenkripsi end-to-end Habo.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Pelajari lebih lanjut di habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Jika kamu ingin mendukung Habo, kamu bisa:",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Kolom Masukan"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "File cadangan tidak valid",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Iris Mata"),
    "logYourDays": MessageLookupByLibrary.simpleMessage("Catat hari-hari Anda"),
    "modify": MessageLookupByLibrary.simpleMessage("Edit"),
    "month": MessageLookupByLibrary.simpleMessage("Bulan"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Tidak ada kebiasaan yang diarsipkan",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Belum ada kategori",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Tidak tersedia data untuk kebiasaan ini.",
    ),
    "noHabitsInCategory": m12,
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage("Tidak tercapai"),
    "note": MessageLookupByLibrary.simpleMessage("Catatan"),
    "notificationTime": MessageLookupByLibrary.simpleMessage("Waktu pengingat"),
    "notifications": MessageLookupByLibrary.simpleMessage("Pengingat"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Kebiasaan numerik"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Kebiasaan numerik memungkinkan Anda melacak kemajuan secara bertahap sepanjang hari.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Amati kemajuamu",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Yah, Anda mendapat sanksi:",
    ),
    "onboarding": MessageLookupByLibrary.simpleMessage("Pengenalan awal"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Nilai parsial"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Untuk melacak kemajuan dalam peningkatan yang lebih kecil",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Silakan masukkan judul kategori",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Kebijakan Privasi"),
    "progress": MessageLookupByLibrary.simpleMessage("Kemajuan"),
    "progressOf": m13,
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Aktifkan kembali Touch ID atau Face ID Anda",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "Pengingat hadiah setelah kebiasaan yang tercapai.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "Pengingat sanksi setelah rutinitas tidak tercapai.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Atur Ulang"),
    "restore": MessageLookupByLibrary.simpleMessage("Pulihkan"),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Pemulihan berhasil diselesaikan!",
    ),
    "restoreFailed": MessageLookupByLibrary.simpleMessage("Pemulihan gagal!"),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "EROR: Gagal memulihkan cadangan.",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Hadiah"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "adalah manfaat atau perasaan positif yang kamu rasakan setelah melakukan rutinitas; hal ini memperkuat kebiasaanmu.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Hadiah"),
    "routine": MessageLookupByLibrary.simpleMessage("Rutinitas"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "adalah tindakan yang kamu lakukan sebagai respon terhadap pemicu; inilah kebiasaan itu sendiri.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rutinitas"),
    "sanction": MessageLookupByLibrary.simpleMessage("Sanksi"),
    "save": MessageLookupByLibrary.simpleMessage("Simpan"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Simpan Kemajuan"),
    "selectCategories": MessageLookupByLibrary.simpleMessage("Pilih Kategori"),
    "selectedCategories": m14,
    "setColors": MessageLookupByLibrary.simpleMessage("Atur warna"),
    "settings": MessageLookupByLibrary.simpleMessage("Pengaturan"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Silakan atur kredensial perangkat di pengaturan",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Silakan atur sidik jari atau buka kunci wajah Anda di pengaturan perangkat",
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
    "skip": MessageLookupByLibrary.simpleMessage("Lewati"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Lewati (tidak memengaruhi streak)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Bilah Geser"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Efek suara"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Kode Sumber (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Statistik"),
    "successful": MessageLookupByLibrary.simpleMessage("Tercapai"),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Nilai target"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Syarat dan Ketentuan",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeSelect": m0,
    "topStreak": MessageLookupByLibrary.simpleMessage("Streak terbaik"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Sensor sentuh"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Kamu dapat melacak kemajuan melalui tampilan kalender di setiap kebiasaan atau di halaman statistik.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Coba Lagi"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Metode Dua Hari"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Dengan metode Dua Hari, kamu boleh melewatkan satu hari tanpa kehilangan streak, asalkan hari berikutnya tercapai.",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Batalkan arsip"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage("Hapus dari arsip"),
    "undo": MessageLookupByLibrary.simpleMessage("Batalkan"),
    "unit": MessageLookupByLibrary.simpleMessage("Satuan"),
    "unknown": MessageLookupByLibrary.simpleMessage("Tidak diketahui"),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Pakai metode Dua-Hari",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Lihat kebiasaan yang diarsipkan",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Peringatan"),
    "week": MessageLookupByLibrary.simpleMessage("Minggu"),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("Apa yang baru"),
    "whatsNewVersion": m16,
    "yourCommentHere": MessageLookupByLibrary.simpleMessage(
      "Tuliskan catatan di sini",
    ),
  };
}
