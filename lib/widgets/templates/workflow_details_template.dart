import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_data_card.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_info_grid.dart';

class WorkflowDetailsTemplate extends StatelessWidget {
  final String workflowId;
  const WorkflowDetailsTemplate({super.key, required this.workflowId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        spacing: 20,
        children: [
          WorkflowDataCard(
            workflowDescription: "Este es un flujo de trabajo de prueba para demostrar la plantilla de detalles del flujo de trabajo.",
            workflowStatus: "desactived",
            workflowName: "Manolo Rodriguesa",
            workflowId: workflowId,
            workflowTags: ["Hola", "2 etiquetas", "Pedro"],
          ),
          WorkflowInfoGrid()
        ],
      ),
    );
  }
}
