import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:n8n_monitor/api/http_client.dart';

/// Enum para definir los períodos de tiempo disponibles
enum ExecutionTimePeriod {
  last12Hours,
  last24Hours,
  last7Days,
  last15Days,
  last30Days,
}

/// Modelo para los datos agrupados de ejecuciones
class ExecutionGroupData {
  final String timeLabel; // Hora (HH:mm) o Día (yyyy-MM-dd)
  final int count;

  ExecutionGroupData({required this.timeLabel, required this.count});

  Map<String, dynamic> toMap() {
    return {
      'timeLabel': timeLabel,
      'count': count,
    };
  }
}



Future<Map<String, dynamic>> getAllExecutions() async {
  try {
    final response = await HttpClient().get('executions').timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200) {
      return {
        'data': jsonDecode(response.body),
        'error': null,
      };
    }

    if (response.statusCode == 404) {
      return {
        'data': null,
        'error': 'Ejecuciones no encontradas',
      };
    }

    return {
      'data': null,
      'error': 'Error al obtener ejecuciones: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error': 'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {
      'data': null,
      'error': 'Error inesperado al obtener las ejecuciones',
    };
  }
}


Future<Map<String, dynamic>> getExecutionById(String id) async {
  try {
    final response = await HttpClient().get('executions/$id').timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200) {
      return {
        'data': jsonDecode(response.body),
        'error': null,
      };
    }

    if (response.statusCode == 404) {
      return {
        'data': null,
        'error': 'Ejecución no encontrada',
      };
    }

    return {
      'data': null,
      'error': 'Error al obtener ejecución: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error': 'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {
      'data': null,
      'error': 'Error inesperado al obtener la ejecución',
    };
  }
}


/// Obtiene las ejecuciones de un workflow específico
Future<Map<String, dynamic>> getExecutionsByWorkflowId(String workflowId) async {
  try {
    final response = await HttpClient().get(
      'executions',
      queryParameters: {'workflowId': workflowId},
    ).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200) {
      return {
        'data': jsonDecode(response.body),
        'error': null,
      };
    }

    if (response.statusCode == 404) {
      return {
        'data': null,
        'error': 'No se encontraron ejecuciones para este workflow',
      };
    }

    return {
      'data': null,
      'error': 'Error al obtener ejecuciones: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error': 'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {
      'data': null,
      'error': 'Error inesperado al obtener las ejecuciones del workflow',
    };
  }
}


/// Elimina una ejecución por ID
Future<Map<String, dynamic>> deleteExecutionById(String id) async {
  try {
    final response = await HttpClient().delete('executions/$id').timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return {
        'data': null,
        'error': null,
      };
    }

    if (response.statusCode == 401) {
      return {
        'data': null,
        'error': 'No autorizado. Verifica tu API key',
      };
    }

    if (response.statusCode == 404) {
      return {
        'data': null,
        'error': 'Ejecución no encontrada',
      };
    }

    return {
      'data': null,
      'error': 'Error al eliminar ejecución: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error': 'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {
      'data': null,
      'error': 'Error inesperado al eliminar la ejecución',
    };
  }
}


/// Reintenta una ejecución por ID
Future<Map<String, dynamic>> retryExecutionById(String id, {bool loadWorkflow = true}) async {
  try {
    final response = await HttpClient().post(
      'executions/$id/retry',
      body: {'loadWorkflow': loadWorkflow},
    ).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200) {
      return {
        'data': jsonDecode(response.body),
        'error': null,
      };
    }

    if (response.statusCode == 401) {
      return {
        'data': null,
        'error': 'No autorizado. Verifica tu API key',
      };
    }

    if (response.statusCode == 404) {
      return {
        'data': null,
        'error': 'Ejecución no encontrada',
      };
    }

    if (response.statusCode == 409) {
      return {
        'data': null,
        'error': 'No se puede reintentar esta ejecución',
      };
    }

    return {
      'data': null,
      'error': 'Error al reintentar ejecución: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error': 'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {
      'data': null,
      'error': 'Error inesperado al reintentar la ejecución',
    };
  }
}


/// Detiene una ejecución por ID
Future<Map<String, dynamic>> stopExecutionById(String id) async {
  try {
    final response = await HttpClient().post('executions/$id/stop').timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200) {
      return {
        'data': jsonDecode(response.body),
        'error': null,
      };
    }

    if (response.statusCode == 401) {
      return {
        'data': null,
        'error': 'No autorizado. Verifica tu API key',
      };
    }

    if (response.statusCode == 404) {
      return {
        'data': null,
        'error': 'Ejecución no encontrada',
      };
    }

    return {
      'data': null,
      'error': 'Error al detener ejecución: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error': 'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {
      'data': null,
      'error': 'Error inesperado al detener la ejecución',
    };
  }
}

/// Filtra ejecuciones por período de tiempo y devuelve datos agrupados
/// Devuelve TODAS las horas/días del período, aunque no haya ejecuciones (count: 0)
/// 
/// Parámetros:
/// - [executions]: Lista de ejecuciones a filtrar (pueden venir del API)
/// - [period]: Período de tiempo para filtrar
/// 
/// Devuelve:
/// - Map con 'total' (total de ejecuciones) y 'data' (lista completa de horas/días)
Map<String, dynamic> filterExecutionsByTimePeriod(
  List<dynamic> executions,
  ExecutionTimePeriod period,
) {
  try {
    final now = DateTime.now();
    final filteredExecutions = <dynamic>[];

    // Calcular fecha de inicio según el período
    DateTime startDate;
    int intervalCount;
    bool isHourly;

    switch (period) {
      case ExecutionTimePeriod.last12Hours:
        startDate = now.subtract(const Duration(hours: 12));
        intervalCount = 12;
        isHourly = true;
        break;
      case ExecutionTimePeriod.last24Hours:
        startDate = now.subtract(const Duration(hours: 24));
        intervalCount = 24;
        isHourly = true;
        break;
      case ExecutionTimePeriod.last7Days:
        startDate = now.subtract(const Duration(days: 7));
        intervalCount = 7;
        isHourly = false;
        break;
      case ExecutionTimePeriod.last15Days:
        startDate = now.subtract(const Duration(days: 15));
        intervalCount = 15;
        isHourly = false;
        break;
      case ExecutionTimePeriod.last30Days:
        startDate = now.subtract(const Duration(days: 30));
        intervalCount = 30;
        isHourly = false;
        break;
    }

    // Filtrar ejecuciones por rango de fecha
    for (final execution in executions) {
      try {
        final dateStr = execution['startedAt'];
        if (dateStr != null && dateStr.toString().isNotEmpty) {
          final executionDate = DateTime.parse(dateStr.toString());
          if (executionDate.isAfter(startDate) && executionDate.isBefore(now)) {
            filteredExecutions.add(execution);
          }
        }
      } catch (e) {
        continue;
      }
    }

    // Generar todas las etiquetas de tiempo para el período
    final allTimeLabels = <String>[];

    if (isHourly) {
      // Generar todas las horas
      for (int i = 0; i < intervalCount; i++) {
        final time = startDate.add(Duration(hours: i));
        // Usar solo la hora, no el minuto
        final timeLabel =
            '${time.hour.toString().padLeft(2, '0')}:00';
        allTimeLabels.add(timeLabel);
      }
    } else {
      // Generar todos los días
      for (int i = 0; i < intervalCount; i++) {
        final date = startDate.add(Duration(days: i));
        final dateLabel =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        allTimeLabels.add(dateLabel);
      }
    }

    // Agrupar ejecuciones según el período
    final groupedData = <String, int>{};

    // Inicializar todos los labels con 0
    for (final label in allTimeLabels) {
      groupedData[label] = 0;
    }

    // Contar ejecuciones
    for (final execution in filteredExecutions) {
      try {
        final dateStr = execution['startedAt'];
        if (dateStr != null && dateStr.toString().isNotEmpty) {
          final executionDate = DateTime.parse(dateStr.toString()).toLocal();
          late String timeLabel;

          if (isHourly) {
            // Usar solo la hora, no el minuto
            timeLabel =
                '${executionDate.hour.toString().padLeft(2, '0')}:00';
          } else {
            timeLabel =
                '${executionDate.year}-${executionDate.month.toString().padLeft(2, '0')}-${executionDate.day.toString().padLeft(2, '0')}';
          }

          if (groupedData.containsKey(timeLabel)) {
            groupedData[timeLabel] = (groupedData[timeLabel] ?? 0) + 1;
          }
        }
      } catch (e) {
        continue;
      }
    }

    // Convertir a lista ordenada de objetos
    final dataList = groupedData.entries
        .map((entry) => ExecutionGroupData(
              timeLabel: entry.key,
              count: entry.value,
            ))
        .toList();

    // Ordenar por timeLabel
    dataList.sort((a, b) => a.timeLabel.compareTo(b.timeLabel));

    return {
      'total': filteredExecutions.length,
      'data': dataList.map((item) => item.toMap()).toList(),
      'error': null,
    };
  } catch (e) {
    return {
      'total': 0,
      'data': [],
      'error': 'Error al filtrar ejecuciones: $e',
    };
  }
}

/// Procesa la respuesta del API getAllExecutions y la filtra por período
/// Útil para filtrar directamente la respuesta completa del endpoint
Future<Map<String, dynamic>> getExecutionsByTimePeriod(
  ExecutionTimePeriod period,
) async {
  try {
    final response = await getAllExecutions();

    if (response['error'] != null) {
      return response;
    }

    // La respuesta del API tiene estructura: { data: [...], nextCursor: "..." }
    // Entonces response['data'] es todo ese objeto
    final apiResponse = response['data'] as Map<String, dynamic>? ?? {};
    final executionsList = apiResponse['data'] as List<dynamic>? ?? [];
    
    final filtered = filterExecutionsByTimePeriod(executionsList, period);

    return filtered;
  } catch (e) {
    return {
      'total': 0,
      'data': [],
      'error': 'Error al obtener ejecuciones: $e',
    };
  }
}



