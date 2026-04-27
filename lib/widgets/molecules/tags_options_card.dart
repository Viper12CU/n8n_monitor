import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/tools_card.dart';
import 'package:n8n_monitor/widgets/pages/tags_page.dart';
import 'package:page_transition/page_transition.dart';

class TagsOptionsCard extends StatelessWidget {
  const TagsOptionsCard({super.key});

  void _navigateToTags(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 300),
        type: PageTransitionType.leftToRight,
        child: const TagsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ToolsCard(
      variant: ToolsCardVariant.single,
      height: 200,
      leftIcon: Icons.sell_outlined,
      leftTitle: 'Gestionar etiquetas',
      leftDescription: 'Crear, ver, actualizar y eliminar tags',
      onLeftTap: () => _navigateToTags(context),
    );
  }
}