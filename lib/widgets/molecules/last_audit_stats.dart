import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n8n_monitor/services/cache_service.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/pages/last_audit_page.dart';

class LastAuditStats extends StatefulWidget {
  const LastAuditStats({super.key});

  @override
  State<LastAuditStats> createState() => _LastAuditStatsState();
}

class _LastAuditStatsState extends State<LastAuditStats> {
  bool _isLoading = true;
  int _auditedAreas = 0;
  int _totalFindings = 0;
  int _withRecommendation = 0;
  int _withLocation = 0;
  DateTime? _auditDate;

  static const List<String> _reportKeys = [
    'Credentials Risk Report',
    'Nodes Risk Report',
    'Instance Risk Report',
    'Filesystem Risk Report',
    'Database Risk Report',
  ];

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final cacheService = CacheService();
      final auditData = await cacheService.getAuditData();
      final auditDate = await cacheService.getAuditDate();

      if (!mounted) return;

      if (auditData == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      int auditedAreas = 0;
      int totalFindings = 0;
      int withRecommendation = 0;
      int withLocation = 0;

      for (final key in _reportKeys) {
        final reportData = auditData[key];
        if (reportData is! Map<String, dynamic>) {
          continue;
        }

        final sections = reportData['sections'];
        if (sections is! List || sections.isEmpty) {
          continue;
        }

        auditedAreas += 1;
        totalFindings += sections.length;

        for (final section in sections) {
          if (section is! Map) {
            continue;
          }

          final recommendation = section['recommendation'];
          if (recommendation != null &&
              recommendation.toString().trim().isNotEmpty) {
            withRecommendation += 1;
          }

          final location = section['location'];
          if (location is List && location.isNotEmpty) {
            withLocation += 1;
          }
        }
      }

      setState(() {
        _auditedAreas = auditedAreas;
        _totalFindings = totalFindings;
        _withRecommendation = withRecommendation;
        _withLocation = withLocation;
        _auditDate = auditDate;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasData = _totalFindings > 0 || _auditedAreas > 0;
    final String auditDateText = _auditDate == null
        ? 'Fecha no disponible'
        : DateFormat('dd-MM-yyyy HH:mm').format(_auditDate!.toLocal());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading || !hasData
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LastAuditPage(),
                    ),
                  );
                },
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF27352d)),
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(22),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 92,
                    child: Center(
                      child: CustomLoader(variant: LoaderVariant.light),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Resumen de seguridad',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.88),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                            color: hasData ? Colors.white70 : Colors.white30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hasData
                            ? 'Última auditoría: $auditDateText'
                            : 'No hay datos de auditoría guardados',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _StatTag(
                            icon: Icons.security_rounded,
                            label: 'Áreas',
                            value: _auditedAreas.toString(),
                          ),
                          _StatTag(
                            icon: Icons.warning_amber_rounded,
                            label: 'Hallazgos',
                            value: _totalFindings.toString(),
                            highlighted: true,
                          ),
                          _StatTag(
                            icon: Icons.lightbulb_outline_rounded,
                            label: 'Recomendación',
                            value: _withRecommendation.toString(),
                          ),
                          _StatTag(
                            icon: Icons.location_on_outlined,
                            label: 'Localización',
                            value: _withLocation.toString(),
                          ),
                        ],
                      ),
                      if (hasData) ...[
                        const SizedBox(height: 14),
                        Text(
                          'Toca para ver el detalle completo',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _StatTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool highlighted;

  const _StatTag({
    required this.icon,
    required this.label,
    required this.value,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = highlighted
        ? Theme.of(context).colorScheme.primary.withOpacity(0.45)
        : const Color(0xFF27352d);

    final Color iconColor = highlighted
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).iconTheme.color ?? Colors.white70;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        color: const Color(0xFF122017),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 6),
          Text(
            '$label: $value',
            style: TextStyle(
              fontSize: 12,
              color: highlighted
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white.withOpacity(0.82),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
