import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_data_card.dart';
import 'package:n8n_monitor/widgets/molecules/workflow_info_grid.dart';
import 'package:n8n_monitor/api/workflows.dart';

class WorkflowDetailsTemplate extends StatefulWidget {
  final String workflowId;
  const WorkflowDetailsTemplate({super.key, required this.workflowId});

  @override
  State<WorkflowDetailsTemplate> createState() =>
      _WorkflowDetailsTemplateState();
}

class _WorkflowDetailsTemplateState extends State<WorkflowDetailsTemplate> {
  Map<String, dynamic>? _workflow;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWorkflow();
  }

  Future<void> _loadWorkflow() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final workflow = await getWorkflowById(widget.workflowId);
      debugPrint("Workflow obtenido: $workflow");

      if (workflow != null) {
        setState(() {
          _workflow = workflow;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Workflow no encontrado';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar workflow: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
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
              onPressed: _loadWorkflow,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    final workflow = _workflow!;
    return RefreshIndicator(
      onRefresh: _loadWorkflow,
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
            ),
            WorkflowInfoGrid(
              createdAt: workflow['createdAt'] ?? "Sin fecha de creación",
              updatedAt: workflow['updatedAt'] ?? "Sin fecha de actualización",
            ),
            SizedBox(height: 10.0),
            // WorkflowExecutionGroup(workflowExecutions: executions),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
