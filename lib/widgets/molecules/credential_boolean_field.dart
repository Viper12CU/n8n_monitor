import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_switch.dart';

class CredentialBooleanField extends StatelessWidget {
  final String label;
  final String? description;
  final ValueNotifier<bool> controller;
  final ValueChanged<bool> onChanged;

  const CredentialBooleanField({
    super.key,
    required this.label,
    this.description,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color ?? const Color(0xFF9eb7a8);
    final cardColor = Theme.of(context).cardTheme.color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF3c5044), width: 1.5),
      ),
      child: Row(
        spacing: 12,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                if (description != null && description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      description!,
                      style: TextStyle(
                        fontSize: 12,
                        color: iconColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          CustomSwitch(
            controller: controller,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
