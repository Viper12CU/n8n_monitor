import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/audit.dart';
import 'package:n8n_monitor/services/cache_service.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
import 'package:n8n_monitor/widgets/pages/last_audit_page.dart';

class AuditOptionsCard extends StatefulWidget {
  const AuditOptionsCard({super.key});

  @override
  State<AuditOptionsCard> createState() => _AuditOptionsCardState();
}

class _AuditOptionsCardState extends State<AuditOptionsCard> {
  bool _isLoading = false;

  Widget _buildActionTile({
    required VoidCallback? onTap,
    required IconData icon,
    required String title,
    String? subtitle,
    bool isLoading = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Row(
            spacing: 14.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: isLoading ? 32 : 22,
                height: 22,
                child: isLoading
                    ? const CustomLoader(variant: LoaderVariant.light)
                    : Icon(icon, size: 22, color: colorScheme.onSecondary),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isLoading
                            ? Colors.white70
                            : colorScheme.onSecondary,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLastAudit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LastAuditPage()),
    );
  }

  void startAudit() async {
    final result = await ConfirmationDialog.show(
      context,
      title: 'Confirmar auditoría',
      message:
          '¿Estás seguro de que deseas iniciar la auditoría de seguridad? Esta acción no se puede deshacer.',
    );

    if (result != null) {
      setState(() {
        _isLoading = true;
      });

      debugPrint('Iniciar auditoría de seguridad');

      try {
        // Realizar la auditoría de seguridad
        final auditResult = await performSecurityAudit();

        if (auditResult['error'] == null) {
          // Guardar el resultado de la auditoría en caché
          final cacheService = CacheService();
          await cacheService.saveAuditData(auditResult['data']);

          if (mounted) {
            CustomSnackbar.show(
              context: context,
              message: 'Auditoría completada exitosamente',
              type: SnackbarType.success,
            );
          }

          navigateToLastAudit();
        } else {
          if (mounted) {
            CustomSnackbar.show(
              context: context,
              message: auditResult['error'],
              type: SnackbarType.error,
            );
          }
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DividedCard(
      children: [
        _buildActionTile(
          onTap: _isLoading ? null : startAudit,
          icon: Icons.play_arrow_rounded,
          title: _isLoading
              ? 'Ejecutando auditoría...'
              : 'Iniciar auditoría de seguridad',
          subtitle: _isLoading ? 'Esto puede tardar unos segundos' : null,
          isLoading: _isLoading,
        ),
        _buildActionTile(
          onTap: navigateToLastAudit,
          icon: Icons.av_timer_rounded,
          title: 'Ver última auditoría',
          subtitle: 'Consultar último resultado guardado',
        ),
      ],
    );
  }
}
