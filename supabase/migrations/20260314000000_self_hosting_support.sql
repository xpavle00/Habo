-- Self-hosting support migration
-- CLOUD DEPLOYMENT: After applying, run:
--   UPDATE app_settings SET value = 'false' WHERE key = 'self_hosted';

-- 1. App settings table for deployment mode
CREATE TABLE IF NOT EXISTS public.app_settings (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL
);

ALTER TABLE public.app_settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Authenticated can read app settings"
  ON public.app_settings FOR SELECT TO authenticated USING (true);

CREATE POLICY "Anon can read app settings"
  ON public.app_settings FOR SELECT TO anon USING (true);

-- Default: self-hosted mode (full access)
INSERT INTO public.app_settings (key, value) VALUES ('self_hosted', 'true');

GRANT SELECT ON TABLE public.app_settings TO anon;
GRANT SELECT ON TABLE public.app_settings TO authenticated;
GRANT ALL ON TABLE public.app_settings TO service_role;

-- 2. Modify has_active_subscription to check self-hosted flag
CREATE OR REPLACE FUNCTION public.has_active_subscription(user_id uuid)
RETURNS boolean
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  -- Self-hosted mode: everyone gets full access
  IF EXISTS (SELECT 1 FROM public.app_settings WHERE key = 'self_hosted' AND value = 'true') THEN
    RETURN true;
  END IF;
  -- Cloud mode: check RevenueCat subscription status
  RETURN EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = user_id
    AND subscription_status = 'active'
    AND (subscription_expires_at IS NULL OR subscription_expires_at > NOW())
  );
END;
$$;

-- 3. Remove duplicate storage policy that bypasses subscription check
DROP POLICY IF EXISTS "Users can read own blobs" ON storage.objects;

-- 4. Ensure sync-blobs bucket exists for self-hosters
INSERT INTO storage.buckets (id, name, public)
VALUES ('sync-blobs', 'sync-blobs', false)
ON CONFLICT DO NOTHING;
