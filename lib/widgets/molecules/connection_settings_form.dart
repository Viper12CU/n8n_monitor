import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
import 'package:n8n_monitor/widgets/atoms/custom_form_input_field.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';

class ConnectionSettingsForm extends StatefulWidget {
  final String initialUrl;
  final String initialApiKey;
  final Function(String url, String apiKey)? onSave;

  const ConnectionSettingsForm({
    super.key,
    this.initialUrl = 'https://api.n8n.io',
    this.initialApiKey = 'n8n_api_1234567890abcdef',
    this.onSave,
  });

  @override
  State<ConnectionSettingsForm> createState() => _ConnectionSettingsFormState();
}

class _ConnectionSettingsFormState extends State<ConnectionSettingsForm> {
  late TextEditingController _urlController;
  late TextEditingController _apiKeyController;
  late String _originalUrl;
  late String _originalApiKey;

  bool _isModified = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _originalUrl = widget.initialUrl;
    _originalApiKey = widget.initialApiKey;
    _urlController = TextEditingController(text: widget.initialUrl);
    _apiKeyController = TextEditingController(text: widget.initialApiKey);
    _urlController.addListener(_checkIfModified);
    _apiKeyController.addListener(_checkIfModified);
  }

  void _checkIfModified() {
    final hasChanges = _urlController.text != _originalUrl ||
        _apiKeyController.text != _originalApiKey;
    if (hasChanges != _isModified) {
      setState(() {
        _isModified = hasChanges;
      });
    }
  }

  void _handleSave() async {
    if (_isModified && !_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulación de carga
      await Future.delayed(const Duration(seconds: 2));

      // Lógica para guardar los cambios
      print('Guardando cambios...');
      print('URL: ${_urlController.text}');
      print('API Key: ${_apiKeyController.text}');

      if (widget.onSave != null) {
        widget.onSave!(_urlController.text, _apiKeyController.text);
      }

      setState(() {
        _originalUrl = _urlController.text;
        _originalApiKey = _apiKeyController.text;
        _isModified = false;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.0,
      mainAxisSize: MainAxisSize.min,
      children: [
        DividedCard(
          children: [
            CustomFormInputField(
              label: 'URL del servidor',
              icon: Icons.link,
              controller: _urlController,
              keyboardType: TextInputType.url,
              hintText: 'https://tu-servidor.com',
              submitedForm: () {},
            ),
            CustomFormInputField(
              label: 'API Key',
              icon: Icons.key,
              controller: _apiKeyController,
              isPassword: true,
              hintText: 'Tu clave API',
              submitedForm: () {},
            ),
          ],
        ),
        IgnorePointer(
          ignoring: !_isModified || _isLoading,
          child: Opacity(
            opacity: _isModified && !_isLoading ? 1.0 : 0.5,
            child: CustomButton(
              label: 'Comprobar Conexión',
              icon: Icons.electric_bolt_rounded,
              onTap: _handleSave,
              isLoading: _isLoading,
            ),
          ),
        ),
      ],
    );
  }
}
