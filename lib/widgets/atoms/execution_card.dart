import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/pages/executions_details_page.dart';

class ExecutionCard extends StatelessWidget {
  final String workflow;
  final String status;
  final String id;
  final String date;

  const ExecutionCard({
    super.key,
    required this.workflow,
    required this.status,
    required this.id,
    required this.date,
  });

  Map<String, dynamic> _getStatusConfig() {
    switch (status.toLowerCase()) {
      case 'success':
      case 'éxito':
        return {
          'icon': Icons.check_circle,
          'color': const Color(0xFF38e07b),
          'label': 'Éxito',
        };
      case 'error':
        return {
          'icon': Icons.error,
          'color': const Color(0xFFef4444),
          'label': 'Error',
        };
      case 'canceled':
      case 'cancelado':
        return {
          'icon': Icons.cancel,
          'color': const Color(0xFFfbbf24),
          'label': 'Cancelado',
        };
      case 'running':
      case 'en ejecución':
        return {
          'icon': Icons.refresh,
          'color': const Color(0xFF3b82f6),
          'label': 'En ejecución',
        };
      case 'waiting':
      case 'esperando':
        return {
          'icon': Icons.schedule,
          'color': const Color(0xFF94a3b8),
          'label': 'Esperando',
        };
      default:
        return {
          'icon': Icons.help_outline,
          'color': const Color(0xFF94a3b8),
          'label': status,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusConfig = _getStatusConfig();

    // Navegar a la página de detalles del ejecucion 

    void navigateToDetails() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExecutionsDetailsPage(workflowId: id),
        ),
      );
    }


    return GestureDetector(
      onTap: () => navigateToDetails(), 
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
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
                color: Colors.white.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}