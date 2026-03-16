import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_data_card.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_info_grid.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_execution_group.dart';
import 'package:n8n_monitor/api/workflows.dart';
import 'package:n8n_monitor/api/executions.dart';
import 'package:intl/intl.dart';

class WorkflowDetailsTemplate extends StatefulWidget {
  final String workflowId;
  final VoidCallback? onWorkflowStatusChanged;
  const WorkflowDetailsTemplate({
    super.key,
    required this.workflowId,
    this.onWorkflowStatusChanged,
  });

  @override
  State<WorkflowDetailsTemplate> createState() =>
      _WorkflowDetailsTemplateState();
}

class _WorkflowDetailsTemplateState extends State<WorkflowDetailsTemplate> {
  Map<String, dynamic>? _workflow;
  List<Map<String, dynamic>> _executions = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWorkflowData();
  }

  Future<void> _loadWorkflowData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Cargar workflow y ejecuciones en paralelo
      final results = await Future.wait([
        getWorkflowById(widget.workflowId),
        getExecutionsByWorkflowId(widget.workflowId),
      ]);

      if (!mounted) return;

      final workflowResponse = results[0];
      final executionsResponse = results[1];

      // Procesar respuesta del workflow
      if (workflowResponse['error'] != null) {
        if (!mounted) return;
        setState(() {
          _errorMessage = workflowResponse['error'];
          _isLoading = false;
        });
        return;
      } else if (workflowResponse['data'] == null) {
        if (!mounted) return;
        setState(() {
          _errorMessage = 'No se pudo cargar el workflow';
          _isLoading = false;
        });
        return;
      }

      final workflow = workflowResponse['data'];

      // Procesar respuesta de ejecuciones
      List<Map<String, dynamic>> formattedExecutions = [];
      if (executionsResponse['error'] == null &&
          executionsResponse['data'] != null) {
        final executionsData =
            executionsResponse['data']['data'] as List<dynamic>?;

        formattedExecutions =
            executionsData?.map((execution) {
              final exec = execution as Map<String, dynamic>;

              // Formatear la fecha
              String formattedTime = '';
              try {
                if (exec['startedAt'] != null) {
                  final date = DateTime.parse(exec['startedAt']);
                  formattedTime = DateFormat('HH:mm').format(date);
                }
              } catch (e) {
                formattedTime = 'N/A';
              }

              return {
                'id': exec['id'],
                'status': exec['status'] ?? 'unknown',
                'workflowName':
                    exec['workflowName'] ??
                    workflow['name'] ??
                    'Workflow ${exec['workflowId']}',
                'formattedTime': formattedTime,
                'startedAt': exec['startedAt'],
                'stoppedAt': exec['stoppedAt'],
                'finished': exec['finished'],
                'mode': exec['mode'],
                'workflowId': exec['workflowId'],
              };
            }).toList() ??
            [];
      } else {
        debugPrint(
          'Error al cargar ejecuciones: ${executionsResponse['error']}',
        );
      }

      if (!mounted) return;
      setState(() {
        _workflow = workflow;
        _executions = formattedExecutions;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Error inesperado al cargar el workflow';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CustomLoader(variant: LoaderVariant.light));
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadWorkflowData,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    final workflow = _workflow!;
    return RefreshIndicator(
      onRefresh: _loadWorkflowData,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          spacing: 20,
          children: [
            WorkflowDataCard(
              workflowDescription:
                  workflow['description']?.toString() ?? "Sin descripción",
              workflowStatus: workflow['active'] == true
                  ? "active"
                  : "desactived",
              workflowName: workflow['name'] ?? "Sin nombre",
              workflowId: workflow['id'] ?? "Sin ID",
              workflowTags:
                  (workflow['tags'] as List?)
                      ?.map((e) => e["name"].toString())
                      .toList() ??
                  [],
              onWorkflowStatusChanged: widget.onWorkflowStatusChanged,
            ),
            WorkflowInfoGrid(
              createdAt: workflow['createdAt'] ?? "Sin fecha de creación",
              updatedAt: workflow['updatedAt'] ?? "Sin fecha de actualización",
            ),
            SizedBox(height: 10.0),
            if (_executions.isNotEmpty)
              WorkflowExecutionGroup(workflowExecutions: _executions),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
