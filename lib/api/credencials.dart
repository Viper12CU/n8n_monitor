import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:n8n_monitor/api/http_client.dart';

/// Lista credenciales (sin datos secretos).
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> getCredentials({int? limit, String? cursor}) async {
	try {
		final queryParams = <String, dynamic>{
			if (limit != null) 'limit': limit,
			if (cursor != null && cursor.trim().isNotEmpty) 'cursor': cursor.trim(),
		};

		final response = await HttpClient()
				.get('credentials', queryParameters: queryParams)
				.timeout(const Duration(seconds: 10));

		if (response.statusCode == 200) {
			return {'data': jsonDecode(response.body), 'error': null};
		}

		if (response.statusCode == 401) {
			return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
		}
		if (response.statusCode == 405) {
			return {'data': null, 'error': 'Tu instancia de n8n no soporta paginación en credenciales. Actualice la instancia o habilite los permisos'};
		}

		return {
			'data': null,
			'error': 'Error al obtener credenciales: ${response.statusCode}',
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
			'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
		};
	} catch (e) {
		return {
			'data': null,
			'error': 'Error inesperado al obtener las credenciales',
		};
	}
}

/// Obtiene el schema de una credencial por tipo.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> getCredentialSchema(
	String credentialTypeName,
) async {
	try {
		final response = await HttpClient()
				.get('credentials/schema/$credentialTypeName')
				.timeout(const Duration(seconds: 10));

		if (response.statusCode == 200) {
			return {'data': jsonDecode(response.body), 'error': null};
		}

		if (response.statusCode == 401) {
			return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
		}

		if (response.statusCode == 404) {
			return {'data': null, 'error': 'Schema no encontrado para el tipo'};
		}

		return {
			'data': null,
			'error': 'Error al obtener el schema: ${response.statusCode}',
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
			'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
		};
	} catch (e) {
		return {
			'data': null,
			'error': 'Error inesperado al obtener el schema de credencial',
		};
	}
}

/// Obtiene los tipos de credencial disponibles en n8n.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': [...tipos], 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> getAvailableCredentialTypes() async {
	try {
		final response = await HttpClient()
				.get('credentials/schema')
				.timeout(const Duration(seconds: 10));

		if (response.statusCode == 200) {
			final data = jsonDecode(response.body);
			return {'data': data, 'error': null};
		}

		if (response.statusCode == 401) {
			return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
		}

		return {
			'data': null,
			'error': 'Error al obtener tipos de credencial: ${response.statusCode}',
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
			'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
		};
	} catch (e) {
		return {
			'data': null,
			'error': 'Error inesperado al obtener tipos de credencial',
		};
	}
}

/// Crea una credencial.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> createCredential({
	required String name,
	required String type,
	required Map<String, dynamic> data,
	bool? isResolvable,
}) async {
	try {
		final payload = <String, dynamic>{
			'name': name,
			'type': type,
			'data': data,
			if (isResolvable != null) 'isResolvable': isResolvable,
		};

		debugPrint('📡 createCredential - Payload enviado a n8n:');
		debugPrint(payload.toString());

		final response = await HttpClient()
				.post('credentials', body: payload)
				.timeout(const Duration(seconds: 10));

		if (response.statusCode == 200 || response.statusCode == 201) {
			debugPrint('✅ Credencial creada exitosamente');
			return {'data': jsonDecode(response.body), 'error': null};
		}

		if (response.statusCode == 400) {
			debugPrint('❌ Error 400: ${response.body}');
			try {
				final errorData = jsonDecode(response.body) as Map<String, dynamic>;
				final message = errorData['message'] ?? 'Datos inválidos para crear credencial';
				return {'data': null, 'error': message};
			} catch (_) {
				return {'data': null, 'error': 'Datos inválidos para crear credencial'};
			}
		}

		if (response.statusCode == 401) {
			return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
		}

		if (response.statusCode == 415) {
			return {'data': null, 'error': 'Formato de contenido no soportado'};
		}

		return {
			'data': null,
			'error': 'Error al crear credencial: ${response.statusCode}',
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
			'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
		};
	} catch (e) {
		return {'data': null, 'error': 'Error inesperado al crear credencial'};
	}
}

/// Actualiza una credencial por ID.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...}, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> updateCredential(
	String id, {
	String? name,
	String? type,
	Map<String, dynamic>? data,
	bool? isGlobal,
	bool? isResolvable,
	bool? isPartialData,
}) async {
	try {
		final payload = <String, dynamic>{
			if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
			if (type != null && type.trim().isNotEmpty) 'type': type.trim(),
			if (data != null) 'data': data,
			if (isGlobal != null) 'isGlobal': isGlobal,
			if (isResolvable != null) 'isResolvable': isResolvable,
			if (isPartialData != null) 'isPartialData': isPartialData,
		};

		final response = await HttpClient()
				.patch('credentials/$id', body: payload)
				.timeout(const Duration(seconds: 10));

		if (response.statusCode == 200) {
			return {'data': jsonDecode(response.body), 'error': null};
		}

		if (response.statusCode == 400) {
			return {'data': null, 'error': 'Datos inválidos para actualizar credencial'};
		}

		if (response.statusCode == 401) {
			return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
		}

		if (response.statusCode == 404) {
			return {'data': null, 'error': 'Credencial no encontrada'};
		}

		return {
			'data': null,
			'error': 'Error al actualizar credencial: ${response.statusCode}',
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
			'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
		};
	} catch (e) {
		return {
			'data': null,
			'error': 'Error inesperado al actualizar credencial',
		};
	}
}

/// Elimina una credencial por ID.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': {...} | null, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> deleteCredential(String id) async {
	try {
		final response = await HttpClient()
				.delete('credentials/$id')
				.timeout(const Duration(seconds: 10));

		if (response.statusCode == 200 || response.statusCode == 204) {
			return {
				'data': response.body.isNotEmpty ? jsonDecode(response.body) : null,
				'error': null,
			};
		}

		if (response.statusCode == 401) {
			return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
		}

		if (response.statusCode == 404) {
			return {'data': null, 'error': 'Credencial no encontrada'};
		}

		return {
			'data': null,
			'error': 'Error al eliminar credencial: ${response.statusCode}',
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
			'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
		};
	} catch (e) {
		return {'data': null, 'error': 'Error inesperado al eliminar credencial'};
	}
}

/// Transfiere una credencial a otro proyecto.
/// Retorna un Map con 'data' y 'error'
/// Si es exitoso: {'data': null, 'error': null}
/// Si hay error: {'data': null, 'error': 'mensaje de error'}
Future<Map<String, dynamic>> transferCredential(
	String id,
	String destinationProjectId,
) async {
	try {
		final response = await HttpClient()
				.put(
					'credentials/$id/transfer',
					body: {'destinationProjectId': destinationProjectId},
				)
				.timeout(const Duration(seconds: 10));

		if (response.statusCode == 200 || response.statusCode == 204) {
			return {'data': null, 'error': null};
		}

		if (response.statusCode == 400) {
			return {
				'data': null,
				'error': 'Solicitud inválida. Revisa el proyecto destino',
			};
		}

		if (response.statusCode == 401) {
			return {'data': null, 'error': 'No autorizado. Verifica tu API key'};
		}

		if (response.statusCode == 404) {
			return {'data': null, 'error': 'Credencial o proyecto no encontrado'};
		}

		return {
			'data': null,
			'error': 'Error al transferir credencial: ${response.statusCode}',
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
			'error': 'No se pudo conectar al servidor. Verifica tu conexión a Internet.',
		};
	} catch (e) {
		return {'data': null, 'error': 'Error inesperado al transferir credencial'};
	}
}
