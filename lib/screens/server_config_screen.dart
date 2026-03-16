import 'package:flutter/material.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServerConfigScreen extends StatefulWidget {
  const ServerConfigScreen({super.key});

  @override
  State<ServerConfigScreen> createState() => _ServerConfigScreenState();
}

class _ServerConfigScreenState extends State<ServerConfigScreen> {
  final _urlController = TextEditingController();
  final _keyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isCustomServer = false;

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsManager>();
    _isCustomServer = settings.hasCustomServer;
    if (_isCustomServer) {
      _urlController.text = settings.customSupabaseUrl ?? '';
      _keyController.text = settings.customSupabaseAnonKey ?? '';
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) return 'URL is required';
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return 'Enter a valid URL (e.g., https://your-project.supabase.co)';
    }
    if (!value.startsWith('https://') && !value.startsWith('http://')) {
      return 'URL must start with https:// or http://';
    }
    return null;
  }

  String? _validateKey(String? value) {
    if (value == null || value.isEmpty) return 'Anon key is required';
    return null;
  }

  Future<void> _testAndSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final url = _urlController.text.trim();
    final key = _keyController.text.trim();

    try {
      // Test connectivity by querying app_settings on the target server
      final testClient = SupabaseClient(url, key);
      try {
        await testClient
            .from('app_settings')
            .select('value')
            .eq('key', 'self_hosted')
            .single();
      } finally {
        testClient.dispose();
      }

      if (!mounted) return;

      final settings = context.read<SettingsManager>();
      settings.setCustomSupabaseUrl(url);
      settings.setCustomSupabaseAnonKey(key);

      // Clear stale encryption key and sync state from previous server
      // so the master password setup flow runs fresh on restart.
      await ServiceLocator.instance.syncManager?.onSignOut();

      _showRestartDialog();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not connect to server. Verify the URL, anon key, and that the Habo migration has been applied.\n\nError: $e',
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _resetToDefault() async {
    final settings = context.read<SettingsManager>();

    if (!settings.hasCustomServer) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to Habo Cloud?'),
        content: const Text(
          'This will disconnect from your self-hosted server and switch back to the default Habo Cloud server. You will need to sign in again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    // Clear stale encryption key and sync state from previous server
    await ServiceLocator.instance.syncManager?.onSignOut();

    settings.setCustomSupabaseUrl(null);
    settings.setCustomSupabaseAnonKey(null);
    settings.setIsSelfHostedCached(false);

    _showRestartDialog();
  }

  void _showRestartDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Restart Required'),
        content: const Text(
          'Please close and reopen the app to connect to the new server.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Server Configuration')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isCustomServer
                    ? 'Connected to a custom server'
                    : 'Connected to Habo Cloud (default)',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Self-host your own Supabase backend for full sync access without a subscription. See the self-hosting guide for setup instructions.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Supabase URL',
                  hintText: 'https://your-project.supabase.co',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                validator: _validateUrl,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _keyController,
                decoration: const InputDecoration(
                  labelText: 'Anon Key',
                  hintText: 'your-anon-key',
                  border: OutlineInputBorder(),
                ),
                validator: _validateKey,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isLoading ? null : _testAndSave,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Test Connection & Save'),
                ),
              ),
              if (_isCustomServer) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _isLoading ? null : _resetToDefault,
                    child: const Text('Reset to Habo Cloud'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
