import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';
import 'package:n8n_monitor/widgets/atoms/custom_form_input_field.dart';

class TagsCreateForm extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCreate;
  final bool isCreating;

  const TagsCreateForm({
    super.key,
    required this.controller,
    required this.onCreate,
    required this.isCreating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF27352d), width: 1.5),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        spacing: 14,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomFormInputField(
            label: 'Nombre de la etiqueta',
            icon: Icons.label_outline,
            controller: controller,
            hintText: 'Ej: Production',
            submitedForm: onCreate,
          ),
          CustomButton(
            label: 'Crear nueva tag',
            icon: Icons.add,
            onTap: onCreate,
            isLoading: isCreating,
          ),
        ],
      ),
    );
  }
}
