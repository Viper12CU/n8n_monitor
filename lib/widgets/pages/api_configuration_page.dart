import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/templates/api_conf_template.dart';

class ApiConfigurationPage extends StatelessWidget {
  const ApiConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.help_rounded, color:  Colors.white,),
            onPressed: () {
              // Acción al presionar el botón de información
            },
          ),
        ],
        centerTitle: true,
        title: const Text("Configuración inicial"),
      ),
      body: ApiConfTemplate()
    );
  }
}