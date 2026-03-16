import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Organiza una lista de ejecuciones por fecha en categorías como "Hoy", "Ayer", etc.
Map<String, List<Map<String, dynamic>>> organizeExecutionsByDate(
  List<Map<String, dynamic>> executions,
) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final lastWeek = today.subtract(const Duration(days: 7));
  final lastMonth = today.subtract(const Duration(days: 30));

  Map<String, List<Map<String, dynamic>>> organized = {
    'Hoy': [],
    'Ayer': [],
    'Esta semana': [],
    'Este mes': [],
    'Más antiguo': [],
  };

  for (var execution in executions) {
    // Obtener la fecha de inicio de la ejecución
    final startedAt = execution['startedAt'];
    if (startedAt == null) continue;

    DateTime executionDate;
    try {
      executionDate = DateTime.parse(startedAt);
    } catch (e) {
      continue; // Si no se puede parsear, saltamos esta ejecución
    }

    // Crear objeto organizado con datos formateados
    final organizedExecution = {
      'id': execution['id'],
      'finished': execution['finished'],
      'mode': execution['mode'],
      'retryOf': execution['retryOf'],
      'retrySuccessId': execution['retrySuccessId'],
      'status': execution['status'],
      'startedAt': execution['startedAt'],
      'stoppedAt': execution['stoppedAt'],
      'workflowId': execution['workflowId'],
      'workflowName': execution['workflowName'], // ✅ Agregar workflowName
      'waitTill': execution['waitTill'],
      // Datos adicionales formateados
      'formattedDate': DateFormat('dd/MM/yyyy').format(executionDate),
      'formattedTime': execution['formattedTime'] ?? DateFormat('HH:mm').format(executionDate),
      'formattedDateTime': DateFormat('dd/MM/yyyy HH:mm').format(executionDate),
    };

    // Clasificar por fecha
    final executionDay = DateTime(
      executionDate.year,
      executionDate.month,
      executionDate.day,
    );

    if (executionDay.isAtSameMomentAs(today)) {
      organized['Hoy']!.add(organizedExecution);
    } else if (executionDay.isAtSameMomentAs(yesterday)) {
      organized['Ayer']!.add(organizedExecution);
    } else if (executionDate.isAfter(lastWeek)) {
      organized['Esta semana']!.add(organizedExecution);
    } else if (executionDate.isAfter(lastMonth)) {
      organized['Este mes']!.add(organizedExecution);
    } else {
      organized['Más antiguo']!.add(organizedExecution);
    }
  }

  // Eliminar categorías vacías
  organized.removeWhere((key, value) => value.isEmpty);

  return organized;
}

/// Convierte el status de la API al formato usado en la UI
String formatExecutionStatus(String status) {
  switch (status.toLowerCase()) {
    case 'success':
      return 'éxito';
    case 'error':
      return 'error';
    case 'canceled':
      return 'cancelado';
    case 'running':
      return 'en ejecución';
    case 'waiting':
      return 'esperando';
    default:
      return status;
  }
}

/// Obtiene el nombre del workflow desde el workflowId (temporal, hasta que se obtenga de la API)
String getWorkflowName(String workflowId) {
  // Por ahora retorna el ID, pero se puede reemplazar con una llamada a la API
  // o un Map de workflowId -> nombre
  return 'Workflow $workflowId';
}


Map<String, dynamic> getStatusConfig(String status) {
    switch (status) {
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