import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:n8n_monitor/api/http_client.dart';


/// Realiza una auditoría de seguridad
/// 
/// [auditData] Datos de la auditoría a enviar al servidor (opcional)
/// Retorna un Map con 'data' y 'error'
Future<Map<String, dynamic>> performSecurityAudit([Map<String, dynamic>? auditData]) async {
  try {
    final response = await HttpClient().post(
      'audit',
      body: auditData,
    ).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200 ) {
      return {
        'data': jsonDecode(response.body),
        'error': null,
      };
    }

  
    if (response.statusCode == 401) {
      return {
        'data': null,
        'error': 'No tienes permisos para realizar esta auditoría',
      };
    }

    return {
      'data': null,
      'error': 'Error al realizar la auditoría: ${response.statusCode}',
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
      'error': 'Error inesperado al realizar la auditoría: $e',
    };
  }
}
