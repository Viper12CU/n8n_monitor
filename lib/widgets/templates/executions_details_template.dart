import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n8n_monitor/utils/execution_helpers.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/workflow_card.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/molecules/execution_info_grid.dart';
import 'package:n8n_monitor/api/executions.dart';
import 'package:n8n_monitor/api/workflows.dart';

class ExecutionsDetailsTemplate extends StatefulWidget {
  final String executionId;
  const ExecutionsDetailsTemplate({super.key, required this.executionId});

  @override
  State<ExecutionsDetailsTemplate> createState() =>
      _ExecutionsDetailsTemplateState();
}

class _ExecutionsDetailsTemplateState extends State<ExecutionsDetailsTemplate> {
  Map<String, dynamic>? _execution;
  Map<String, dynamic>? _workflow;
  bool _isLoading = true;
  String? _errorMessage;


  @override
  void initState() {
    super.initState();
    _loadExecutionData();
  }

  Future<void> _loadExecutionData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final executionResponse = await getExecutionById(widget.executionId);

    if (executionResponse['error'] != null) {
      setState(() {
        _errorMessage = executionResponse['error'];
        _isLoading = false;
      });
      return;
    } else if (executionResponse['data'] == null) {
      setState(() {
        _errorMessage = 'No se pudo cargar la ejecución';
        _isLoading = false;
      });
      return;
    }

    final execution = executionResponse['data'];
    final workflowId = execution['workflowId'];

    // Cargar el workflow en paralelo si existe workflowId
    Map<String, dynamic>? workflow;
    if (workflowId != null) {
      final workflowResponse = await getWorkflowById(workflowId);
      if (workflowResponse['error'] == null && workflowResponse['data'] != null) {
        workflow = workflowResponse['data'];
      }
    }

    setState(() {
      _execution = execution;
      _workflow = workflow;
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
              onPressed: _loadExecutionData,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    final execution = _execution!;
    final statusConfig = getStatusConfig(execution['status'] ?? 'unknown');

     String formatDate(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      final formatter = DateFormat('dd-MM-yyyy HH:mm');
      return formatter.format(dateTime);
    } catch (e) {
      return isoDate; // Retorna la fecha original si hay error
    }
  }

    return RefreshIndicator(
      onRefresh: _loadExecutionData,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          spacing: 20.0,
          children: [
            nameCard(context, execution, statusConfig),
            ExecutionInfoGrid(
              mode: execution['mode'] ?? 'unknown',
              executionId: execution['id'] ?? '',
              startedAt: formatDate(execution['startedAt'] ?? 'N/A'),
              stoppedAt: formatDate(execution['stoppedAt'] ?? 'N/A'),
            ),
            if (execution['workflowId'] != null)
              CustomGroupCategory(
                category: "WORKFLOW ASOCIADO",
                child: WorkflowCard(
                  id: execution['workflowId'],
                  workflowName: _workflow?['name'] ?? 'Workflow ${execution['workflowId']}',
                  initialStatus: _workflow?['active'] ?? false,
                  lastUpdate: _workflow?['updatedAt'] ?? 'N/A',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget nameCard(
    BuildContext context,
    Map<String, dynamic> execution,
    Map<String, dynamic> statusConfig,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  _workflow?['name'] ?? 'Workflow ${execution['workflowId']}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.fade
                        
                  ),
                ),
              ),
              Text(
                "EJECUCIÓN DEL WORKFLOW",
                style: TextStyle(color: Color(0x99FFFFFF)),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: statusConfig['color'], width: 1.5),
            ),
            child: Row(
              spacing: 5,
              children: [
                Icon(statusConfig['icon'], color: statusConfig['color']),
                Text(
                  statusConfig['label'],
                  style: TextStyle(color: statusConfig['color']),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
