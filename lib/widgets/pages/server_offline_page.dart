import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/templates/server_offline_template.dart';

class ServerOfflinePage extends StatelessWidget {
  const ServerOfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ServerOfflineTemplate()
    );
  }
}