import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/molecules/audit_options_card.dart';
import 'package:n8n_monitor/widgets/molecules/server_manage_options_card.dart';
import 'package:n8n_monitor/widgets/molecules/tags_options_card.dart';

class ToolsTemplate extends StatelessWidget {
  const ToolsTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20.0,
          children: [
            CustomGroupCategory(
              category: "Servidor",
              child: ServerManageOptionsCard(),
            ),
            CustomGroupCategory(
              category: "Auditorías",
              child: AuditOptionsCard(),
            ),
            CustomGroupCategory(
              category: "Etiquetas",
              child: TagsOptionsCard(),
            ),
          ],
        ),
      ),
    );
  }
}
