import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/templates/last_audit_template.dart';

class LastAuditPage extends StatelessWidget {
  const LastAuditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'ÚLTIMA AUDITORÍA DE SEGURIDAD',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(child: LastAuditTemplate()),
    );
  }
}
