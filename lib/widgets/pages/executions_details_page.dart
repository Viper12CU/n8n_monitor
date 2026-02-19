import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_speed_dial.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/templates/executions_details_template.dart';

class ExecutionsDetailsPage extends StatelessWidget {
  final String executionId;
  const ExecutionsDetailsPage({super.key, required this.executionId});

  @override
  Widget build(BuildContext context) {
    void handleDelete() async {
      final result = await ConfirmationDialog.show(
        context,
        title: 'Confirmar eliminación',
        message:
            '¿Estás seguro de que deseas eliminar este registro de ejecución? Esta acción no se puede deshacer.',
      );

      if (result != null) {
        debugPrint('Eliminar ejecución con ID: $executionId');

        if( context.mounted ) {
          Navigator.pop(context);
        }
        
      }
      // Lógica para eliminar la ejecución
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'DETALLES DE LA EJECUCIÓN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(child: ExecutionsDetailsTemplate(executionId: executionId)),
      floatingActionButton: CustomSpeedDial(
        secondaryIconsList: [Icons.restart_alt_rounded, Icons.delete_rounded],
        secondaryIconsText: ["reintentar", "eliminar"],
        secondaryIconsOnPress: [() => {}, () => handleDelete()],
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
