import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/executions.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_speed_dial.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/templates/executions_details_template.dart';

class ExecutionsDetailsPage extends StatefulWidget {
  final String executionId;
  const ExecutionsDetailsPage({super.key, required this.executionId});

  @override
  State<ExecutionsDetailsPage> createState() => _ExecutionsDetailsPageState();
}

class _ExecutionsDetailsPageState extends State<ExecutionsDetailsPage> {
  bool _isLoading = false;

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    CustomSnackbar.show(
      context: context,
      message: message,
      type: isError ? SnackbarType.error : SnackbarType.success,
    );
  }

  void _handleDelete() async {
    final result = await ConfirmationDialog.show(
      context,
      title: 'Confirmar eliminación',
      message:
          '¿Estás seguro de que deseas eliminar este registro de ejecución? Esta acción no se puede deshacer.',
    );

    if (result != null && mounted) {
      setState(() => _isLoading = true);
      
      final response = await deleteExecutionById(widget.executionId);
      
      setState(() => _isLoading = false);

      if (response['error'] == null) {
        _showSnackBar('Ejecución eliminada correctamente');
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        _showSnackBar(response['error'], isError: true);
      }
    }
  }

  void _handleRetry() async {
    setState(() => _isLoading = true);
    
    final response = await retryExecutionById(widget.executionId);
    
    setState(() => _isLoading = false);

    if (response['error'] == null) {
      _showSnackBar('Ejecución reiniciada correctamente');
    } else {
      _showSnackBar(response['error'], isError: true);
    }
  }

  void _handleStop() async {
    final result = await ConfirmationDialog.show(
      context,
      title: 'Confirmar detención',
      message: '¿Deseas detener esta ejecución?',
    );

    if (result != null && mounted) {
      setState(() => _isLoading = true);
      
      final response = await stopExecutionById(widget.executionId);
      
      setState(() => _isLoading = false);

      if (response['error'] == null) {
        _showSnackBar('Ejecución detenida correctamente');
      } else {
        _showSnackBar(response['error'], isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          SafeArea(child: ExecutionsDetailsTemplate(executionId: widget.executionId)),
          if (_isLoading)
            Container(
              color: const Color(0x4D000000),
              child: const Center(
                child: CustomLoader(variant: LoaderVariant.light),
              ),
            ),
        ],
      ),
      floatingActionButton: CustomSpeedDial(
        secondaryIconsList: [Icons.restart_alt_rounded, Icons.delete_rounded, Icons.pause_rounded],
        secondaryIconsText: ["reintentar", "eliminar", "detener"],
        secondaryIconsOnPress: [
          _isLoading ? () {} : _handleRetry,
          _isLoading ? () {} : _handleDelete,
          _isLoading ? () {} : _handleStop,
        ],
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
