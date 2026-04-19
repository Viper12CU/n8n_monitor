import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CredentialCard extends StatelessWidget {
  final Map<String, dynamic> credential;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTransfer;

  const CredentialCard({
    super.key,
    required this.credential,
    this.onEdit,
    this.onDelete,
    this.onTransfer,
  });

  String _formatDate(String? isoDate) {
    if (isoDate == null || isoDate.trim().isEmpty) {
      return 'N/A';
    }

    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    } catch (_) {
      return isoDate;
    }
  }

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required Color color,
    required VoidCallback? onPressed,
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
    final id = (credential['id'] ?? '-').toString();
    final name = (credential['name'] ?? 'Sin nombre').toString();
    final type = (credential['type'] ?? '-').toString();
    final createdAt = _formatDate(credential['createdAt']?.toString());
    final updatedAt = _formatDate(credential['updatedAt']?.toString());
    final shared = credential['shared'];
    final sharedCount = shared is List ? shared.length : 0;
    final badgeColor = Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF27352d), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withAlpha((0.15 * 255).toInt()),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: badgeColor.withAlpha((0.6 * 255).toInt())),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'ID: $id',
            style: const TextStyle(
              color: Color(0xCCFFFFFF),
              fontSize: 12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Creada: $createdAt',
                style: const TextStyle(
                  color: Color(0x99FFFFFF),
                  fontSize: 12,
                ),
              ),
              Text(
                'Actualizada: $updatedAt',
                style: const TextStyle(
                  color: Color(0x99FFFFFF),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Icon(
                Icons.group_outlined,
                size: 16,
                color: Colors.white.withAlpha((0.6 * 255).toInt()),
              ),
              Text(
                sharedCount > 0
                    ? 'Compartida en $sharedCount proyecto(s)'
                    : 'No compartida',
                style: TextStyle(
                  color: Colors.white.withAlpha((0.6 * 255).toInt()),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildActionButton(
                icon: Icons.edit_outlined,
                tooltip: 'Editar credencial',
                color: const Color(0xFF4DB6AC),
                onPressed: onEdit,
              ),
              _buildActionButton(
                icon: Icons.send_outlined,
                tooltip: 'Transferir credencial',
                color: const Color(0xFF81C784),
                onPressed: onTransfer,
              ),
              _buildActionButton(
                icon: Icons.delete_outline,
                tooltip: 'Eliminar credencial',
                color: const Color(0xFFE57373),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
