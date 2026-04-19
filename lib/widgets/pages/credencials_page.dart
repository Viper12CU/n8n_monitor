import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/templates/credencial_create_template.dart';
import 'package:n8n_monitor/widgets/templates/credencials_list_template.dart';

enum CredencialsPageType { create, list }

class CredencialsPage extends StatelessWidget {
  final CredencialsPageType type;

  const CredencialsPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          type == CredencialsPageType.create
              ? 'CREAR NUEVA CREDENCIAL'
              : 'CREDENCIALES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: type == CredencialsPageType.list
          ? const CredencialsListTemplate()
          : const CredencialCreateTemplate(),
    );
  }
}
