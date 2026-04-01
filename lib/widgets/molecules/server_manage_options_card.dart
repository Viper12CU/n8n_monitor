import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return DividedCard(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _navigateToServerManage(context),
            borderRadius: BorderRadius.circular(14.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Row(
                spacing: 14.0,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dns_rounded,
                    size: 22,
                    color: colorScheme.onSecondary,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gestionar servidor',
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        Text(
                          'Configurar conexión y parámetros del servidor',
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
        ),
      ],
    );
  }
}
