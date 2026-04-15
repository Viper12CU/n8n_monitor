import 'package:flutter/material.dart';
import 'package:n8n_monitor/provider/server_stats_provider.dart';
import 'package:n8n_monitor/widgets/molecules/credentials_stats_card.dart';
import 'package:provider/provider.dart';

class DashboardStatsSection extends StatefulWidget {
  const DashboardStatsSection({Key? key}) : super(key: key);

  @override
  State<DashboardStatsSection> createState() => _DashboardStatsSectionState();
}

class _DashboardStatsSectionState extends State<DashboardStatsSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServerStatsProvider>().loadStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<ServerStatsProvider>().refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: const CredentialsStatsCard(),
      ),
    );
  }
}
