


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."enforce_backup_limit"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = ''
    AS $$
BEGIN
  -- Delete oldest backups if user has more than 5
  DELETE FROM public.backups 
  WHERE id IN (
    SELECT id FROM public.backups 
    WHERE user_id = NEW.user_id 
    ORDER BY created_at DESC 
    OFFSET 5
  );
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."enforce_backup_limit"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_server_time"() RETURNS timestamp with time zone
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET search_path = ''
    AS $$ SELECT now(); $$;


ALTER FUNCTION "public"."get_server_time"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."has_active_subscription"("user_id" "uuid") RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = ''
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE id = user_id 
    AND subscription_status = 'active'
    AND (
      subscription_expires_at IS NULL 
      OR subscription_expires_at > NOW()
    )
  );
END;
$$;


ALTER FUNCTION "public"."has_active_subscription"("user_id" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."push_sync_version"("expected_version" integer, "new_blob_path" "text") RETURNS integer
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET search_path = ''
    AS $$
DECLARE
  new_version INT;
BEGIN
  UPDATE public.profiles
  SET
    sync_version = sync_version + 1,
    sync_blob_path = new_blob_path,
    last_synced_at = now()
  WHERE id = auth.uid()
    AND sync_version = expected_version
  RETURNING sync_version INTO new_version;

  IF new_version IS NULL THEN
    RAISE EXCEPTION 'SYNC_VERSION_CONFLICT'
      USING ERRCODE = 'P0002';
  END IF;

  RETURN new_version;
END;
$$;


ALTER FUNCTION "public"."push_sync_version"("expected_version" integer, "new_blob_path" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."protect_profile_fields"() RETURNS "trigger"
LANGUAGE "plpgsql" SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  -- We only restrict the authenticated end users (the mobile app).
  -- Service roles (e.g. RevenueCat webhook) bypass this via auth.uid() IS NULL.
  IF auth.uid() IS NOT NULL THEN
    -- Prevent user from updating subscription fields directly
    NEW.subscription_status = OLD.subscription_status;
    NEW.subscription_expires_at = OLD.subscription_expires_at;
    NEW.revenuecat_app_user_id = OLD.revenuecat_app_user_id;

    -- Prevent user from updating sync fields if they don't have an active subscription
    IF (NEW.sync_version IS DISTINCT FROM OLD.sync_version OR
        NEW.sync_blob_path IS DISTINCT FROM OLD.sync_blob_path OR
        NEW.last_synced_at IS DISTINCT FROM OLD.last_synced_at) THEN

      IF NOT public.has_active_subscription(NEW.id) THEN
        NEW.sync_version = OLD.sync_version;
        NEW.sync_blob_path = OLD.sync_blob_path;
        NEW.last_synced_at = OLD.last_synced_at;
      END IF;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."protect_profile_fields"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."backups" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "blob_path" "text" NOT NULL,
    "habits_count" integer
);


ALTER TABLE "public"."backups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "updated_at" timestamp with time zone,
    "encryption_salt" "text",
    "verifier_token" "text",
    "encrypted_vault_key" "text",
    "sync_version" integer DEFAULT 0,
    "sync_blob_path" "text",
    "last_synced_at" timestamp with time zone,
    "revenuecat_app_user_id" "text",
    "subscription_expires_at" timestamp with time zone,
    "subscription_status" "text" DEFAULT 'none'::"text",
    CONSTRAINT "username_length" CHECK (("char_length"("encryption_salt") >= 3))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


ALTER TABLE ONLY "public"."backups"
    ADD CONSTRAINT "backups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_backups_user_id" ON "public"."backups" USING "btree" ("user_id");



CREATE INDEX "idx_profiles_subscription_status" ON "public"."profiles" USING "btree" ("subscription_status");



CREATE OR REPLACE TRIGGER "backup_limit_trigger" AFTER INSERT ON "public"."backups" FOR EACH ROW EXECUTE FUNCTION "public"."enforce_backup_limit"();



ALTER TABLE ONLY "public"."backups"
    ADD CONSTRAINT "backups_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Subscribers can create backups" ON "public"."backups" FOR INSERT WITH CHECK ((((select "auth"."uid"()) = "user_id") AND "public"."has_active_subscription"((select "auth"."uid"()))));



CREATE POLICY "Subscribers can update backups" ON "public"."backups" FOR UPDATE USING (((select "auth"."uid"()) = "user_id")) WITH CHECK ((((select "auth"."uid"()) = "user_id") AND "public"."has_active_subscription"((select "auth"."uid"()))));



CREATE POLICY "Users can delete own backups" ON "public"."backups" FOR DELETE USING (((select "auth"."uid"()) = "user_id"));



CREATE POLICY "Users can insert own profile" ON "public"."profiles" FOR INSERT WITH CHECK (((select "auth"."uid"()) = "id"));



CREATE POLICY "Users can read own backups" ON "public"."backups" FOR SELECT USING (((select "auth"."uid"()) = "user_id"));



CREATE POLICY "Users can update own profile"
  ON "public"."profiles"
  FOR UPDATE
  USING ((select "auth"."uid"()) = "id");



CREATE POLICY "Users can view own profile" ON "public"."profiles" FOR SELECT USING (((select "auth"."uid"()) = "id"));



ALTER TABLE "public"."backups" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


CREATE TRIGGER "on_profile_update"
BEFORE UPDATE ON "public"."profiles"
FOR EACH ROW
EXECUTE FUNCTION "public"."protect_profile_fields"();


ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."profiles";



GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































-- enforce_backup_limit is a trigger function — only service_role needs execute
GRANT ALL ON FUNCTION "public"."enforce_backup_limit"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_server_time"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_server_time"() TO "service_role";



GRANT ALL ON FUNCTION "public"."has_active_subscription"("user_id" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."has_active_subscription"("user_id" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."push_sync_version"("expected_version" integer, "new_blob_path" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."push_sync_version"("expected_version" integer, "new_blob_path" "text") TO "service_role";


















GRANT ALL ON TABLE "public"."backups" TO "authenticated";
GRANT ALL ON TABLE "public"."backups" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































drop extension if exists "pg_net";


  create policy "Subscribers can download sync blobs"
  on "storage"."objects"
  as permissive
  for select
  to public
using (((bucket_id = 'sync-blobs'::text) AND (((select auth.uid()))::text = (storage.foldername(name))[1]) AND public.has_active_subscription((select auth.uid()))));



  create policy "Subscribers can update sync blobs"
  on "storage"."objects"
  as permissive
  for update
  to public
using (((bucket_id = 'sync-blobs'::text) AND (((select auth.uid()))::text = (storage.foldername(name))[1]) AND public.has_active_subscription((select auth.uid()))));



  create policy "Subscribers can upload sync blobs"
  on "storage"."objects"
  as permissive
  for insert
  to public
with check (((bucket_id = 'sync-blobs'::text) AND (((select auth.uid()))::text = (storage.foldername(name))[1]) AND public.has_active_subscription((select auth.uid()))));



  create policy "Users can delete own sync blobs"
  on "storage"."objects"
  as permissive
  for delete
  to public
using (((bucket_id = 'sync-blobs'::text) AND (((select auth.uid()))::text = (storage.foldername(name))[1])));



  create policy "Users can read own blobs"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using (((bucket_id = 'sync-blobs'::text) AND ((storage.foldername(name))[1] = ((select auth.uid()))::text)));




