import 'package:flutter/foundation.dart';
import 'package:n8n_monitor/services/notification_services.dart';
import 'package:n8n_monitor/services/server_credentials_service.dart';
import 'package:worker_manager/worker_manager.dart';

class BackgroundTaskService {
  static final NotificationServices _notificationServices =
      NotificationServices();

  static DateTime? _targetDate;

  /// Inicia la verificación de fecha (ejecutar en segundo plano)
  static Future<void> startDateCheck() async {
    await _notificationServices.init();

    // Obtener credencial activa de la BD
    final activeCredential = await ServerCredentialsService.instance.getInUse();

    if (activeCredential == null) {
      debugPrint('❌ No hay credencial activa');
      return;
    }

    if (!activeCredential.hasExpirationDate ||
        activeCredential.apiKeyExpirationDate == null) {
      debugPrint('❌ La API key activa no tiene fecha de expiración');
      return;
    }

    _targetDate = activeCredential.apiKeyExpirationDate;
    debugPrint('📅 Fecha objetivo (exppiración API key): $_targetDate');

    while (true) {
      final result = await workerManager.executeGentle(
        (s) => _dateCheckTask(_targetDate!),
      );

      // Si retorna true, muestra notificación
      if (result == true) {
        await _notificationServices.showNotification(
          title: '⏰ Aviso: API Key Expirando',
          body: 'Faltan 2 días para que expire tu API key',
        );
        break;
      }

      await Future.delayed(const Duration(seconds: 10)); // Verificar cada 10 segundos
    }
  }
}

/// Función que se ejecuta en el worker (retorna bool)
Future<bool> _dateCheckTask(DateTime targetDate) async {
  final now = DateTime.now();
  final daysLeft = targetDate.difference(now).inDays;

  debugPrint('🕐 Ahora: $now');
  debugPrint('⏱️ Días restantes: $daysLeft');

  // Si faltan exactamente 2 días
  if (daysLeft == 2) {
    debugPrint('✅ ¡Faltan 2 días! Disparando notificación');
    return true;
  }

  // Si pasó la fecha
  if (now.isAfter(targetDate)) {
    debugPrint('❌ API key ya expiró');
    return false;
  }

  return false;
}
