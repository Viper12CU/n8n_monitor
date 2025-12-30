import 'package:flutter/material.dart';
import 'package:n8n_monitor/provider/initial_conf_form_provider.dart';
import 'package:n8n_monitor/widgets/atoms/custom_form_input_field.dart';
import 'package:provider/provider.dart';

class ApiConfFormGroyp extends StatelessWidget {
  const ApiConfFormGroyp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InitialConfFormProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 10.0,
      children: [
        CustomFormInputField(
          submitedForm: () {
            provider.submitForm(context);
          },
          label: 'URL de n8n',
          icon: Icons.link,
          hintText: 'https://tu-instancia.n8n.io',
          controller: provider.urlController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa una URL';
            }
            return null;
          },
        ),

        CustomFormInputField(
          submitedForm: () {
            provider.submitForm(context);
          },
          label: 'API Key',
          icon: Icons.key,
          isPassword: true,
          controller: provider.apiKeyController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa una API key';
            }
            return null;
          },
        ),
      ],
    );
  }
}
