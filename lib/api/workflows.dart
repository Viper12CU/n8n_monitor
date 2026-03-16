import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:n8n_monitor/api/http_client.dart';

/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> getWorkflowById(String id) async {
  try {
    final response = await HttpClient()
        .get('workflows/$id')
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return {'data': jsonDecode(response.body), 'error': null};
    }

    if (response.statusCode == 404) {
      return {'data': null, 'error': 'Workflow no encontrado'};
    }

    return {
      'data': null,
      'error': 'Error al obtener workflow: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error':
          'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error':
          'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {'data': null, 'error': 'Error inesperado al obtener el workflow'};
  }
}

/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> getWorkflow() async {
  try {
    final response = await HttpClient()
        .get('workflows')
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return {'data': jsonDecode(response.body), 'error': null};
    }

    if (response.statusCode == 404) {
      return {'data': null, 'error': 'Workflows no encontrados'};
    }

    return {
      'data': null,
      'error': 'Error al obtener workflows: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error':
          'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error':
          'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {'data': null, 'error': 'Error inesperado al obtener los workflows'};
  }
}

Future<int> getTotalWorkflow() async {
  final response = await getWorkflow();

  if (response['error'] == null && response['data'] != null) {
    final data = response['data']['data'];
    return data?.length ?? 0;
  }

  return 0;
}

Future<int> getTotalActiveWorkflow() async {
  final response = await getWorkflow();
  int activeCount = 0;

  if (response['error'] == null && response['data'] != null) {
    final data = response['data']['data'];
    if (data != null) {
      for (var workflow in data) {
        if (workflow['active'] == true) {
          activeCount++;
        }
      }
    }
  }

  return activeCount;
}

/// Elimina un workflow por su ID
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...} | null, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> deleteWorkflowById(String id) async {
  try {
    final response = await HttpClient()
        .delete('workflows/$id')
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200 || response.statusCode == 204) {
      return {
        'data': response.body.isNotEmpty ? jsonDecode(response.body) : null,
        'error': null,
      };
    }

    if (response.statusCode == 404) {
      return {'data': null, 'error': 'Workflow no encontrado'};
    }

    if (response.statusCode == 401) {
      return {'data': null, 'error': 'No autorizado. Verifica tu API Key.'};
    }

    if (response.statusCode == 403) {
      return {
        'data': null,
        'error': 'No tienes permisos para eliminar este workflow',
      };
    }

    return {
      'data': null,
      'error': 'Error al eliminar workflow: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error':
          'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error':
          'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {'data': null, 'error': 'Error inesperado al eliminar el workflow'};
  }
}

/// Activa un workflow por su ID
/// [id] es requerido
/// [name], [description] y [versionId] son opcionales y se envían en el body JSON si están informados
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...} | null, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> activateWorkflow(
  String id, {
  String? name,
  String? description,
  String? versionId,
}) async {
  try {
    final payload = <String, dynamic>{
      if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
      if (description != null && description.trim().isNotEmpty)
        'description': description.trim(),
      if (versionId != null && versionId.trim().isNotEmpty)
        'versionId': versionId.trim(),
    };

    final response = await HttpClient()
        .post('workflows/$id/activate', body: payload.isEmpty ? null : payload)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return {
        'data': response.body.isNotEmpty ? jsonDecode(response.body) : null,
        'error': null,
      };
    }

    if (response.statusCode == 401) {
      debugPrint('[activateWorkflow] 401 id=$id response=${response.body}');
      return {'data': null, 'error': 'No autorizado. Verifica tu API Key.'};
    }

    if (response.statusCode == 400) {
      debugPrint(
        '[activateWorkflow] 400 id=$id payload=$payload response=${response.body}',
      );
      return {
        'data': null,
        'error': 'Solicitud inválida. Revisa los datos enviados.',
      };
    }

    if (response.statusCode == 404) {
      debugPrint('[activateWorkflow] 404 id=$id response=${response.body}');
      return {'data': null, 'error': 'Workflow no encontrado'};
    }

    debugPrint(
      '[activateWorkflow] status=${response.statusCode} id=$id response=${response.body}',
    );

    return {
      'data': null,
      'error': 'Error al activar workflow: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error':
          'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error':
          'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {'data': null, 'error': 'Error inesperado al activar el workflow'};
  }
}

/// Desactiva un workflow por su ID
/// [id] es requerido
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...} | null, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> deactivateWorkflow(String id) async {
  try {
    final response = await HttpClient()
        .post('workflows/$id/deactivate')
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return {
        'data': response.body.isNotEmpty ? jsonDecode(response.body) : null,
        'error': null,
      };
    }

    if (response.statusCode == 401) {
      return {'data': null, 'error': 'No autorizado. Verifica tu API Key.'};
    }

    if (response.statusCode == 404) {
      return {'data': null, 'error': 'Workflow no encontrado'};
    }

    return {
      'data': null,
      'error': 'Error al desactivar workflow: ${response.statusCode}',
    };
  } on TimeoutException catch (_) {
    return {
      'data': null,
      'error':
          'La solicitud ha excedido el tiempo de espera. Verifica tu conexión a Internet.',
    };
  } on SocketException catch (_) {
    return {
      'data': null,
      'error':
          'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
    };
  } catch (e) {
    return {
      'data': null,
      'error': 'Error inesperado al desactivar el workflow',
    };
  }
}
