import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/templates/servers_manage_template.dart';

class ServersManagePage extends StatelessWidget {
  const ServersManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'GESTIONAR SERVIDOR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: const ServersManageTemplate(),
    );
  }
}
