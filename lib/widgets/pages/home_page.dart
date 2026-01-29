import 'package:flutter/material.dart';
import 'package:n8n_monitor/provider/nav_index_provider.dart';
import 'package:n8n_monitor/provider/server_status_animation_provider.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/appbar_server_status.dart';
import 'package:n8n_monitor/widgets/molecules/nav_bar.dart';
import 'package:n8n_monitor/widgets/templates/dashboard_template.dart';
import 'package:n8n_monitor/widgets/templates/executions_list_template.dart';
import 'package:n8n_monitor/widgets/templates/settings_template.dart';
import 'package:n8n_monitor/widgets/templates/workflows_list_template.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final indexProvider = Provider.of<NavIndexProvider>(context);

    final templates = [
      DashboardTemplate(),
      WorkflowsListTemplate(),
      ExecutionsListTemplate(),
      SettingsTemplate(),
    ];

    return Scaffold(
      appBar: appBar(context, indexProvider.selectedIndex),
      body: IndexedStack(index: indexProvider.selectedIndex, children: templates),
      bottomNavigationBar: NavBar(),
    );
  }

  AppBar appBar(BuildContext context, int selectedIndex) {
    final scrollControlerProvider = Provider.of<ServerStatusAnimationProvider>(
      context,
    );

    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: Row(
        spacing: 10,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Color(0xFF163321),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.data_exploration_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text("n8n Monitor"),
        ],
      ),
      actions: [
        AnimatedOpacity(
          opacity: scrollControlerProvider.showOnAppBar || selectedIndex != 0
              ? 1.0
              : 0.0,
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 300),
          child: AppbarServerStatus(status: Status.avalible),
        ),
        SizedBox(width: 20),
      ],
      actionsIconTheme: Theme.of(context).iconTheme,
      actionsPadding: EdgeInsets.only(right: 15.0),
    );
  }
}
