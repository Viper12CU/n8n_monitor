import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_speed_dial.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/templates/workflow_details_template.dart';

class WorfklowDetailsPage extends StatelessWidget {
  final String workflowId;
  const WorfklowDetailsPage({super.key, required this.workflowId});

  @override
  Widget build(BuildContext context) {
    void handleDelete() async {
      final result = await ConfirmationDialog.show(
        context,
        title: 'Confirmar eliminación',
        message:
            '¿Estás seguro de que deseas eliminar este workflow? Esta acción no se puede deshacer.',
      );

      if (result != null) {
        debugPrint('Eliminar workflow con ID: $workflowId');
      }
      // Lógica para eliminar el workflow
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DETALLES DEL WORKFLOW',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: WorkflowDetailsTemplate(workflowId: workflowId),
      floatingActionButton: CustomSpeedDial(
        secondaryIconsList: [Icons.delete_rounded],
        secondaryIconsText: ["eliminar"],
        secondaryIconsOnPress: [() => handleDelete()],
        secondaryBackgroundColor: Theme.of(context).colorScheme.primary,
        secondaryForegroundColor: Theme.of(context).scaffoldBackgroundColor,
        primaryBackgroundColor: Theme.of(context).colorScheme.primary,
        primaryForegroundColor: Theme.of(context).scaffoldBackgroundColor,
        secondaryLabelBackgroundColor: Theme.of(context).colorScheme.secondary,
        secondaryLabelTextColor: Theme.of(context).colorScheme.onSecondary,
        primaryElevation: 3.0,
        secondaryElevation: 3.0,
      ),
    );
  }
}
