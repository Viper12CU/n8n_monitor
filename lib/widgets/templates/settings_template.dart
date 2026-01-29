import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/molecules/connection_settings_form.dart';

class SettingsTemplate extends StatelessWidget {
  const SettingsTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomGroupCategory(
          category: "Conexión",
          child: ConnectionSettingsForm(
            onSave: (url, apiKey) {
              // Aquí puedes agregar lógica adicional cuando se guarden los datos
              print('Datos guardados desde template:');
              print('URL: $url');
              print('API Key: $apiKey');
            },
          ),
        ),
      ],
    );
  }
}
