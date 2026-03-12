import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/services/sync_manager.dart';
import 'package:habo/services/service_locator.dart';
import 'package:habo/settings/settings_manager.dart';
import 'package:provider/provider.dart';

/// Lightweight AppBar icon that reactively mirrors [SyncManager] status.
///
/// All state comes from [SyncManager.statusStream] — no duplicate auth or
/// subscription checks. Tapping always opens the Sync screen.
class SyncStatusIndicator extends StatefulWidget {
  const SyncStatusIndicator({super.key});

  @override
  State<SyncStatusIndicator> createState() => _SyncStatusIndicatorState();
}

class _SyncStatusIndicatorState extends State<SyncStatusIndicator> {
  StreamSubscription<SyncStatus>? _syncSubscription;
  SyncStatus _syncStatus = SyncStatus.idle;

  @override
  void initState() {
    super.initState();

    final syncManager = ServiceLocator.instance.syncManager;
    if (syncManager != null) {
      // Seed with current value so we don't wait for the first stream event.
      _syncStatus = syncManager.status;

      _syncSubscription = syncManager.statusStream.listen((status) {
        if (mounted) {
          setState(() => _syncStatus = status);
        }
      });
    }
  }

  @override
  void dispose() {
    _syncSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Consumer reacts to SettingsManager changes (isSyncPaused).
    return Consumer<SettingsManager>(
      builder: (context, settings, _) {
        return _buildForCurrentState(context, settings);
      },
    );
  }

  Widget _buildForCurrentState(BuildContext context, SettingsManager settings) {
    // Sync paused overrides everything except notConfigured / noSubscription
    if (settings.isSyncPaused &&
        _syncStatus != SyncStatus.notConfigured &&
        _syncStatus != SyncStatus.noSubscription) {
      return _buildIndicator(
        icon: Icons.pause_circle_outline,
        color: Colors.orange,
        tooltip: 'Syncing paused',
        onTap: () => _navigateToSync(context),
      );
    }

    // Currently syncing — show spinner, no tap action
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
        onPressed: () => _navigateToSync(context),
        tooltip: 'Syncing...',
      );
    }

    // All other states — icon derived from SyncStatus, tap opens sync screen
    final data = _getIndicatorData(_syncStatus);
    return _buildIndicator(
      icon: data.icon,
      color: data.color,
      tooltip: data.tooltip,
      onTap: () => _navigateToSync(context),
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
          tooltip: 'Sync error',
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
