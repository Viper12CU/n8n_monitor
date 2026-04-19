import 'package:flutter/foundation.dart';
import 'package:n8n_monitor/api/credencials.dart';

/// Valida los tipos de credenciales contra los tipos disponibles en n8n
class CredentialValidator {
  static final CredentialValidator _instance = CredentialValidator._internal();

  factory CredentialValidator() {
    return _instance;
  }

  CredentialValidator._internal();

  List<String>? _cachedValidTypes;

  /// Obtiene los tipos válidos de credenciales desde n8n
  Future<List<String>> getValidTypes() async {
    if (_cachedValidTypes != null) {
      return _cachedValidTypes!;
    }

    final response = await getAvailableCredentialTypes();

    if (response['error'] != null) {
      debugPrint('Error fetching credential types: ${response['error']}');
      return [];
    }

    try {
      final data = response['data'];
      if (data is List) {
        _cachedValidTypes = data.map((e) {
          if (e is Map && e.containsKey('name')) {
            return (e['name'] as String);
          }
          return e.toString();
        }).toList();
        return _cachedValidTypes!;
      }
    } catch (e) {
      debugPrint('Error parsing credential types: $e');
    }

    return [];
  }

  /// Valida si un tipo de credencial es válido
  Future<bool> isValidType(String type) async {
    final validTypes = await getValidTypes();
    return validTypes.contains(type);
  }

  /// Obtiene tipos similares (útil para sugerencias)
  Future<List<String>> getSimilarTypes(String type) async {
    final validTypes = await getValidTypes();
    final query = type.toLowerCase();
    return validTypes.where((t) => t.toLowerCase().contains(query)).toList();
  }

  /// Limpia el cache de tipos (llamar cuando cambies de servidor)
  void clearCache() {
    _cachedValidTypes = null;
  }

  /// Obtiene un reporte de diagnóstico
  Future<String> getDiagnosticReport(String attemptedType) async {
    final validTypes = await getValidTypes();
    final similar = await getSimilarTypes(attemptedType);

    final buffer = StringBuffer();
    buffer.writeln('=== CREDENTIAL TYPE DIAGNOSTIC ===');
    buffer.writeln('Attempted Type: $attemptedType');
    buffer.writeln('Valid Types Count: ${validTypes.length}');
    buffer.writeln('');

    if (similar.isNotEmpty) {
      buffer.writeln('Similar Types Found:');
      for (final type in similar) {
        buffer.writeln('  - $type');
      }
    } else {
      buffer.writeln('No similar types found.');
      buffer.writeln('');
      buffer.writeln('First 20 Valid Types:');
      for (final type in validTypes.take(20)) {
        buffer.writeln('  - $type');
      }
      if (validTypes.length > 20) {
        buffer.writeln('  ... and ${validTypes.length - 20} more');
      }
    }

    return buffer.toString();
  }
}
