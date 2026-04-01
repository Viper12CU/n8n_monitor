import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
import 'package:n8n_monitor/widgets/atoms/custom_form_input_field.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';

class ConnectionSettingsForm extends StatefulWidget {
  final String initialLabel;
  final String initialUrl;
  final String initialApiKey;
  final Future<void> Function(String label, String url, String apiKey)? onSave;

  const ConnectionSettingsForm({
    super.key,
    this.initialLabel = '',
    this.initialUrl = '',
    this.initialApiKey = '',
    this.onSave,
  });

  @override
  State<ConnectionSettingsForm> createState() => _ConnectionSettingsFormState();
}

class _ConnectionSettingsFormState extends State<ConnectionSettingsForm> {
  late TextEditingController _urlController;
  late TextEditingController _apiKeyController;
  late TextEditingController _labelController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.initialLabel);
    _urlController = TextEditingController(text: widget.initialUrl);
    _apiKeyController = TextEditingController(text: widget.initialApiKey);
  }

  void _handleSave() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      if (widget.onSave != null) {
        await widget.onSave!(
          _labelController.text,
          _urlController.text,
          _apiKeyController.text,
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
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
              label: 'Label',
              icon: Icons.label_outline,
              controller: _labelController,
              hintText: 'Servidor principal',
              submitedForm: () {},
            ),
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
          ignoring: _isLoading,
          child: Opacity(
            opacity: _isLoading ? 0.5 : 1.0,
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
