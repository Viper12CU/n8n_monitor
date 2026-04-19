import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/credential_card.dart';

class CredentialsList extends StatelessWidget {
  final List<Map<String, dynamic>> credentials;

  const CredentialsList({
    super.key,
    required this.credentials,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.0,
      children: credentials
          .map((credential) => CredentialCard(credential: credential))
          .toList(),
    );
  }
}
