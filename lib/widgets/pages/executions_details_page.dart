import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_speed_dial.dart';
import 'package:n8n_monitor/widgets/templates/executions_details_template.dart';

class ExecutionsDetailsPage extends StatelessWidget {
  final String workflowId;
  const ExecutionsDetailsPage({super.key, required this.workflowId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DETALLES DE LA EJECUCIÓN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: ExecutionsDetailsTemplate(workflowId: workflowId),
      floatingActionButton: floatingActionButton(context),
    );
  }

  CustomSpeedDial floatingActionButton(BuildContext context) {
    return CustomSpeedDial(
      secondaryIconsList: [
        Icons.restart_alt_rounded,
        Icons.delete_rounded,
      ],
      secondaryIconsText: ["reintentar", "eliminar"],
      secondaryIconsOnPress: [() => {}, () => {}],
      secondaryBackgroundColor: Theme.of(context).colorScheme.primary,
      secondaryForegroundColor: Theme.of(context).scaffoldBackgroundColor,
      primaryBackgroundColor: Theme.of(context).colorScheme.primary,
      primaryForegroundColor: Theme.of(context).scaffoldBackgroundColor,
      secondaryLabelBackgroundColor: Theme.of(context).colorScheme.secondary,
      secondaryLabelTextColor: Theme.of(context).colorScheme.onSecondary,
      primaryElevation: 3.0,
      secondaryElevation: 3.0,
    );
  }
}
