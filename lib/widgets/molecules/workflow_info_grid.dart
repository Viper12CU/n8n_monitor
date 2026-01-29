import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/single_info_container.dart';

class WorkflowInfoGrid extends StatelessWidget {
  const WorkflowInfoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.1,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SingleInfoContainer(
          title: "Fecha de creación",
          info: "2024-06-15 14:30",
        ),
        SingleInfoContainer(
          title: "Fecha de creación",
          info: "2024-06-15 14:30",
        ),
      ],
    );
  }
}
