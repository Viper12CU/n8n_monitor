import 'package:flutter/material.dart';
import 'package:n8n_monitor/provider/initial_conf_form_provider.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';
import 'package:n8n_monitor/widgets/molecules/api_conf_form_group.dart';
import 'package:provider/provider.dart';

class ApiConfForm extends StatefulWidget {
  const ApiConfForm({super.key});

  @override
  State<ApiConfForm> createState() => _ApiConfFormState();
}

class _ApiConfFormState extends State<ApiConfForm> {

  @override
  void dispose() {
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
  final  provider = Provider.of<InitialConfFormProvider>(context);

    return Form(
      key: provider.formKey,
      child: IntrinsicHeight(
        child: Column(
          spacing: 40,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ApiConfFormGroyp(
            ),
            CustomButton(
              isLoading: provider.loadingSendData,
              label: "Validar Conexión",
              icon: Icons.arrow_forward_rounded,
              onTap: () => provider.submitForm(context)
            ),
          ],
        ),
      ),
    );
  }
}
