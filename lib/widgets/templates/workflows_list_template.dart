import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/workflow_card.dart';
import 'package:n8n_monitor/widgets/molecules/workflows_filter.dart';
import 'package:n8n_monitor/api/workflows.dart';

class WorkflowsListTemplate extends StatefulWidget {
  const WorkflowsListTemplate({super.key});

  // Lista estática de 10 workflows

  @override
  State<WorkflowsListTemplate> createState() => _WorkflowsListTemplateState();
}

class _WorkflowsListTemplateState extends State<WorkflowsListTemplate> {
  late Map<String, dynamic> _workflows;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWorkflows();
  }

  Future<void> _loadWorkflows() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final workflows = await getWorkflow();
      debugPrint("Workflows obtenidos: $workflows");

      if (workflows != null) {
        setState(() {
          _workflows = workflows;
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
        _errorMessage = 'Error al cargar workflows: $e';
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadWorkflows,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>  _loadWorkflows(),
      child: Column(
        children: [
          WorkflowsFilter(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _workflows["data"].length,
              itemBuilder: (context, index) {
                final workflow = _workflows["data"][index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: WorkflowCard(
                    id: workflow['id'],
                    workflowName: workflow['name'],
                    initialStatus: workflow['active'] ?? false,
                    lastUpdate: workflow['updatedAt'] ?? '',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
