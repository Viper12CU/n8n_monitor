/// Representa un campo individual en un formulario de credencial
class CredentialField {
  /// Identificador unico del campo (clave interna)
  /// Ejemplo: 'clientId', 'apiKey', 'host', 'password'
  final String name;

  /// Etiqueta para mostrar en la UI
  /// Ejemplo: 'Client ID', 'API Key', 'Host', 'Contrasena'
  final String label;

  /// Tipo de input para validacion y renderizado
  /// Valores posibles: 'text', 'password', 'email', 'number', 'url', 'boolean', 'select'
  final String fieldType;

  /// Indica si el campo es obligatorio
  final bool required;

  /// Texto placeholder para el input
  final String? placeholder;

  /// Descripcion o ayuda para el usuario
  final String? description;

  /// Icono asociado al campo (vacio por ahora, para futuro uso)
  final String? icon;

  /// Opciones para campos de tipo 'select'
  final List<String>? options;

  /// Valor por defecto del campo
  final String? defaultValue;

  CredentialField({
    required this.name,
    required this.label,
    required this.fieldType,
    required this.required,
    this.placeholder,
    this.description,
    this.icon = '',
    this.options,
    this.defaultValue,
  });

  /// Convierte el campo a un mapa (util para serializacion)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'label': label,
      'fieldType': fieldType,
      'required': required,
      'placeholder': placeholder,
      'description': description,
      'icon': icon,
      'options': options,
      'defaultValue': defaultValue,
    };
  }

  @override
  String toString() => 'CredentialField(name: $name, label: $label, fieldType: $fieldType)';
}
