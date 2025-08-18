import 'package:flutter/material.dart';
import 'package:habo/navigation/app_state_manager.dart';
import 'package:habo/navigation/routes.dart';
import 'package:habo/whats_new/whats_new.dart';
import 'package:provider/provider.dart';

class WhatsNewScreen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Routes.whatsNewPath,
      key: ValueKey(Routes.whatsNewPath),
      child: const WhatsNewScreen(),
    );
  }

  const WhatsNewScreen({super.key});

  @override
  State<WhatsNewScreen> createState() => _WhatsNewScreenState();
}

class _WhatsNewScreenState extends State<WhatsNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (
        context,
        appStateManager,
        child,
      ) {
        return const WhatsNew();
      },
    );
  }
}
