import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/info_container_sm.dart';

class DashboardInfoGrid extends StatelessWidget {
  const DashboardInfoGrid({super.key});

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
          value: "42",
        ),
        InfoContainerSm(
          variant: InfoContainerSmVariant.secondary,
          icon: Icons.slow_motion_video_rounded,
          title: "Workflows activos",
          value: "12",
        ),
      ],
    );
  }
}
