<div align="center">

<img src="https://habo.space/images/logo.svg" alt="Habo Logo" height="80" />

# Habo

**Simple, open-source habit tracker for Android & iOS**

[![Stars](https://img.shields.io/github/stars/xpavle00/Habo?style=flat-square&color=FFD700)](https://github.com/xpavle00/Habo/stargazers)
[![Forks](https://img.shields.io/github/forks/xpavle00/Habo?style=flat-square)](https://github.com/xpavle00/Habo/network/members)
[![Issues](https://img.shields.io/github/issues/xpavle00/Habo?style=flat-square)](https://github.com/xpavle00/Habo/issues)
[![License](https://img.shields.io/badge/license-GPL--3.0-blue?style=flat-square)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Weblate](https://img.shields.io/badge/translations-Weblate-brightgreen?style=flat-square)](https://hosted.weblate.org/projects/habo/)

<br/>

[<img src="https://habo.space/images/googleplay_badge_hu_edf4094967c7bf97.webp" height="50" alt="Get it on Google Play" />](https://play.google.com/store/apps/details?id=com.pavlenko.Habo)&nbsp;&nbsp;
[<img src="https://habo.space/images/appstore_badge_black.svg" height="50" alt="Download on the App Store" />](https://apps.apple.com/us/app/habo-habit-tracker/id1670223360)&nbsp;&nbsp;
[<img src="https://habo.space/images/izzy_badge_hu_1e22e7507a064b3b.webp" height="50" alt="Get it on IzzyOnDroid" />](https://apt.izzysoft.de/fdroid/index/apk/com.pavlenko.Habo)

⭐ 4.9/5 on iOS &nbsp;·&nbsp; ⭐ 4.6/5 on Google Play

</div>

---

<p align="center">
  <!-- <img src="https://habo.space/img/social/github_hero.png" width="700" alt="Habo screenshots" /> -->
  <img width="1400" height="600" alt="Frame 32" src="https://github.com/user-attachments/assets/02703166-db15-44f9-9c01-d065d9153af4" />
</p> 

## What is Habo?

Habo is a fast, minimalist habit tracker that respects your privacy. No accounts required. No data harvesting. No clutter, just a clean, focused tool for building routines that stick.

**Habo 4.0** ships cross-device sync with end-to-end encryption, automatic encrypted backups, and full self-hosting support. Your habit data is yours, always.

---

## Features

### ☁️ Habo Sync: E2E Encrypted, Zero-Knowledge
Your data is encrypted on your device before it ever leaves it. The server sees only ciphertext: we cannot read your habits, notes, or streaks. Not even if we wanted to.

- Data encrypted locally with your Master Password before upload
- Zero-knowledge architecture: no plaintext ever touches the server
- Device-generated encryption keys
- Automatic encrypted backups: switch phones without losing your history
- **Self-hostable**: run your own Supabase backend, free forever

### 📱 Core Tracking
- **Multiple completion types**: yes/no, numeric, skip (doesn't break streaks)
- **Notes & comments**: add context to each check-in
- **Smart reminders**: gentle nudges at the right time
- **Calendar view**: see streaks and completions on a monthly grid
- **Statistics**: streaks, trends, and completions over time

### 🎨 Personalization
- Dark, Light, and OLED themes
- Material You support (Android)
- Custom button colors
- Drag-and-drop habit reordering
- Categories to group habits by theme

### 🔒 Privacy & Control
- **Offline first**: everything works without an internet connection
- **Biometric lock**: Face ID, Touch ID, or passcode
- **Export & backup**: own your data, always
- **Archive**: pause habits without losing history
- **URL scheme**: deep-link into Habo from Shortcuts and other apps
- **Open source**: GPL-3.0 licensed, auditable, forkable

### 🌍 Translations
Community-contributed translations via [Weblate](https://hosted.weblate.org/projects/habo/). Want to help bring Habo to your language? Contributions are welcome: no coding required.

---

## Self-Hosting

Habo Sync can run on your own Supabase backend. All sync features are available without a subscription.

> **Self-hosting is free, forever.**

### Prerequisites
- A [Supabase](https://supabase.com) account: the free tier is enough
- Node.js (for the Supabase CLI via `npx`)

### Setup

```bash
# 1. Clone the repo
git clone https://github.com/xpavle00/Habo.git
cd Habo

# 2. Link to your Supabase project
npx supabase link --project-ref <your-project-ref>

# 3. Apply database migrations
npx supabase db push

# 4. Deploy the edge function
npx supabase functions deploy delete-account
```

Then in the Habo app: **Settings → Server**, paste your Supabase Project URL and anon key, and tap **Test Connection & Save**.

→ Full details and troubleshooting in [`supabase/README.md`](supabase/README.md)

---

## Building from Source

**Requirements**
- Flutter 3.x
- Dart SDK (bundled with Flutter)
- Android Studio or Xcode for device targets

```bash
git clone https://github.com/xpavle00/Habo.git
cd Habo
flutter pub get
flutter run
```

---

## Contributing

Contributions are welcome and appreciated. Here's how to help:

- **Bug reports & feature requests** → [Open an issue](https://github.com/xpavle00/Habo/issues)
- **Code contributions** → Fork, branch, PR: please open an issue first for large changes
- **Translations** → Join the project on [Weblate](https://hosted.weblate.org/projects/habo/) - no coding required

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a pull request.

---

## Support the Project

Habo is a one-person project built in the open. If it's useful to you, consider supporting its development:

- ⭐ Star the repo: it helps others find the project
- ☕ [Buy me a coffee](https://buymeacoffee.com/peterpavlenko)
- 💬 Leave a review on the [App Store](https://apps.apple.com/us/app/habo-habit-tracker/id1670223360) or [Google Play](https://play.google.com/store/apps/details?id=com.pavlenko.Habo)
- 🌐 Subscribe to Habo Sync: hosted sync funds continued development

---

## License

Habo is released under the [GNU General Public License v3.0](LICENSE).

---

<div align="center">

**[habo.space](https://habo.space)** &nbsp;·&nbsp; [Privacy Policy](https://habo.space/terms#privacy) &nbsp;·&nbsp; [Sync](https://habo.space/sync)

Made with ❤️ by [Peter Pavlenko](https://github.com/xpavle00)

</div>
