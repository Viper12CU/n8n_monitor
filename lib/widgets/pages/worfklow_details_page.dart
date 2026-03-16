import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/workflows.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/atoms/custom_speed_dial.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/templates/workflow_details_template.dart';

class WorfklowDetailsPage extends StatefulWidget {
  final String workflowId;
  const WorfklowDetailsPage({super.key, required this.workflowId});

  @override
  State<WorfklowDetailsPage> createState() => _WorfklowDetailsPageState();
}

class _WorfklowDetailsPageState extends State<WorfklowDetailsPage> {
  bool _isDeleting = false;
  bool _hasWorkflowChanges = false;

  Widget _buildDeletingState(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF27352d)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomLoader(variant: LoaderVariant.light),
                const SizedBox(height: 14),
                Text(
                  'Eliminando workflow...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Espera un momento mientras se completa la operación.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleDelete() async {
    if (_isDeleting) return;

    final result = await ConfirmationDialog.show(
      context,
      title: 'Confirmar eliminación',
      message:
          '¿Estás seguro de que deseas eliminar este workflow? Esta acción no se puede deshacer.',
    );

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      _isDeleting = true;
    });

    try {
      final deleteResponse = await deleteWorkflowById(widget.workflowId);

      if (!mounted) return;

      if (deleteResponse['error'] == null) {
        CustomSnackbar.show(
          context: context,
          message: 'Workflow eliminado correctamente',
          type: SnackbarType.success,
        );
        Navigator.pop(context, true);
        return;
      }

      CustomSnackbar.show(
        context: context,
        message: deleteResponse['error'].toString(),
        type: SnackbarType.error,
      );
    } catch (_) {
      if (!mounted) return;
      CustomSnackbar.show(
        context: context,
        message: 'Ocurrió un error inesperado al eliminar el workflow',
        type: SnackbarType.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, _hasWorkflowChanges);
          },
        ),
        title: Text(
          'DETALLES DEL WORKFLOW',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: _isDeleting
          ? _buildDeletingState(context)
          : SafeArea(
              child: WorkflowDetailsTemplate(
                workflowId: widget.workflowId,
                onWorkflowStatusChanged: () {
                  _hasWorkflowChanges = true;
                },
              ),
            ),
      floatingActionButton: _isDeleting
          ? null
          : CustomSpeedDial(
              secondaryIconsList: [Icons.delete_rounded],
              secondaryIconsText: ["eliminar"],
              secondaryIconsOnPress: [() => handleDelete()],
              secondaryBackgroundColor: Theme.of(context).colorScheme.primary,
              secondaryForegroundColor: Theme.of(
                context,
              ).scaffoldBackgroundColor,
              primaryBackgroundColor: Theme.of(context).colorScheme.primary,
              primaryForegroundColor: Theme.of(context).scaffoldBackgroundColor,
              secondaryLabelBackgroundColor: Theme.of(
                context,
              ).colorScheme.secondary,
              secondaryLabelTextColor: Theme.of(
                context,
              ).colorScheme.onSecondary,
              primaryElevation: 3.0,
              secondaryElevation: 3.0,
            ),
    );
  }
}
