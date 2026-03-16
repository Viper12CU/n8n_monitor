import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:n8n_monitor/provider/execution_filter_provider.dart';
import 'package:n8n_monitor/widgets/molecules/executions_filter.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/execution_card.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/error_message.dart';
import 'package:n8n_monitor/utils/execution_helpers.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/api/executions.dart';
import 'package:n8n_monitor/api/workflows.dart';

class ExecutionsListTemplate extends StatefulWidget {
  const ExecutionsListTemplate({super.key});

  @override
  State<ExecutionsListTemplate> createState() => _ExecutionsListTemplateState();
}

class _ExecutionsListTemplateState extends State<ExecutionsListTemplate> {
  List<Map<String, dynamic>> _executions = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadExecutions();
  }

  Future<void> _loadExecutions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await getAllExecutions();

    if (response['error'] != null) {
      setState(() {
        _errorMessage = response['error'];
        _isLoading = false;
      });
      return;
    } else if (response['data'] == null) {
      setState(() {
        _errorMessage = 'No se pudieron cargar las ejecuciones';
        _isLoading = false;
      });
      return;
    }

    final executionsData = response['data']['data'] as List<dynamic>?;
    if (executionsData == null || executionsData.isEmpty) {
      setState(() {
        _executions = [];
        _isLoading = false;
      });
      return;
    }

    // Obtener los workflowIds únicos
    final workflowIds = <String>{};
    for (var exec in executionsData) {
      final workflowId = exec['workflowId'];
      if (workflowId != null) {
        workflowIds.add(workflowId);
      }
    }

    // Cargar todos los workflows en paralelo
    final workflowFutures = workflowIds.map((id) => getWorkflowById(id)).toList();
    final workflowResponses = await Future.wait(workflowFutures);

    // Crear un mapa de workflowId -> nombre del workflow
    final workflowNames = <String, String>{};
    for (var i = 0; i < workflowIds.length; i++) {
      final workflowId = workflowIds.elementAt(i);
      final workflowResponse = workflowResponses[i];
      if (workflowResponse['error'] == null && workflowResponse['data'] != null) {
        workflowNames[workflowId] = workflowResponse['data']['name'] ?? 'Workflow $workflowId';
      } else {
        workflowNames[workflowId] = 'Workflow $workflowId';
      }
    }

    // Formatear las ejecuciones con campos adicionales
    final formattedExecutions = executionsData.map((execution) {
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

      // Obtener el nombre del workflow del mapa
      final workflowId = exec['workflowId'];
      final workflowName = workflowId != null 
          ? workflowNames[workflowId] ?? 'Workflow $workflowId'
          : 'Workflow desconocido';
      
      return {
        ...exec,
        'workflowName': workflowName,
        'formattedTime': formattedTime,
      };
    }).toList();
    
    setState(() {
      _executions = formattedExecutions;
      _isLoading = false;
    });
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
            errorLabel: 'Error al cargar ejecuciones',
            description: _errorMessage!,
            onRetry: _loadExecutions,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadExecutions,
      child: Column(
        children: [
          const ExecutionsFilter(),
          Expanded(
            child: Consumer<ExecutionFilterProvider>(
              builder: (context, filterProvider, child) {
                // Aplicar el filtro usando el provider
                final filteredExecutions = filterProvider.filterExecutions(_executions);
                
                // Organizar las ejecuciones filtradas por fecha
                final organizedExecutions = organizeExecutionsByDate(filteredExecutions);
                
                // Si no hay ejecuciones después del filtro, mostrar mensaje
                if (organizedExecutions.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No hay ejecuciones con el filtro ${filterProvider.currentFilterLabel.toLowerCase()}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                
                return ListView.builder(
                  itemCount: organizedExecutions.length,
                  itemBuilder: (context, index) {
                    final category = organizedExecutions.keys.elementAt(index);
                    final categoryExecutions = organizedExecutions[category]!;
                    
                    return CustomGroupCategory(
                      categoryPadding: EdgeInsetsGeometry.only(left: 20, bottom: 8, top: 20),
                      category: category,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          spacing: 10.0,
                          children: categoryExecutions.map((execution) {
                            return ExecutionCard(
                              workflow: execution['workflowName'] ?? 'Workflow ${execution['workflowId']}',
                              status: execution['status'] ?? 'unknown',
                              id: execution['id'] ?? '',
                              date: execution['formattedTime'] ?? '',
                            );
                          }).toList(),
                        ),
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