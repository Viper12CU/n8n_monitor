import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n8n_monitor/api/workflows.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/atoms/custom_switch.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/pages/worfklow_details_page.dart';

class WorkflowCard extends StatefulWidget {
  final String id;
  final String workflowName;
  final bool initialStatus;
  final String lastUpdate;
  final VoidCallback? onWorkflowDeleted;

  const WorkflowCard({
    super.key,
    required this.id,
    required this.workflowName,
    required this.initialStatus,
    required this.lastUpdate,
    this.onWorkflowDeleted,
  });

  @override
  State<WorkflowCard> createState() => _WorkflowCardState();
}

class _WorkflowCardState extends State<WorkflowCard> {
  late bool isActive;
  late ValueNotifier<bool> _switchController;
  bool _isUpdatingStatus = false;

  @override
  void initState() {
    super.initState();
    isActive = widget.initialStatus;
    _switchController = ValueNotifier<bool>(widget.initialStatus);
  }

  @override
  void didUpdateWidget(WorkflowCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Actualizar el estado cuando cambia initialStatus desde el parent
    if (oldWidget.initialStatus != widget.initialStatus) {
      isActive = widget.initialStatus;
      _switchController.value = widget.initialStatus;
    }
  }

  @override
  void dispose() {
    _switchController.dispose();
    super.dispose();
  }

  void handleToggle(bool value) async {
    if (_isUpdatingStatus) return;

    final previousValue = isActive;

    if (value == true) {
      // Mostrar dialog de confirmación cuando se activa
      final result = await ConfirmationDialog.show(
        context,
        title: 'Activar Workflow',
        message: '¿Estás seguro de que deseas activar este workflow?',
        showNameField: true,
        showDescriptionField: true,
        showVersionIdField: true,
        initialName: widget.workflowName,
      );

      // Solo cambiar el estado si el usuario confirmó
      if (result != null) {
        setState(() {
          _isUpdatingStatus = true;
        });

        final fields = result['field_data'] as Map<String, dynamic>? ?? {};
        final response = await activateWorkflow(
          widget.id,
          name: fields['name'] as String?,
          description: fields['description'] as String?,
          versionId: fields['versionId'] as String?,
        );

        if (!mounted) return;

        if (response['error'] == null) {
          CustomSnackbar.show(
            context: context,
            message: 'Workflow activado correctamente',
            type: SnackbarType.success,
          );

          setState(() {
            isActive = true;
          });
          _switchController.value = true;
        } else {
          CustomSnackbar.show(
            context: context,
            message: response['error'].toString(),
            type: SnackbarType.error,
          );
          _switchController.value = previousValue;
        }

        setState(() {
          _isUpdatingStatus = false;
        });
      } else {
        _switchController.value = previousValue;
      }
    } else {
      // Desactivar sin confirmación
      final result = await ConfirmationDialog.show(
        context,
        title: 'Desactivar Workflow',
        message: '¿Estás seguro de que deseas desactivar este workflow?',
      );
      if (result != null) {
        setState(() {
          _isUpdatingStatus = true;
        });

        final response = await deactivateWorkflow(widget.id);

        if (!mounted) return;

        if (response['error'] == null) {
          CustomSnackbar.show(
            context: context,
            message: 'Workflow desactivado correctamente',
            type: SnackbarType.success,
          );

          setState(() {
            isActive = false;
          });
          _switchController.value = false;
        } else {
          CustomSnackbar.show(
            context: context,
            message: response['error'].toString(),
            type: SnackbarType.error,
          );
          _switchController.value = previousValue;
        }

        setState(() {
          _isUpdatingStatus = false;
        });
      } else {
        _switchController.value = previousValue;
      }
    }
  }

  String formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      final formatter = DateFormat('dd-MM-yyyy HH:mm');
      return formatter.format(dateTime);
    } catch (e) {
      return isoDate; // Retorna la fecha original si hay error
    }
  }

  @override
  Widget build(BuildContext context) {
    //Navegar a detalles del workflow
    Future<void> navigateToDetails() async {
      final wasDeleted = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => WorfklowDetailsPage(workflowId: widget.id),
        ),
      );

      if (wasDeleted == true) {
        widget.onWorkflowDeleted?.call();
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      overflow: TextOverflow.clip,
                      widget.workflowName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? Colors.green : Colors.grey[400],
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        isActive ? 'Activo' : 'Inactivo',
                        style: TextStyle(
                          color: isActive ? Colors.green : Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _isUpdatingStatus
                  ? SizedBox(
                      width: 32,
                      height: 32,
                      child: CustomLoader(variant: LoaderVariant.light),
                    )
                  : CustomSwitch(
                      initialValue: isActive,
                      controller: _switchController,
                      enabled: !_isUpdatingStatus,
                      onChanged: handleToggle,
                    ),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: Color(0xFF27352d)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Última actualización: ${formatDate(widget.lastUpdate)}',
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[400],
                  size: 18,
                ),
                onPressed: navigateToDetails,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
