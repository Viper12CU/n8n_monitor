import 'package:flutter/material.dart';

class TagsSearchPanel extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;
  final VoidCallback onClear;

  const TagsSearchPanel({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);
    final panelColor = Theme.of(context).cardTheme.color;

    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: panelColor,
          borderRadius: borderRadius,
          border: Border.all(
            color: const Color(0xFF27352d),
            width: 1.2,
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            backgroundColor: panelColor,
            collapsedBackgroundColor: panelColor,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            collapsedShape: RoundedRectangleBorder(borderRadius: borderRadius),
            iconColor: Theme.of(context).colorScheme.primary,
            collapsedIconColor: Colors.white70,
            title: const Text(
              'Buscar etiquetas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: TextField(
                  controller: controller,
                  onChanged: (_) => onChanged(),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Buscar por nombre o ID',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: onClear,
                            icon: const Icon(Icons.close),
                          ),
                    filled: true,
                    fillColor: panelColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF3c5044),
                        width: 1.2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFF3c5044),
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
