import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/execution_helpers.dart';
import 'package:n8n_monitor/widgets/pages/executions_details_page.dart';
import 'package:page_transition/page_transition.dart';

class ExecutionCard extends StatelessWidget {
  final String workflow;
  final String status;
  final String id;
  final String date;
  final VoidCallback? onExecutionChanged;

  const ExecutionCard({
    super.key,
    required this.workflow,
    required this.status,
    required this.id,
    required this.date,
    this.onExecutionChanged,
  });

  

  @override
  Widget build(BuildContext context) {
    final statusConfig = getStatusConfig(status);

    // Navegar a la página de detalles del ejecucion 

    void navigateToDetails() async {
      final result = await Navigator.push(
        context,
       PageTransition(type: PageTransitionType.leftToRight, childBuilder: (context) => ExecutionsDetailsPage(executionId: id),),
       
      );
      
      // Si el resultado es true, significa que hubo cambios (retry o delete)
      if (result == true && context.mounted) {
        // Notificar al widget padre para que refresque
        onExecutionChanged?.call();
      }
    }


    return GestureDetector(
      onTap: () => navigateToDetails(), 
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icono de estado
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Color(0xFF25362e),
                shape: BoxShape.circle,
              ),
              child: Icon(
                statusConfig['icon'],
                color: statusConfig['color'],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Información del workflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workflow,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'ID: $id',
                        style: TextStyle(
                          color: Colors.white.withAlpha((0.7 * 255).toInt()),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.white.withAlpha((0.5 * 255).toInt()),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        statusConfig['label'],
                        style: TextStyle(
                          color: statusConfig['color'],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Hora
            Text(
              date,
              style: TextStyle(
                color: Colors.white.withAlpha((0.6 * 255).toInt()),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}