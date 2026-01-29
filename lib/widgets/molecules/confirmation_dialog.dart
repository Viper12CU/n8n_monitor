import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';
import 'package:n8n_monitor/widgets/atoms/custom_form_input_field.dart';

class ConfirmationDialog extends StatefulWidget {
  final String title;
  final String? message;
  final bool showNameField;
  final bool showDescriptionField;
  final bool showVersionIdField;
  final String? initialName;
  final String? initialDescription;
  final String? initialVersionId;
  final Function(Map<String, dynamic> data) onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    required this.title,
    this.message,
    this.showNameField = false,
    this.showDescriptionField = false,
    this.showVersionIdField = false,
    this.initialName,
    this.initialDescription,
    this.initialVersionId,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();

  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    required String title,
    String? message,
    bool showNameField = false,
    bool showDescriptionField = false,
    bool showVersionIdField = false,
    String? initialName,
    String? initialDescription,
    String? initialVersionId,
  }) {
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        message: message,
        showNameField: showNameField,
        showDescriptionField: showDescriptionField,
        showVersionIdField: showVersionIdField,
        initialName: initialName,
        initialDescription: initialDescription,
        initialVersionId: initialVersionId,
        onConfirm: (data) => Navigator.of(context).pop(data),
        onCancel: () => Navigator.of(context).pop(null),
      ),
    );
  }
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController versionIdController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    descriptionController = TextEditingController(text: widget.initialDescription);
    versionIdController = TextEditingController(text: widget.initialVersionId);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    versionIdController.dispose();
    super.dispose();
  }

  void handleConfirm() {
    final data = <String, dynamic>{
      'status': "confirmed",  
      'field_data': {
         if (widget.showNameField) 'name': nameController.text.isEmpty ? null : nameController.text,
      if (widget.showDescriptionField) 'description': descriptionController.text.isEmpty ? null : descriptionController.text,
      if (widget.showVersionIdField) 'versionId': versionIdController.text.isEmpty ? null : versionIdController.text,
      },
     
    };
    widget.onConfirm(data);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xFF27352d), width: 1.5),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            
            if (widget.message != null) ...[
              SizedBox(height: 12),
              Text(
                widget.message!,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x99FFFFFF),
                ),
                textAlign: TextAlign.center,
              ),
            ],

            SizedBox(height: 24),

            // Campos opcionales
            if (widget.showNameField) ...[
              CustomFormInputField(
                label: 'Nombre',
                icon: Icons.label_outline,
                controller: nameController,
                hintText: 'Ingresa el nombre',
                submitedForm: handleConfirm,
              ),
              SizedBox(height: 16),
            ],

            if (widget.showDescriptionField) ...[
              CustomFormInputField(
                label: 'Descripción',
                icon: Icons.description_outlined,
                controller: descriptionController,
                hintText: 'Ingresa una descripción',
                keyboardType: TextInputType.multiline,
                submitedForm: handleConfirm,
              ),
              SizedBox(height: 16),
            ],

            if (widget.showVersionIdField) ...[
              CustomFormInputField(
                label: 'ID de Versión',
                icon: Icons.numbers_outlined,
                controller: versionIdController,
                hintText: 'Ingresa el ID de versión',
                submitedForm: handleConfirm,
              ),
              SizedBox(height: 16),
            ],

            SizedBox(height: 8),

            // Botones de acción
            Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomButton(
                  label: 'Confirmar',
                  icon: Icons.check,
                  onTap: handleConfirm,
                ),
                GestureDetector(
                  onTap: widget.onCancel,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF1e2724),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color(0xFF3c5044),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Color(0xCCFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
