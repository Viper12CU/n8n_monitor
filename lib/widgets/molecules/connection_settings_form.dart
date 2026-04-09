import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
import 'package:n8n_monitor/widgets/atoms/custom_form_input_field.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';

class ConnectionSettingsForm extends StatefulWidget {
  final String initialLabel;
  final String initialUrl;
  final String initialApiKey;
  final bool initialHasExpirationDate;
  final DateTime? initialExpirationDate;
  final Future<void> Function(
    String label,
    String url,
    String apiKey,
    bool hasExpirationDate,
    DateTime? expirationDate,
  )? onSave;

  const ConnectionSettingsForm({
    super.key,
    this.initialLabel = '',
    this.initialUrl = '',
    this.initialApiKey = '',
    this.initialHasExpirationDate = false,
    this.initialExpirationDate,
    this.onSave,
  });

  @override
  State<ConnectionSettingsForm> createState() => _ConnectionSettingsFormState();
}

class _ConnectionSettingsFormState extends State<ConnectionSettingsForm> {
  late TextEditingController _urlController;
  late TextEditingController _apiKeyController;
  late TextEditingController _labelController;
  late TextEditingController _expirationDateController;
  bool _isLoading = false;
  late bool _hasExpirationDate;
  DateTime? _selectedExpirationDate;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.initialLabel);
    _urlController = TextEditingController(text: widget.initialUrl);
    _apiKeyController = TextEditingController(text: widget.initialApiKey);
    _hasExpirationDate = widget.initialHasExpirationDate;
    _selectedExpirationDate = widget.initialExpirationDate;
    _expirationDateController = TextEditingController(
      text: _selectedExpirationDate != null
          ? _formatDate(_selectedExpirationDate!)
          : '',
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedExpirationDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedExpirationDate) {
      setState(() {
        _selectedExpirationDate = picked;
        _expirationDateController.text = _formatDate(picked);
      });
    }
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
          _hasExpirationDate,
          _selectedExpirationDate,
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
    _expirationDateController.dispose();
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
            // Checkbox para fecha de expiración
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: const Text(
                  'La API Key tiene fecha de expiración',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                value: _hasExpirationDate,
                onChanged: (bool? value) {
                  setState(() {
                    _hasExpirationDate = value ?? false;
                    if (!_hasExpirationDate) {
                      _selectedExpirationDate = null;
                      _expirationDateController.clear();
                    }
                  });
                },
                checkColor: const Color(0xFF35d374),
                activeColor: const Color(0xFF35d374),
              ),
            ),
            // Input de fecha - solo visible si tiene expiración
            if (_hasExpirationDate)
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: CustomFormInputField(
                    label: 'Fecha de expiración',
                    icon: Icons.calendar_today_outlined,
                    controller: _expirationDateController,
                    hintText: 'YYYY-MM-DD',
                    submitedForm: () {},
                  ),
                ),
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
