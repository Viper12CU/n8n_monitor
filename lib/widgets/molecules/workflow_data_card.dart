import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';

class WorkflowDataCard extends StatefulWidget {
  final String workflowStatus;
  final String workflowName;
  final String workflowId;
  final String? workflowDescription;
  final List<String>? workflowTags;
  const WorkflowDataCard({
    super.key,
    required this.workflowStatus,
    required this.workflowName,
    required this.workflowId,
    this.workflowTags,
    this.workflowDescription,
  });

  @override
  State<WorkflowDataCard> createState() => _WorkflowDataCardState();
}

class _WorkflowDataCardState extends State<WorkflowDataCard> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.workflowStatus.toLowerCase() == "active";
  }

  void handleSwitch(bool value) async {
    if (value == true) {
      // Mostrar dialog de confirmación cuando se activa
      final result = await ConfirmationDialog.show(
        context,
        title: 'Activar Workflow',
        message: '¿Estás seguro de que deseas activar este workflow?',
        showNameField: true,
        showDescriptionField: true,
        showVersionIdField: true,
      );

      // Solo cambiar el estado si el usuario confirmó
      if (result != null) {
        debugPrint('Datos recibidos: $result');
        setState(() {
          isActive = value;
        });
      }
    } else {
      // Desactivar sin confirmación

      final result = await ConfirmationDialog.show(
        context,
        title: 'Desactivar Workflow',
        message: '¿Estás seguro de que deseas desactivar este workflow?',
      );
      if (result != null) {
        debugPrint('Datos recibidos: $result');
        setState(() {
          isActive = value;
        });
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
        Switch(value: isActive, onChanged: (value) => handleSwitch(value)),
      ],
    );
  }
}
