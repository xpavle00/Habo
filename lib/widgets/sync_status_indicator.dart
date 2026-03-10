import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/services/sync_manager.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Widget that displays sync status in the AppBar.
/// Uses streams and providers for reactive state updates.
class SyncStatusIndicator extends StatefulWidget {
  const SyncStatusIndicator({super.key});

  @override
  State<SyncStatusIndicator> createState() => _SyncStatusIndicatorState();
}

class _SyncStatusIndicatorState extends State<SyncStatusIndicator>
    with WidgetsBindingObserver {
  StreamSubscription<AuthState>? _authSubscription;
  StreamSubscription<SyncStatus>? _syncSubscription;

  // Cached state values - updated reactively
  bool _isLoggedIn = false;
  bool _isSubscribed = false;
  SyncStatus _syncStatus = SyncStatus.idle;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initial state check
    _refreshAllState();

    // Listen to auth state changes
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (event) => _refreshAllState(),
    );

    // Listen to sync status changes
    final syncManager = ServiceLocator.instance.syncManager;
    if (syncManager != null) {
      _syncSubscription = syncManager.statusStream.listen((status) {
        if (mounted) {
          setState(() => _syncStatus = status);
        }
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authSubscription?.cancel();
    _syncSubscription?.cancel();
    super.dispose();
  }

  /// Refresh when app comes to foreground (user might have subscribed externally)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshAllState();
    }
  }

  /// Refresh all state - called on auth changes and app resume
  Future<void> _refreshAllState() async {
    final user = Supabase.instance.client.auth.currentUser;
    final isLoggedIn = user != null;

    bool isSubscribed = false;
    if (isLoggedIn) {
      try {
        isSubscribed = await ServiceLocator.instance.subscriptionService
            .isSubscribed();
      } catch (e) {
        debugPrint('SyncStatusIndicator: Failed to check subscription: $e');
      }
    }

    // Get current sync status
    final syncManager = ServiceLocator.instance.syncManager;
    final syncStatus = syncManager?.status ?? SyncStatus.notConfigured;

    if (mounted) {
      setState(() {
        _isLoggedIn = isLoggedIn;
        _isSubscribed = isSubscribed;
        _syncStatus = syncStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to react to SettingsManager changes (like isSyncPaused)
    return Consumer<SettingsManager>(
      builder: (context, settings, _) {
        return _buildForCurrentState(context, settings);
      },
    );
  }

  Widget _buildForCurrentState(BuildContext context, SettingsManager settings) {
    // Priority 1: Not logged in
    if (!_isLoggedIn) {
      return _buildIndicator(
        icon: Icons.cloud_outlined,
        color: Colors.grey,
        tooltip: 'Sign in to enable sync',
        onTap: () => _navigateToSync(context),
      );
    }

    // Priority 2: Logged in but not subscribed
    if (!_isSubscribed) {
      return _buildIndicator(
        icon: Icons.cloud_off,
        color: Colors.amber,
        tooltip: 'Subscribe to enable sync',
        onTap: () => _navigateToSync(context),
      );
    }

    // Priority 3: Sync paused by user
    if (settings.isSyncPaused) {
      return _buildIndicator(
        icon: Icons.pause_circle_outline,
        color: Colors.orange,
        tooltip: 'Syncing paused',
        onTap: () => _navigateToSync(context),
      );
    }

    // Priority 4: Currently syncing
    if (_syncStatus == SyncStatus.syncing) {
      return IconButton(
        icon: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
          ),
        ),
        onPressed: null,
        tooltip: 'Syncing...',
      );
    }

    // Priority 5: Other sync states
    final indicatorData = _getIndicatorData(_syncStatus);
    return _buildIndicator(
      icon: indicatorData.icon,
      color: indicatorData.color,
      tooltip: indicatorData.tooltip,
      onTap: () => _handleTap(context),
    );
  }

  Widget _buildIndicator({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onTap,
      tooltip: tooltip,
    );
  }

  _IndicatorData _getIndicatorData(SyncStatus status) {
    final syncManager = ServiceLocator.instance.syncManager;
    final lastSync = syncManager?.lastSyncTime;

    switch (status) {
      case SyncStatus.synced:
        String tooltip = 'Synced';
        if (lastSync != null) {
          final diff = DateTime.now().difference(lastSync);
          if (diff.inMinutes < 1) {
            tooltip = 'Synced just now';
          } else if (diff.inMinutes < 60) {
            tooltip = 'Synced ${diff.inMinutes}m ago';
          } else if (diff.inHours < 24) {
            tooltip = 'Synced ${diff.inHours}h ago';
          } else {
            tooltip = 'Synced ${diff.inDays}d ago';
          }
        }
        return _IndicatorData(
          icon: Icons.cloud_done,
          color: Colors.green,
          tooltip: tooltip,
        );

      case SyncStatus.error:
        return _IndicatorData(
          icon: Icons.sync_problem,
          color: Colors.red,
          tooltip: 'Sync error - tap to retry',
        );

      case SyncStatus.offline:
        return _IndicatorData(
          icon: Icons.cloud_off,
          color: Colors.grey,
          tooltip: 'Offline',
        );

      case SyncStatus.notConfigured:
        return _IndicatorData(
          icon: Icons.cloud_outlined,
          color: Colors.grey,
          tooltip: 'Set up sync',
        );

      case SyncStatus.noSubscription:
        return _IndicatorData(
          icon: Icons.cloud_off,
          color: Colors.amber,
          tooltip: 'Subscribe to enable sync',
        );

      case SyncStatus.idle:
      case SyncStatus.syncing:
        return _IndicatorData(
          icon: Icons.cloud_queue,
          color: Colors.lightBlueAccent,
          tooltip: 'Tap to sync',
        );
    }
  }

  void _navigateToSync(BuildContext context) {
    Provider.of<AppStateManager>(context, listen: false).goSync(true);
    // Refresh state when returning from sync screen
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _refreshAllState();
    });
  }

  void _handleTap(BuildContext context) {
    if (_syncStatus == SyncStatus.notConfigured) {
      _navigateToSync(context);
      return;
    }

    if (_syncStatus == SyncStatus.syncing) {
      return;
    }

    // Trigger manual sync
    final syncManager = ServiceLocator.instance.syncManager;
    syncManager?.syncNow();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Syncing...'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

class _IndicatorData {
  final IconData icon;
  final Color color;
  final String tooltip;

  _IndicatorData({
    required this.icon,
    required this.color,
    required this.tooltip,
  });
}
