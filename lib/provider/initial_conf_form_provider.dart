import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/http_client.dart';
import 'package:n8n_monitor/services/server_credentials_service.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/utils/enums.dart';

class InitialConfFormProvider extends ChangeNotifier {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loadingSendData = false;

  TextEditingController get urlController => _urlController;
  TextEditingController get apiKeyController => _apiKeyController;
  GlobalKey<FormState> get formKey => _formKey;

  bool get loadingSendData => _loadingSendData;

  Future<void> submitForm(BuildContext context) async {
    if (_loadingSendData) return;

    _loadingSendData = true;
    notifyListeners();

    try {
      if (formKey.currentState!.validate()) {
        String url = urlController.text.trim();
        String apiKey = apiKeyController.text.trim();

        // Probar la conexión antes de guardar
        final isConnected = await HttpClient.testConnection(
          baseUrl: url,
          apiKey: apiKey,
        );

        if (!isConnected) {
          throw ErrorDescription("Error en al probar conexión");
        }

        // Si la conexión es exitosa, guardar en SQLite y marcar como activa
        await ServerCredentialsService.instance.insertCredential(
          label: url,
          url: url,
          apiKey: apiKey,
          inUse: true,
        );

        if (context.mounted) {
          CustomSnackbar.show(
            context: context,
            message: 'Conexión exitosa',
            type: SnackbarType.success,
          );

          Navigator.pushReplacementNamed(context, '/homePage');
        }
      } else {
        throw ErrorDescription("Error al validar");
      }
    } catch (e) {
      debugPrint("ERROR: $e");
      if (context.mounted) {
        CustomSnackbar.show(
          context: context,
          message: 'Error de conexión. Verifica la URL y API key',
          type: SnackbarType.error,
        );
      }
    } finally {
      _loadingSendData = false;
      notifyListeners();
    }
  }
}
