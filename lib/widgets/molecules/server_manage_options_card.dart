import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/tools_card.dart';
import 'package:n8n_monitor/widgets/pages/servers_manage_page.dart';
import 'package:page_transition/page_transition.dart';

class ServerManageOptionsCard extends StatelessWidget {
  const ServerManageOptionsCard({super.key});

  void _navigateToServerManage(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 300),
        type: PageTransitionType.leftToRight,
        child: const ServersManagePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ToolsCard(
      variant: ToolsCardVariant.single,
      leftIcon: Icons.dns_rounded,
      leftTitle: 'Gestionar servidor',
      leftDescription: 'Configurar conexión y parámetros del servidor',
      onLeftTap: () => _navigateToServerManage(context),
    );
  }
}
