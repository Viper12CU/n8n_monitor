import 'package:flutter/material.dart';
import 'package:n8n_monitor/services/server_credentials_service.dart';

class ServerStatsProvider extends ChangeNotifier {
  ServerCredential? _activeServer;
  List<ServerCredential> _allCredentials = [];
  bool _isLoading = false;

  ServerCredential? get activeServer => _activeServer;
  List<ServerCredential> get allCredentials => _allCredentials;
  bool get isLoading => _isLoading;

  // Estadísticas calculadas
  int get totalCredentials => _allCredentials.length;

  int get expiringIn30Days => _allCredentials
      .where((cred) {
        if (!cred.hasExpirationDate || cred.apiKeyExpirationDate == null) {
          return false;
        }
        final daysLeft =
            cred.apiKeyExpirationDate!.difference(DateTime.now()).inDays;
        return daysLeft > 0 && daysLeft <= 30;
      })
      .length;

  int get expiringIn7Days => _allCredentials
      .where((cred) {
        if (!cred.hasExpirationDate || cred.apiKeyExpirationDate == null) {
          return false;
        }
        final daysLeft =
            cred.apiKeyExpirationDate!.difference(DateTime.now()).inDays;
        return daysLeft > 0 && daysLeft <= 7;
      })
      .length;

  int get alreadyExpired => _allCredentials
      .where((cred) {
        if (!cred.hasExpirationDate || cred.apiKeyExpirationDate == null) {
          return false;
        }
        return DateTime.now().isAfter(cred.apiKeyExpirationDate!);
      })
      .length;

  int get daysUntilActiveExpires {
    if (_activeServer?.hasExpirationDate == true &&
        _activeServer?.apiKeyExpirationDate != null) {
      final daysLeft = _activeServer!.apiKeyExpirationDate!
          .difference(DateTime.now())
          .inDays;
      return daysLeft;
    }
    return -1; // Sin fecha de expiración
  }

  /// Cargar estadísticas desde BD
  Future<void> loadStats() async {
    _isLoading = true;
    notifyListeners();

    try {
      final active = await ServerCredentialsService.instance.getInUse();
      final all = await ServerCredentialsService.instance.getAll();

      _activeServer = active;
      _allCredentials = all;
    } catch (e) {
      print('Error cargando estadísticas: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Recargar estadísticas
  Future<void> refresh() async {
    await loadStats();
  }
}
