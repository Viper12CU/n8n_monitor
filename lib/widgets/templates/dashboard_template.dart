import 'package:flutter/material.dart';
import 'package:n8n_monitor/provider/server_status_animation_provider.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/server_status.dart';
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
            duration: Duration(milliseconds: 300),
            child: ServerStatus(status: Status.avalible),
          ),

          ...List.generate(
            25,
            (index) => Container(
              height: 60,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Elemento ${index + 1}')),
            ),
          ),
        ],
      ),
    );
  }
}
