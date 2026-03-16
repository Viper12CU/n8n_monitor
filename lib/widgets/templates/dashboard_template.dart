import 'package:flutter/material.dart';
import 'package:n8n_monitor/provider/server_status_animation_provider.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/server_status.dart';
import 'package:n8n_monitor/widgets/molecules/dashboard_info_grid.dart';
import 'package:n8n_monitor/widgets/molecules/execution_line_chart.dart';
import 'package:n8n_monitor/widgets/molecules/last_audit_stats.dart';
import 'package:provider/provider.dart';

class DashboardTemplate extends StatefulWidget {
  const DashboardTemplate({super.key});

  @override
  State<DashboardTemplate> createState() => _DashboardTemplateState();
}

class _DashboardTemplateState extends State<DashboardTemplate> {
  @override
  Widget build(BuildContext context) {
    final scrollControlerProvider = Provider.of<ServerStatusAnimationProvider>(
      context,
    );

    return SingleChildScrollView(
      controller: scrollControlerProvider.scrollControler,
      child: Column(
        children: [
          AnimatedOpacity(
            opacity: !scrollControlerProvider.showOnAppBar ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: const ServerStatus(status: Status.avalible),
          ),
          const DashboardInfoGrid(),
          const ExecutionLineChart(),
          const LastAuditStats(),
        ],
      ),
    );
  }
}
