import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/workflows.dart';
import 'package:n8n_monitor/widgets/atoms/custom_switch.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';

class WorkflowDataCard extends StatefulWidget {
  final String workflowStatus;
  final String workflowName;
  final String workflowId;
  final String? workflowDescription;
  final List<String>? workflowTags;
  final VoidCallback? onWorkflowStatusChanged;
  const WorkflowDataCard({
    super.key,
    required this.workflowStatus,
    required this.workflowName,
    required this.workflowId,
    this.workflowTags,
    this.workflowDescription,
    this.onWorkflowStatusChanged,
  });

  @override
  State<WorkflowDataCard> createState() => _WorkflowDataCardState();
}

class _WorkflowDataCardState extends State<WorkflowDataCard> {
  late bool isActive;
  late ValueNotifier<bool> _switchController;
  bool _isUpdatingStatus = false;

  @override
  void initState() {
    super.initState();
    isActive = widget.workflowStatus.toLowerCase() == "active";
    _switchController = ValueNotifier<bool>(isActive);
  }

  @override
  void didUpdateWidget(covariant WorkflowDataCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.workflowStatus != widget.workflowStatus) {
      isActive = widget.workflowStatus.toLowerCase() == "active";
      _switchController.value = isActive;
    }
  }

  @override
  void dispose() {
    _switchController.dispose();
    super.dispose();
  }

  void handleSwitch(bool value) async {
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
        initialDescription: widget.workflowDescription,
      );

      // Solo cambiar el estado si el usuario confirmó
      if (result != null) {
        setState(() {
          _isUpdatingStatus = true;
        });

        final fields = result['field_data'] as Map<String, dynamic>? ?? {};
        final response = await activateWorkflow(
          widget.workflowId,
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
          widget.onWorkflowStatusChanged?.call();
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

        final response = await deactivateWorkflow(widget.workflowId);

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
          widget.onWorkflowStatusChanged?.call();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),

      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF27352d)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [statusRow(), nameColumn(), description(), tags()],
      ),
    );
  }

  Widget tags() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (widget.workflowTags != null && widget.workflowTags!.isNotEmpty)
            ...widget.workflowTags!.map((tag) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // TODO: Implementar lógica al hacer tap en tag
                    print("Tap en tag: $tag");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF1e2724),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0x4DFFFFFF),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: Color(0xCCFFFFFF),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })
          else
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF1e2724),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0x4DFFFFFF),
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Sin etiquetas",
                    style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
                  ),
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              // TODO: Implementar lógica para agregar nueva tag
              print("Agregar nueva tag");
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFF1e2724),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 18, color: Color(0xCCFFFFFF)),
                  SizedBox(width: 4),
                  Text(
                    "Agregar",
                    style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text description() {
    return Text(
      widget.workflowDescription ?? "Sin descripción",
      style: TextStyle(fontSize: 14, color: Color(0x99FFFFFF)),
    );
  }

  Column nameColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.workflowName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.clip,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Color(0xFF27352d)),
          ),
          child: Text(
            "ID: ${widget.workflowId}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              wordSpacing: 1.5,
              color: Color(0x99FFFFFF),
            ),
          ),
        ),
      ],
    );
  }

  Row statusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ESTADO DEL WORKFLOW",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                wordSpacing: 1.5,
                color: Color(0x99FFFFFF),
              ),
            ),
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
            ? const SizedBox(
                width: 38,
                height: 38,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomLoader(variant: LoaderVariant.light),
                ),
              )
            : CustomSwitch(
              initialValue: isActive,
                controller: _switchController,
                onChanged: handleSwitch,
              ),
      ],
    );
  }
}
