import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:n8n_monitor/api/http_client.dart';



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



