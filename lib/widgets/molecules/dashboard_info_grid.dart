import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/workflows.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/info_container_sm.dart';

class DashboardInfoGrid extends StatefulWidget {
  const DashboardInfoGrid({super.key});

  @override
  State<DashboardInfoGrid> createState() => _DashboardInfoGridState();
}

class _DashboardInfoGridState extends State<DashboardInfoGrid> {
  int totalWorkflows = 0;
  int activeWorkflows = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Aquí deberías cargar los datos reales, por ahora usaremos valores de ejemplo
    final total = await getTotalWorkflow();
    final active = await getTotalActiveWorkflow();

    setState(() {
      totalWorkflows = total;
      activeWorkflows = active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        InfoContainerSm(
          icon: Icons.now_widgets_rounded,
          title: "Total workflows",
          value: totalWorkflows.toString(),
        ),
        InfoContainerSm(
          variant: InfoContainerSmVariant.secondary,
          icon: Icons.slow_motion_video_rounded,
          title: "Workflows activos",
          value: activeWorkflows.toString(),
        ),
      ],
    );
  }
}
