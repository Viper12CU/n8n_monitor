import 'package:flutter/material.dart';

class ExecutionsDetailsTemplate extends StatelessWidget {
  final String workflowId;
  const ExecutionsDetailsTemplate({super.key, required this.workflowId});


  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Workflow Details for ID: $workflowId'));
  }
}
