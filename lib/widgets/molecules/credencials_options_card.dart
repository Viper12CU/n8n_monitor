import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
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

  Widget _buildActionTile({
    required BuildContext context,
    required VoidCallback onTap,
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Row(
            spacing: 14.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: colorScheme.onSecondary,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DividedCard(
      children: [
        _buildActionTile(
          context: context,
          onTap: () => _navigateToCredencials(context, CredencialsPageType.create),
          icon: Icons.add_circle_outline_rounded,
          title: 'Crear credencial',
          subtitle: 'Agregar una nueva credencial',
        ),
        _buildActionTile(
          context: context,
          onTap: () => _navigateToCredencials(context, CredencialsPageType.list),
          icon: Icons.badge_outlined,
          title: 'Ver credenciales',
          subtitle: 'Consultar credenciales guardadas',
        ),
      ],
    );
  }
}
