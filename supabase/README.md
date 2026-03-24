# Habo Supabase Backend

This directory contains the Supabase backend for **Habo Sync** — the cloud sync and backup feature for [Habo](https://github.com/xpavle00/Habo).

## Overview

Habo Sync requires a Supabase backend. You have two options:

| Option | Description |
|--------|-------------|
| **Habo Cloud** (default) | Use the official Habo Cloud server — no setup required. Sync features require an active subscription. |
| **Self-Hosted** | Host your own Supabase project. All sync features are available without a subscription. |

> [!NOTE]
> If you just want to use Habo with sync and don't need to manage your own server, use **Habo Cloud** — it works out of the box.

---

## Self-Hosting Guide

### Prerequisites

- A [Supabase](https://supabase.com) account (free tier works)
- [Node.js](https://nodejs.org) (includes `npx` for running the Supabase CLI)
- The Habo app installed on your device

### 1. Create a Supabase Project

Go to [supabase.com](https://supabase.com) and create a new project. Note your **project reference ID** (visible in the URL: `https://supabase.com/dashboard/project/<ref>`).

### 2. Clone the Repository

```bash
git clone https://github.com/xpavle00/Habo.git
cd Habo
```

### 3. Link to Your Supabase Project

```bash
npx supabase link --project-ref <your-project-ref>
```

You will be prompted for your database password.

### 4. Apply Database Migrations

> [!WARNING]
> This pushes migrations to your **remote** Supabase project. Only run this against your own self-hosted project.

```bash
npx supabase db push
```

This creates all required tables, functions, RLS policies, and the storage bucket.

### 5. Deploy the Edge Function

> [!WARNING]
> This deploys to your **remote** Supabase project. Only run against your own self-hosted project.

```bash
npx supabase functions deploy delete-account
```

### 6. Configure the Habo App

1. Go to your Supabase dashboard → **Settings → API**
2. Copy the **Project URL** and **anon/public key**
3. In Habo, go to **Settings → Server**
4. Paste the URL and anon key
5. Tap **Test Connection & Save**
6. Close and reopen the app

### 7. Sign Up and Sync

1. Go to **Settings → Habo Sync**
2. Sign up with email and password
3. Set up a master password for encryption
4. Your habits will sync automatically

---

## Directory Structure

```
supabase/
├── migrations/          # Database schema & RLS policies
├── functions/
│   ├── delete-account/  # Account deletion edge function
│   └── revenuecat-webhook/  # Subscription webhook (Habo Cloud only)
└── config.toml          # Supabase local dev configuration
```

---

## How It Works

- The `app_settings` table has a `self_hosted` flag set to `true` by default
- This flag makes the `has_active_subscription()` database function return `true` for all users
- All RLS policies use this function, so all sync features are accessible
- The Habo app detects the `self_hosted` flag and skips subscription checks

---

## Troubleshooting

### "Could not connect to server" error

- Verify your Supabase URL and anon key are correct
- Ensure the database migration was applied (`npx supabase db push`)
- Check that the project is running (Supabase dashboard should be accessible)

### Sync not working after setup

- Make sure you closed and reopened the app after changing the server
- Check that you signed up on your self-hosted server (not the default Habo Cloud)
- Verify the `delete-account` edge function was deployed

### Social login not available

- Self-hosted instances only support email/password authentication
- Google and Apple sign-in require OAuth configuration in the Supabase dashboard

---

## Disclaimer

> [!CAUTION]
> When self-hosting, **you** are solely responsible for the security, availability, and backup of your Supabase instance and its data. The Habo team does not provide support, uptime guarantees, or data recovery for self-hosted deployments. This software is provided "as is" under the [GPL-3.0 License](../LICENSE), without warranty of any kind.

---

## License

See the [LICENSE](../LICENSE) file in the root of the repository.
