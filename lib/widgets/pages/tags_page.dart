import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/templates/tags_template.dart';

class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'GESTIÓN DE ETIQUETAS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: TagsTemplate(),
    );
  }
}