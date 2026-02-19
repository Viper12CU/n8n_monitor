import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_data_card.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_execution_group.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_info_grid.dart';

class WorkflowDetailsTemplate extends StatelessWidget {
  final String workflowId;
  const WorkflowDetailsTemplate({super.key, required this.workflowId});

  List<Map<String, dynamic>> get executions => [
    {
      "id": "310",
      "finished": false,
      "mode": "manual",
      "status": "error",
      "startedAt": "2026-01-13T16:03:51.417Z",
      "stoppedAt": "2026-01-13T16:03:51.562Z",
      "workflowId": "vIb0xyCcnFIuRfSS",
      "workflowName": "Email Newsletter",
    },
    {
      "id": "309",
      "finished": true,
      "mode": "manual",
      "status": "success",
      "startedAt": "2026-01-13T10:00:00.000Z",
      "stoppedAt": "2026-01-13T10:00:05.000Z",
      "workflowId": "abc123",
      "workflowName": "Data Sync",
    },
    {
      "id": "308",
      "finished": true,
      "mode": "trigger",
      "status": "running",
      "startedAt": "2026-01-13T09:30:00.000Z",
      "stoppedAt": null,
      "workflowId": "def456",
      "workflowName": "Backup Database",
    },
    {
      "id": "307",
      "finished": false,
      "mode": "manual",
      "status": "waiting",
      "startedAt": "2026-01-12T15:00:00.000Z",
      "stoppedAt": null,
      "workflowId": "ghi789",
      "workflowName": "Send Reports",
    },
    {
      "id": "306",
      "finished": true,
      "mode": "manual",
      "status": "canceled",
      "startedAt": "2026-01-12T10:00:00.000Z",
      "stoppedAt": "2026-01-12T10:00:02.000Z",
      "workflowId": "jkl012",
      "workflowName": "Process Orders",
    },
    {
      "id": "305",
      "finished": true,
      "mode": "trigger",
      "status": "success",
      "startedAt": "2026-01-10T08:45:00.000Z",
      "stoppedAt": "2026-01-10T08:45:10.000Z",
      "workflowId": "mno345",
      "workflowName": "Update Inventory",
    },
    {
      "id": "304",
      "finished": true,
      "mode": "manual",
      "status": "error",
      "startedAt": "2026-01-08T14:20:00.000Z",
      "stoppedAt": "2026-01-08T14:20:03.000Z",
      "workflowId": "pqr678",
      "workflowName": "Generate Report",
    },
    {
      "id": "303",
      "finished": true,
      "mode": "trigger",
      "status": "success",
      "startedAt": "2025-12-20T12:00:00.000Z",
      "stoppedAt": "2025-12-20T12:00:08.000Z",
      "workflowId": "stu901",
      "workflowName": "Archive Data",
    },
  ];


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
          WorkflowInfoGrid(),
          WorkflowExecutionGroup(workflowExecutions: executions),
          SizedBox(height: 20.0,)
        ],
      ),
    );
  }
}
