import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/audit.dart';
import 'package:n8n_monitor/services/cache_service.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_snackbar.dart';
import 'package:n8n_monitor/widgets/molecules/confirmation_dialog.dart';
import 'package:n8n_monitor/widgets/molecules/tools_card.dart';
import 'package:n8n_monitor/widgets/pages/last_audit_page.dart';
import 'package:page_transition/page_transition.dart';

class AuditOptionsCard extends StatefulWidget {
  const AuditOptionsCard({super.key});

  @override
  State<AuditOptionsCard> createState() => _AuditOptionsCardState();
}

class _AuditOptionsCardState extends State<AuditOptionsCard> {
  bool _isLoading = false;

  void navigateToLastAudit() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        duration: const Duration(milliseconds: 300),
        child: const LastAuditPage(),
      ),
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
    return ToolsCard(
      height: 200,
      centerTitle: 'Auditoría',
      leftIcon: _isLoading ? Icons.hourglass_top_rounded : Icons.play_arrow_rounded,
      leftTitle:
          _isLoading ? 'Ejecutando auditoría...' : 'Iniciar auditoría',
      leftDescription: _isLoading
          ? 'Esto puede tardar unos segundos'
          : 'Auditar seguridad y permisos del servidor',
      rightIcon: Icons.av_timer_rounded,
      rightTitle: 'Última auditoría',
      rightDescription: 'Consultar último resultado guardado',
      onLeftTap: _isLoading ? null : startAudit,
      onRightTap: navigateToLastAudit,
    );
  }
}
