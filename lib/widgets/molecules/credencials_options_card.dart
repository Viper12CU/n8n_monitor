import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/tools_card.dart';
import 'package:n8n_monitor/widgets/pages/credencials_page.dart';
import 'package:page_transition/page_transition.dart';

class CredencialsOptionsCard extends StatelessWidget {
  const CredencialsOptionsCard({super.key});

  void _navigateToCredencials(BuildContext context, CredencialsPageType type) {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 300),
        type: PageTransitionType.leftToRight,
        child: CredencialsPage(type: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ToolsCard(
      height: 200,
      centerTitle: 'Credenciales',
      leftIcon: Icons.add_circle_outline_rounded,
      leftTitle: 'Crear credencial',
      leftDescription: 'Agregar una nueva credencial',
      rightIcon: Icons.badge_outlined,
      rightTitle: 'Ver credenciales',
      rightDescription: 'Consultar credenciales guardadas',
      onLeftTap: () =>
          _navigateToCredencials(context, CredencialsPageType.create),
      onRightTap: () => _navigateToCredencials(context, CredencialsPageType.list),
    );
  }
}
