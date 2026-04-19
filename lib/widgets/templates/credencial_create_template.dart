import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/organisms/credential_create_form.dart';

class CredencialCreateTemplate extends StatefulWidget {
  const CredencialCreateTemplate({super.key});

  @override
  State<CredencialCreateTemplate> createState() => _CredencialCreateTemplateState();
}

class _CredencialCreateTemplateState extends State<CredencialCreateTemplate> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      child: const CredentialCreateForm(),
    );
  }
}