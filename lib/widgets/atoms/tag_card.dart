import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  final Map<String, dynamic> tag;
  final ValueChanged<Map<String, dynamic>> onUpdate;
  final ValueChanged<Map<String, dynamic>> onDelete;

  const TagCard({
    super.key,
    required this.tag,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final id = (tag['id'] ?? '-').toString();
    final name = (tag['name'] ?? 'Sin nombre').toString();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF27352d), width: 1.2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'ID: $id',
            style: const TextStyle(
              color: Color(0xFF9eb7a8),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: 'Actualizar',
                  onPressed: () => onUpdate(tag),
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  tooltip: 'Eliminar',
                  onPressed: () => onDelete(tag),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
