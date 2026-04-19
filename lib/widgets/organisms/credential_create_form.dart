import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/credential_form_helper.dart';
import 'package:n8n_monitor/utils/credentials_map.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/api/credencials.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';
import 'package:n8n_monitor/widgets/atoms/custom_form_input_field.dart';
import 'package:n8n_monitor/widgets/atoms/custom_group_category.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/molecules/credential_boolean_field.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
import 'package:n8n_monitor/utils/models/credential_field.dart';
import 'package:n8n_monitor/utils/models/credential_info.dart';

class CredentialCreateForm extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>>? onSubmit;

  const CredentialCreateForm({
    super.key,
    this.onSubmit,
  });

  @override
  State<CredentialCreateForm> createState() => _CredentialCreateFormState();
}

class _CredentialCreateFormState extends State<CredentialCreateForm> {
  // Constantes de UI
  static const double _borderRadius = 18.0;
  static const double _borderWidth = 1.5;
  static const double _focusBorderWidth = 2.0;
  static const Color _borderColor = Color(0xFF3c5044);
  static const Color _labelColor = Color(0xFF9eb7a8);
  static const double _contentPadding = 16.0;
  static const Duration _focusDelay = Duration(milliseconds: 100);

  // Mapas para field types
  static final Map<String, IconData> _fieldIcons = {
    'password': Icons.key,
    'email': Icons.email_outlined,
    'url': Icons.link,
    'number': Icons.numbers,
    'json': Icons.data_object_rounded,
  };

  static final Map<String, TextInputType> _fieldKeyboards = {
    'email': TextInputType.emailAddress,
    'url': TextInputType.url,
    'number': TextInputType.number,
    'json': TextInputType.multiline,
  };

  // Controllers
  final _formKey = GlobalKey<FormState>();
  final _formHelper = const CredentialFormHelper();
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, ValueNotifier<bool>> _boolControllers = {};
  final TextEditingController _credentialNameController = TextEditingController();
  final FocusNode _credentialNameFocus = FocusNode();

  // State
  String? _selectedId;
  bool _isSubmitting = false;
  bool _isEditingName = false;

  @override
  void dispose() {
    _disposeControllers();
    _credentialNameController.dispose();
    _credentialNameFocus.dispose();
    super.dispose();
  }

  void _disposeControllers() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    for (final controller in _boolControllers.values) {
      controller.dispose();
    }
    _textControllers.clear();
    _boolControllers.clear();
  }

  void _onCredentialChanged(String? id) {
    if (id == null) return;
    setState(() {
      _selectedId = id;
      _setupControllers();
      _setDefaultCredentialName();
      _isEditingName = false;
    });
  }

  void _setDefaultCredentialName() {
    final info = _selectedInfo;
    if (info == null) return;
    _credentialNameController.text = '${info.name} - new credencial';
  }

  void _setupControllers() {
    _disposeControllers();
    final info = _selectedInfo;
    if (info == null) return;

    for (final field in info.fields) {
      if (field.fieldType == 'boolean') {
        _boolControllers[field.name] = ValueNotifier<bool>(_parseBoolValue(field));
      } else {
        _textControllers[field.name] = TextEditingController(
          text: field.defaultValue ?? '',
        );
      }
    }
  }

  bool _parseBoolValue(CredentialField field) {
    final raw = (field.defaultValue ?? field.placeholder ?? '').trim().toLowerCase();
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  CredentialInfo? get _selectedInfo {
    if (_selectedId == null) return null;
    return _formHelper.getCredentialInfo(_selectedId!);
  }

  // Getters para field properties
  IconData _iconForField(CredentialField field) {
    return _fieldIcons[field.fieldType] ?? Icons.text_fields;
  }

  TextInputType _keyboardTypeForField(CredentialField field) {
    return _fieldKeyboards[field.fieldType] ?? TextInputType.text;
  }

  // Helpers
  InputDecoration _buildInputDecoration({
    String? labelText,
    String? hintText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
    Color? iconColor,
  }) {
    iconColor ??= Theme.of(context).iconTheme.color ?? _labelColor;
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: _labelColor),
      hintText: hintText,
      hintStyle: TextStyle(color: iconColor),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: iconColor) : null,
      suffixIcon: suffixIcon != null
          ? GestureDetector(
              onTap: onSuffixTap,
              child: Icon(suffixIcon, color: iconColor),
            )
          : null,
      filled: true,
      fillColor: Theme.of(context).cardTheme.color,
      border: _buildInputBorder(),
      enabledBorder: _buildInputBorder(),
      focusedBorder: _buildInputBorder(
        color: Theme.of(context).colorScheme.primary,
        width: _focusBorderWidth,
      ),
      errorBorder: _buildInputBorder(color: Colors.red.shade400),
      focusedErrorBorder: _buildInputBorder(
        color: Colors.red.shade400,
        width: _focusBorderWidth,
      ),
      disabledBorder: _buildInputBorder(color: const Color(0xFF374a3e)),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: _contentPadding,
        vertical: _contentPadding,
      ),
    );
  }

  OutlineInputBorder _buildInputBorder({
    Color? color,
    double? width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide(
        color: color ?? _borderColor,
        width: width ?? _borderWidth,
      ),
    );
  }

  // Handlers
  Future<void> _handleSubmit() async {
    if (_selectedInfo == null) {
      CustomSnackbar.show(
        context: context,
        message: 'Selecciona un tipo de credencial',
        type: SnackbarType.info,
      );
      return;
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      CustomSnackbar.show(
        context: context,
        message: 'Completa los campos requeridos',
        type: SnackbarType.error,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final data = <String, dynamic>{};
    for (final field in _selectedInfo!.fields) {
      if (field.fieldType == 'boolean') {
        data[field.name] = _boolControllers[field.name]?.value ?? false;
      } else {
        data[field.name] = _textControllers[field.name]?.text.trim() ?? '';
      }
    }

    final payload = <String, dynamic>{
      'id': _selectedInfo!.id,
      'type': _selectedInfo!.type,
      'name': _credentialNameController.text.trim().isEmpty
          ? '${_selectedInfo!.name} - new credencial'
          : _credentialNameController.text.trim(),
      'data': data,
    };

    if (widget.onSubmit != null) {
      widget.onSubmit!(payload);
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
      return;
    }

    final response = await createCredential(
      name: payload['name'] as String,
      type: payload['type'] as String,
      data: data,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = false;
    });

    if (response['error'] != null) {
      debugPrint('❌ Error al crear credencial: ${response['error']}');
      CustomSnackbar.show(
        context: context,
        message: response['error'],
        type: SnackbarType.error,
      );
      return;
    }

    CustomSnackbar.show(
      context: context,
      message: 'Credencial creada correctamente',
      type: SnackbarType.success,
    );
    debugPrint('✅ Credencial creada exitosamente');
    _setDefaultCredentialName();
  }

  Widget _buildFields(CredentialInfo info) {
    if (info.fields.isEmpty) {
      return const Text(
        'Esta credencial no requiere campos adicionales.',
        style: TextStyle(color: Color(0xFF9eb7a8)),
      );
    }

    return Column(
      spacing: 12.0,
      children: info.fields.map((field) {
        if (field.fieldType == 'boolean') {
          final controller = _boolControllers[field.name] ?? ValueNotifier<bool>(false);
          _boolControllers[field.name] = controller;
          return CredentialBooleanField(
            label: field.required ? '${field.label} *' : field.label,
            description: field.description,
            controller: controller,
            onChanged: (value) {
              controller.value = value;
            },
          );
        }

        final controller = _textControllers[field.name] ?? TextEditingController();
        _textControllers[field.name] = controller;

        return CustomFormInputField(
          label: field.required ? '${field.label} *' : field.label,
          icon: _iconForField(field),
          controller: controller,
          isPassword: field.fieldType == 'password',
          keyboardType: _keyboardTypeForField(field),
          hintText: field.placeholder,
          validator: (value) {
            if (field.required && (value == null || value.trim().isEmpty)) {
              return 'Campo requerido';
            }
            return null;
          },
          submitedForm: _handleSubmit,
        );
      }).toList(),
    );
  }

  // Builders para nombre de credencial
  Widget _buildCredentialNameField() {
    return _isEditingName ? _buildNameFieldEdit() : _buildNameFieldDisplay();
  }

  Widget _buildNameFieldEdit() {
    final iconColor = Theme.of(context).iconTheme.color ?? _labelColor;
    return TextFormField(
      controller: _credentialNameController,
      focusNode: _credentialNameFocus,
      style: const TextStyle(color: Colors.white),
      decoration: _buildInputDecoration(
        labelText: 'Nombre de credencial',
        hintText: 'Ingresa un nombre',
        prefixIcon: Icons.edit_outlined,
        suffixIcon: Icons.close_outlined,
        onSuffixTap: () => setState(() => _isEditingName = false),
        iconColor: iconColor,
      ),
      onEditingComplete: () => setState(() => _isEditingName = false),
      onFieldSubmitted: (_) => setState(() => _isEditingName = false),
    );
  }

  Widget _buildNameFieldDisplay() {
    final iconColor = Theme.of(context).iconTheme.color ?? _labelColor;
    final isEmpty = _credentialNameController.text.trim().isEmpty;

    return GestureDetector(
      onTap: () => setState(() => _isEditingName = true),
      onTapUp: (_) => Future.delayed(_focusDelay, () => _credentialNameFocus.requestFocus()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre de credencial',
            style: TextStyle(
              color: iconColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  isEmpty ? 'Haz clic para añadir un nombre' : _credentialNameController.text,
                  style: TextStyle(
                    color: isEmpty ? Color.fromARGB(153, 158, 183, 168) : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.edit_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final info = _selectedInfo;
    final credentialEntries = credentialsMap.entries.toList()
      ..sort((a, b) => a.value.name.toLowerCase().compareTo(b.value.name.toLowerCase()));

    return Form(
      key: _formKey,
      child: Column(
        spacing: 18.0,
        children: [
          CustomGroupCategory(
            category: 'Tipo de credencial',
            child: DividedCard(
              children: [
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    final query = textEditingValue.text.trim().toLowerCase();
                    final options = credentialEntries.map((entry) => entry.value.name);
                    if (query.isEmpty) {
                      return options;
                    }
                    return options.where((name) => name.toLowerCase().contains(query));
                  },
                  displayStringForOption: (option) => option,
                  onSelected: (selection) {
                    final entry = credentialEntries.firstWhere(
                      (item) => item.value.name == selection,
                    );
                    _onCredentialChanged(entry.key);
                  },
                  fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
                    if (info != null && textController.text != info.name) {
                      textController.text = info.name;
                      textController.selection = TextSelection.fromPosition(
                        TextPosition(offset: textController.text.length),
                      );
                    }

                    final iconColor = Theme.of(context).iconTheme.color ?? const Color(0xFF9eb7a8);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
                          child: Text(
                            'Selecciona una credencial',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: textController,
                          focusNode: focusNode,
                          style: const TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration(
                            hintText: 'Buscar credencial',
                            prefixIcon: Icons.badge_outlined,
                            iconColor: iconColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          if (info != null)
            CustomGroupCategory(
              category: 'Configuracion',
              child: DividedCard(
                children: [
                  _buildCredentialNameField(),
                  _buildFields(info),
                ],
              ),
            ),
          if (info != null)
            CustomButton(
              label: 'Guardar credencial',
              icon: Icons.check_circle_outline_rounded,
              onTap: _handleSubmit,
              isLoading: _isSubmitting,
            ),
        ],
      ),
    );
  }
}
