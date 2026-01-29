import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/pages/worfklow_details_page.dart';

class WorkflowCard extends StatefulWidget {
  final String id;
  final String workflowName;
  final bool initialStatus;
  final String lastUpdate;

  const WorkflowCard({
    super.key,
    required this.id,
    required this.workflowName,
    required this.initialStatus,
    required this.lastUpdate,
  });

  @override
  State<WorkflowCard> createState() => _WorkflowCardState();
}

class _WorkflowCardState extends State<WorkflowCard> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.initialStatus;
  }

  void handleToggle(bool value) async {
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
    //Navegar a detalles del workflow
    void navigateToDetails() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorfklowDetailsPage(workflowId: widget.id),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        border: Border.all(color: Color(0xFF27352d)),
        borderRadius: BorderRadius.circular(40.0),
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
                  Text(
                    widget.workflowName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              Switch(value: isActive, onChanged: handleToggle),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: Color(0xFF27352d)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Última actualización: ${widget.lastUpdate}',
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey[400],
                  size: 18,
                ),
                onPressed: () => navigateToDetails(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
