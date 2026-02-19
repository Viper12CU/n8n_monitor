import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/execution_helpers.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/workflow_card.dart';
import 'package:n8n_monitor/widgets/molecules/execution_info_grid.dart';

class ExecutionsDetailsTemplate extends StatefulWidget {
  final String executionId;
  const ExecutionsDetailsTemplate({super.key, required this.executionId});

  @override
  State<ExecutionsDetailsTemplate> createState() =>
      _ExecutionsDetailsTemplateState();
}

class _ExecutionsDetailsTemplateState extends State<ExecutionsDetailsTemplate> {
  bool showName = false;

  void handleTap() {
    setState(() {
      showName = !showName;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Map<String, dynamic> execution = {
      "id": "303",
      "finished": true,
      "mode": "trigger",
      "status": "success",
      "startedAt": "2024-06-15 14:30",
      "stoppedAt": "2024-06-15 14:32",
      "workflowId": "stu901",
      "workflowName": "Archive Data from tu amdre",
    };

    final statusConfig = getStatusConfig(execution['status']);

    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        spacing: 20.0,
        children: [
          nameCard(context, execution, statusConfig),
          ExecutionInfoGrid(
            mode: execution['mode'],
            executionId: execution['id'],
            startedAt: execution['startedAt'],
            stoppedAt: execution['stoppedAt'],
          ),
          CustomGroupCategory(category: "WORKFLOW ASOCIADO", child: WorkflowCard(id: "2FSSFG", workflowName: "Archive data", initialStatus: true, lastUpdate: "Hace 10 min"))
        ],
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
                child: GestureDetector(
                  onDoubleTap: () => handleTap(),
                  child: Text(
                    execution['workflowName'],
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      overflow: showName
                          ? TextOverflow.fade
                          : TextOverflow.ellipsis,
                    ),
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
              border: Border.all(color: statusConfig['color']),
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
