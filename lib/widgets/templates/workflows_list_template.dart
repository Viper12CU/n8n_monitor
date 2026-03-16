import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:n8n_monitor/provider/workflow_filter_provider.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/workflow_card.dart';
import 'package:n8n_monitor/widgets/atoms/error_message.dart';
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

    final response = await getWorkflow();

    if (response['error'] != null) {
      setState(() {
        _errorMessage = response['error'];
        _isLoading = false;
      });
    } else if (response['data'] != null) {
      setState(() {
        _workflows = response['data'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = 'No se pudieron cargar los workflows';
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ErrorMessage(
            errorLabel: 'Error al cargar workflows',
            description: _errorMessage!,
            onRetry: _loadWorkflows,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _loadWorkflows(),
      child: Column(
        children: [
          const WorkflowsFilter(),
          Expanded(
            child: Consumer<WorkflowFilterProvider>(
              builder: (context, filterProvider, child) {
                // Obtener la lista completa de workflows
                final allWorkflows = _workflows["data"] as List<dynamic>;

                // Aplicar el filtro usando el provider
                final filteredWorkflows = filterProvider.filterWorkflows(
                  allWorkflows,
                );

                // Si no hay workflows después del filtro, mostrar mensaje
                if (filteredWorkflows.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No hay workflows ${filterProvider.currentFilterLabel.toLowerCase()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: filteredWorkflows.length,
                  itemBuilder: (context, index) {
                    final workflow = filteredWorkflows[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: WorkflowCard(
                        key: Key(workflow['id']),
                        id: workflow['id'],
                        workflowName: workflow['name'],
                        initialStatus: workflow['active'] ?? false,
                        lastUpdate: workflow['updatedAt'] ?? '',
                        onWorkflowDeleted: _loadWorkflows,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
