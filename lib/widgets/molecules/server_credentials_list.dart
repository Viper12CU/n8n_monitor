import 'package:flutter/material.dart';
import 'package:n8n_monitor/services/server_credentials_service.dart';

class ServerCredentialsList extends StatelessWidget {
  final List<ServerCredential> credentials;
  final ValueChanged<int> onSetActive;
  final ValueChanged<int> onDelete;

  const ServerCredentialsList({
    super.key,
    required this.credentials,
    required this.onSetActive,
    required this.onDelete,
  });

  String _formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    final h = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    return '$y-$m-$d $h:$min';
  }

  String _formatDateOnly(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  bool _isExpiredOrSoon(DateTime expirationDate) {
    final now = DateTime.now();
    final difference = expirationDate.difference(now).inDays;
    return difference <= 0; // Expirada o hoy
  }

  bool _isExpirationSoon(DateTime expirationDate) {
    final now = DateTime.now();
    final difference = expirationDate.difference(now).inDays;
    return difference > 0 && difference <= 30; // Entre hoy y 30 días
  }

  @override
  Widget build(BuildContext context) {
    if (credentials.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF27352d), width: 1.2),
        ),
        child: const Text(
          'No hay credenciales guardadas.',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
      );
    }

    return Column(
      spacing: 12.0,
      children: credentials.map((credential) {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          credential.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          credential.url,
                          style: const TextStyle(
                            color: Color(0xCCFFFFFF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (credential.inUse)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF153622),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF35d374)),
                      ),
                      child: const Text(
                        'ACTIVA',
                        style: TextStyle(
                          color: Color(0xFF35d374),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(
                          'Creada: ${_formatDate(credential.createdAt)}',
                          style: const TextStyle(
                            color: Color(0x99FFFFFF),
                            fontSize: 12,
                          ),
                        ),
                        if (credential.hasExpirationDate) ...[
                          Row(
                            spacing: 8,
                            children: [
                              if (_isExpiredOrSoon(credential.apiKeyExpirationDate!))
                                Icon(
                                  Icons.warning_rounded,
                                  size: 16,
                                  color: Colors.redAccent,
                                )
                              else if (_isExpirationSoon(credential.apiKeyExpirationDate!))
                                Icon(
                                  Icons.info_rounded,
                                  size: 16,
                                  color: Colors.orangeAccent,
                                ),
                              Expanded(
                                child: Text(
                                  'Expira: ${_formatDateOnly(credential.apiKeyExpirationDate!)}',
                                  style: TextStyle(
                                    color: _isExpiredOrSoon(credential.apiKeyExpirationDate!)
                                        ? Colors.redAccent
                                        : _isExpirationSoon(credential.apiKeyExpirationDate!)
                                            ? Colors.orangeAccent
                                            : const Color(0x99FFFFFF),
                                    fontSize: 12,
                                    fontWeight: _isExpiredOrSoon(credential.apiKeyExpirationDate!) || _isExpirationSoon(credential.apiKeyExpirationDate!)
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else
                          Text(
                            'Sin fecha de expiración',
                            style: const TextStyle(
                              color: Color(0x99FFFFFF),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Usar esta',
                        onPressed: credential.inUse
                            ? null
                            : () => onSetActive(credential.id),
                        icon: Icon(
                          Icons.check_circle_outline,
                          color: credential.inUse
                              ? const Color(0xFF35d374)
                              : Colors.white70,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Eliminar',
                        onPressed: () => onDelete(credential.id),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
