import 'credential_field.dart';

/// Informacion completa de una credencial para mostrar en formularios
class CredentialInfo {
  /// ID unico de la credencial
  /// Ejemplo: 'spotify', 'gmail', 'postgresql', 'slack'
  final String id;

  /// Nombre mostrado en la UI
  /// Ejemplo: 'Spotify', 'Gmail', 'PostgreSQL', 'Slack'
  final String name;

  /// Tipo de credencial usado por n8n API
  /// Ejemplo: 'spotifyApi', 'gmailApi', 'postgres', 'slackApi'
  final String type;

  /// Descripcion corta de la credencial
  /// Ejemplo: 'Conecta con tu cuenta de Spotify'
  final String description;

  /// Campos del formulario que el usuario debe rellenar
  final List<CredentialField> fields;

  /// Icono asociado (vacio por ahora, para futuro uso)
  final String? icon;

  /// URL de documentación (opcional)
  final String? docUrl;

  /// Categoria de la credencial
  /// Ejemplos: 'Musica', 'Email', 'Base de Datos', 'Chat', 'CRM'
  final String? category;

  CredentialInfo({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.fields,
    this.icon = '',
    this.docUrl,
    this.category,
  });

  /// Obtiene todos los campos requeridos
  List<CredentialField> getRequiredFields() {
    return fields.where((field) => field.required).toList();
  }

  /// Obtiene todos los campos opcionales
  List<CredentialField> getOptionalFields() {
    return fields.where((field) => !field.required).toList();
  }

  /// Busca un campo por nombre
  CredentialField? getFieldByName(String fieldName) {
    try {
      return fields.firstWhere((field) => field.name == fieldName);
    } catch (e) {
      return null;
    }
  }

  /// Convierte la credencial a un mapa (util para serializacion)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'fields': fields.map((f) => f.toMap()).toList(),
      'icon': icon,
      'docUrl': docUrl,
      'category': category,
    };
  }

  @override
  String toString() => 'CredentialInfo(id: $id, name: $name, type: $type, fields: ${fields.length})';
}
