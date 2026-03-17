import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:n8n_monitor/api/http_client.dart';

/// Crea una nueva tag en n8n.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> createTag(String name) async {
  try {
    final response = await HttpClient()
        .post('tags', body: {'name': name})
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 201) {
      return {'data': jsonDecode(response.body), 'error': null};
    }

    if (response.statusCode == 400) {
      return {'data': null, 'error': 'Datos inválidos para crear la tag'};
    }

    if (response.statusCode == 401) {
      return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
    }

    if (response.statusCode == 409) {
      return {'data': null, 'error': 'Ya existe una tag con ese nombre'};
    }

    return {
      'data': null,
      'error': 'Error al crear la tag: ${response.statusCode}',
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
    return {'data': null, 'error': 'Error inesperado al crear la tag'};
  }
}

/// Retorna todas las tags de n8n.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': [...], 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> getTags() async {
  try {
    final response = await HttpClient()
        .get('tags')
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return {'data': jsonDecode(response.body), 'error': null};
    }

    if (response.statusCode == 401) {
      return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
    }

    return {
      'data': null,
      'error': 'Error al obtener las tags: ${response.statusCode}',
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
    return {'data': null, 'error': 'Error inesperado al obtener las tags'};
  }
}

/// Retorna una tag por su ID.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> getTagById(String id) async {
  try {
    final response = await HttpClient()
        .get('tags/$id')
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return {'data': jsonDecode(response.body), 'error': null};
    }

    if (response.statusCode == 401) {
      return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
    }

    if (response.statusCode == 404) {
      return {'data': null, 'error': 'Tag no encontrada'};
    }

    return {
      'data': null,
      'error': 'Error al obtener la tag: ${response.statusCode}',
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
    return {'data': null, 'error': 'Error inesperado al obtener la tag'};
  }
}

/// Actualiza las tags de un workflow por su ID.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': [...], 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> updateWorkflowTags(
  String workflowId,
  Map<String, dynamic> tags,
) async {
  try {
    final response = await HttpClient()
        .put('workflows/$workflowId/tags', body: tags)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return {'data': jsonDecode(response.body), 'error': null};
    }

    if (response.statusCode == 400) {
      return {
        'data': null,
        'error': 'La solicitud es inválida o contiene datos malformados',
      };
    }

    if (response.statusCode == 401) {
      return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
    }

    if (response.statusCode == 404) {
      return {'data': null, 'error': 'Workflow no encontrado'};
    }

    return {
      'data': null,
      'error': 'Error al actualizar las tags del workflow: ${response.statusCode}',
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
      'error': 'Error inesperado al actualizar las tags del workflow',
    };
  }
}

/// Elimina una tag por su ID.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> deleteTag(String id) async {
  try {
    final response = await HttpClient()
        .delete('tags/$id')
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return {'data': jsonDecode(response.body), 'error': null};
    }

    if (response.statusCode == 401) {
      return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
    }

    if (response.statusCode == 403) {
      return {
        'data': null,
        'error': 'No tienes permisos para eliminar esta tag',
      };
    }

    if (response.statusCode == 404) {
      return {'data': null, 'error': 'Tag no encontrada'};
    }

    return {
      'data': null,
      'error': 'Error al eliminar la tag: ${response.statusCode}',
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
    return {'data': null, 'error': 'Error inesperado al eliminar la tag'};
  }
}

/// Actualiza el nombre de una tag por su ID.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> updateTag(String id, String name) async {
  try {
    final response = await HttpClient()
        .put('tags/$id', body: {'name': name})
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return {'data': jsonDecode(response.body), 'error': null};
    }

    if (response.statusCode == 400) {
      return {'data': null, 'error': 'Datos inválidos para actualizar la tag'};
    }

    if (response.statusCode == 401) {
      return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
    }

    if (response.statusCode == 404) {
      return {'data': null, 'error': 'Tag no encontrada'};
    }

    if (response.statusCode == 409) {
      return {'data': null, 'error': 'Ya existe una tag con ese nombre'};
    }

    return {
      'data': null,
      'error': 'Error al actualizar la tag: ${response.statusCode}',
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
    return {'data': null, 'error': 'Error inesperado al actualizar la tag'};
  }
}
