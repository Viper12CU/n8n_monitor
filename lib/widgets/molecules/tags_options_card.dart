import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
import 'package:n8n_monitor/widgets/pages/tags_page.dart';

class TagsOptionsCard extends StatelessWidget {
  const TagsOptionsCard({super.key});

  void _navigateToTags(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TagsPage()),
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
            onTap: () => _navigateToTags(context),
            borderRadius: BorderRadius.circular(14.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Row(
                spacing: 14.0,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sell_outlined,
                    size: 22,
                    color: colorScheme.onSecondary,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gestionar etiquetas',
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSecondary,
                          ),
                        ),
                        Text(
                          'Crear, ver, actualizar y eliminar tags',
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