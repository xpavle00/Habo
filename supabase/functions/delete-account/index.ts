// Supabase Edge Function to handle account deletion.
// Deploy: supabase functions deploy delete-account
//
// This function:
// 1. Verifies the user's JWT
// 2. Deletes all files in sync-blobs/{user_id}/
// 3. Deletes the auth user (cascades to profiles + backups via FK)
//
// Required env vars (auto-available in Supabase Functions):
//   SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type"
};
serve(async (req)=>{
  // Handle CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders
    });
  }
  // Only allow POST
  if (req.method !== "POST") {
    return new Response(JSON.stringify({
      error: "Method not allowed"
    }), {
      status: 405,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json"
      }
    });
  }
  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY");
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
    // ==========================================================================
    // 1. Authenticate: verify the user's JWT
    // ==========================================================================
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(JSON.stringify({
        error: "Missing Authorization header"
      }), {
        status: 401,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json"
        }
      });
    }
    // Create a client with the user's JWT to verify identity
    const userClient = createClient(supabaseUrl, supabaseAnonKey, {
      global: {
        headers: {
          Authorization: authHeader
        }
      }
    });
    const { data: { user }, error: authError } = await userClient.auth.getUser();
    if (authError || !user) {
      console.error("Auth error:", authError?.message);
      return new Response(JSON.stringify({
        error: "Invalid or expired token"
      }), {
        status: 401,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json"
        }
      });
    }
    const userId = user.id;
    console.log(`Delete account requested for user: ${userId}`);
    // ==========================================================================
    // 2. Delete all storage files in sync-blobs/{user_id}/
    // ==========================================================================
    const adminClient = createClient(supabaseUrl, supabaseServiceKey);
    // List all files in the user's folder (sync blob + backup blobs)
    const { data: files, error: listError } = await adminClient.storage.from("sync-blobs").list(userId, {
      limit: 1000
    });
    if (listError) {
      console.error("Error listing storage files:", listError.message);
    // Continue anyway — DB deletion is more important
    } else if (files && files.length > 0) {
      const filePaths = files.map((f)=>`${userId}/${f.name}`);
      console.log(`Deleting ${filePaths.length} storage files...`);
      const { error: deleteFilesError } = await adminClient.storage.from("sync-blobs").remove(filePaths);
      if (deleteFilesError) {
        console.error("Error deleting storage files:", deleteFilesError.message);
      // Continue — we still want to delete the user
      }
    }
    // Also check for files in subdirectories (e.g. backups/)
    const { data: backupFiles } = await adminClient.storage.from("sync-blobs").list(`${userId}/backups`, {
      limit: 1000
    });
    if (backupFiles && backupFiles.length > 0) {
      const backupPaths = backupFiles.map((f)=>`${userId}/backups/${f.name}`);
      console.log(`Deleting ${backupPaths.length} backup files...`);
      await adminClient.storage.from("sync-blobs").remove(backupPaths);
    }
    // ==========================================================================
    // 3. Delete auth user (cascades to profiles + backups via FK ON DELETE CASCADE)
    // ==========================================================================
    const { error: deleteUserError } = await adminClient.auth.admin.deleteUser(userId);
    if (deleteUserError) {
      console.error("Error deleting auth user:", deleteUserError.message);
      return new Response(JSON.stringify({
        error: "Failed to delete account. Please try again or contact support."
      }), {
        status: 500,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json"
        }
      });
    }
    console.log(`Successfully deleted account for user: ${userId}`);
    return new Response(JSON.stringify({
      success: true
    }), {
      status: 200,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json"
      }
    });
  } catch (err) {
    const error = err;
    console.error("Delete account error:", error);
    return new Response(JSON.stringify({
      error: error.message
    }), {
      status: 500,
      headers: {
        ...corsHeaders,
        "Content-Type": "application/json"
      }
    });
  }
});
