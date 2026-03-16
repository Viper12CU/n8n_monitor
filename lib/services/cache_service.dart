import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _auditCacheKey = 'audit_cache';
  static const String _auditDateKey = 'audit_cache_date';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  /// Guarda el resultado de la auditoría en caché
  Future<void> saveAuditData(
    Map<String, dynamic> auditJson, {
    DateTime? auditDate,
  }) async {
    final prefs = await _prefs;
    await prefs.setString(_auditCacheKey, json.encode(auditJson));
    await prefs.setString(
      _auditDateKey,
      (auditDate ?? DateTime.now()).toIso8601String(),
    );
  }

  /// Carga el resultado de la última auditoría del caché
  Future<Map<String, dynamic>?> getAuditData() async {
    final prefs = await _prefs;
    final data = prefs.getString(_auditCacheKey);
    if (data == null) return null;
    return json.decode(data) as Map<String, dynamic>;
  }

  /// Devuelve la fecha de la última auditoría guardada en caché
  Future<DateTime?> getAuditDate() async {
    final prefs = await _prefs;
    final dateString = prefs.getString(_auditDateKey);
    if (dateString == null) return null;
    return DateTime.tryParse(dateString);
  }

  /// Elimina los datos de auditoría del caché
  Future<void> clearAuditData() async {
    final prefs = await _prefs;
    await prefs.remove(_auditCacheKey);
    await prefs.remove(_auditDateKey);
  }
}
