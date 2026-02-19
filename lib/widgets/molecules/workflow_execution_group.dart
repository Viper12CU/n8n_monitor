import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/execution_card.dart';

class WorkflowExecutionGroup extends StatelessWidget {
  final List<Map<String, dynamic>> workflowExecutions;
  const WorkflowExecutionGroup({super.key, required this.workflowExecutions});

  @override
  Widget build(BuildContext context) {
    return CustomGroupCategory(
      categoryPadding: EdgeInsetsGeometry.only(left: 20, bottom: 20),
      category: "Ejecuciones recientes",
      child: Column(
        spacing: 10.0,
        children: workflowExecutions.map((execution) {
          return ExecutionCard(
            workflow: execution["workflowName"],
            status: execution["status"],
            id: execution["id"],
            date: "10:20",
          );
        }).toList(),
      ),
    );
  }
}
