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

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color.withAlpha((0.1 * 255).toInt()),
              border: Border.all(
                color: color.withAlpha((0.3 * 255).toInt()),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 18,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                _buildActionButton(
                  icon: Icons.edit_outlined,
                  tooltip: 'Actualizar',
                  color: const Color(0xFF4DB6AC),
                  onPressed: () => onUpdate(tag),
                ),
                _buildActionButton(
                  icon: Icons.delete_outline_rounded,
                  tooltip: 'Eliminar',
                  color: const Color(0xFFE57373),
                  onPressed: () => onDelete(tag),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
