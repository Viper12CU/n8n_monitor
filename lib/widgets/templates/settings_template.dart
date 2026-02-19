import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/molecules/audit_options_card.dart';
import 'package:n8n_monitor/widgets/molecules/connection_settings_form.dart';

class SettingsTemplate extends StatelessWidget {
  const SettingsTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20.0,
          children: [
            CustomGroupCategory(
              category: "Conexión",
              child: ConnectionSettingsForm(
                onSave: (url, apiKey) {
                  // Aquí puedes agregar lógica adicional cuando se guarden los datos
                  debugPrint('Datos guardados desde template:');
                  debugPrint('URL: $url');
                  debugPrint('API Key: $apiKey');
                },
              ),
            ),
            CustomGroupCategory(category: "Auditorías", child: AuditOptionsCard()),
          ],
        ),
      ),
    );
  }
}
