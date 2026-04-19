import 'credentials_map.dart';
import 'models/credential_field.dart';
import 'models/credential_info.dart';

/// Helper para obtener la estructura del formulario de una credencial
class CredentialFormHelper {
  const CredentialFormHelper();

  /// Devuelve la informacion completa de la credencial por id
  CredentialInfo? getCredentialInfo(String id) {
    return credentialsMap[id];
  }

  /// Devuelve la lista de campos para construir el formulario
  List<CredentialField> getCredentialFields(String id) {
    return credentialsMap[id]?.fields ?? <CredentialField>[];
  }

  /// Devuelve campos requeridos del formulario
  List<CredentialField> getRequiredFields(String id) {
    return credentialsMap[id]?.getRequiredFields() ?? <CredentialField>[];
  }

  /// Devuelve campos opcionales del formulario
  List<CredentialField> getOptionalFields(String id) {
    return credentialsMap[id]?.getOptionalFields() ?? <CredentialField>[];
  }

  /// Busca por tipo de credencial n8n y devuelve el primer match
  CredentialInfo? getByType(String type) {
    for (final entry in credentialsMap.values) {
      if (entry.type == type) {
        return entry;
      }
    }
    return null;
  }
}
