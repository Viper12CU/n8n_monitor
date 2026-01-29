import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/workflow_card.dart';
import 'package:n8n_monitor/widgets/molecules/workflows_filter.dart';

class WorkflowsListTemplate extends StatelessWidget {
  const WorkflowsListTemplate({super.key});

  // Lista estática de 10 workflows
  static final List<Map<String, dynamic>> _workflows = [
    {
      'id': 'wf001',
      'workflowName': 'Procesamiento de Órdenes',
      'initialStatus': true,
      'lastUpdate': 'Hace 10 minutos',
    },
    {
      'id': 'wf002',
      'workflowName': 'Sincronización CRM',
      'initialStatus': true,
      'lastUpdate': 'Hace 1 hora',
    },
    {
      'id': 'wf003',
      'workflowName': 'Notificaciones Email',
      'initialStatus': false,
      'lastUpdate': 'Hace 2 días',
    },
    {
      'id': 'wf004',
      'workflowName': 'Backup Automático',
      'initialStatus': true,
      'lastUpdate': 'Hace 30 minutos',
    },
    {
      'id': 'wf005',
      'workflowName': 'Generación de Reportes',
      'initialStatus': true,
      'lastUpdate': 'Hace 3 horas',
    },
    {
      'id': 'wf006',
      'workflowName': 'Monitor de Inventario',
      'initialStatus': false,
      'lastUpdate': 'Hace 1 semana',
    },
    {
      'id': 'wf007',
      'workflowName': 'Integración Slack',
      'initialStatus': true,
      'lastUpdate': 'Hace 5 minutos',
    },
    {
      'id': 'wf008',
      'workflowName': 'API Gateway Principal',
      'initialStatus': true,
      'lastUpdate': 'Hace 15 minutos',
    },
    {
      'id': 'wf009',
      'workflowName': 'Análisis de Datos',
      'initialStatus': true,
      'lastUpdate': 'Hace 45 minutos',
    },
    {
      'id': 'wf010',
      'workflowName': 'Limpieza de Logs',
      'initialStatus': false,
      'lastUpdate': 'Hace 3 días',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WorkflowsFilter(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _workflows.length,
            itemBuilder: (context, index) {
              final workflow = _workflows[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: WorkflowCard(
                  id: workflow['id'],
                  workflowName: workflow['workflowName'],
                  initialStatus: workflow['initialStatus'],
                  lastUpdate: workflow['lastUpdate'],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}