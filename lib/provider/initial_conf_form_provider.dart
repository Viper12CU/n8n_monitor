import 'package:flutter/material.dart';

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
        String url = urlController.text;
        String apiKey = apiKeyController.text;

        await Future.delayed(const Duration(seconds: 6));

        debugPrint("URL: $url");
        debugPrint("API Key: $apiKey");

        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/homePage');
        }
      } else {
        throw ErrorDescription("Error en el Login");
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      _loadingSendData = false;
      notifyListeners();

      urlController.clear();
      apiKeyController.clear();
    }
  }
}
