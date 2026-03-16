import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n8n_monitor/services/cache_service.dart';
import 'package:n8n_monitor/widgets/atoms/custom_tabs_bar.dart';
import 'package:n8n_monitor/widgets/templates/last_audit_template.dart';

class LastAuditPage extends StatefulWidget {
  const LastAuditPage({super.key});

  @override
  State<LastAuditPage> createState() => _LastAuditPageState();
}

class _LastAuditPageState extends State<LastAuditPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  Map<String, dynamic>? _auditData;
  DateTime? _auditDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadAuditData();
  }

  Future<void> _loadAuditData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final cacheService = CacheService();
      final data = await cacheService.getAuditData();
      final date = await cacheService.getAuditDate();

      if (mounted) {
        setState(() {
          _auditData = data;
          _auditDate = date;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error al cargar datos de auditoría: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auditDateText = _auditDate == null
        ? 'Fecha no disponible'
        : DateFormat('dd-MM-yyyy HH:mm').format(_auditDate!.toLocal());

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            'ÚLTIMA AUDITORÍA DE SEGURIDAD',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.2,
            ),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final List<Widget> pages = [
      LastAuditTemplate(
        auditData: _auditData?['Credentials Risk Report'],
        title: 'Credenciales',
      ),
      LastAuditTemplate(
        auditData: _auditData?['Nodes Risk Report'],
        title: 'Nodos',
      ),
      LastAuditTemplate(
        auditData: _auditData?['Instance Risk Report'],
        title: 'Instancia',
      ),
      LastAuditTemplate(
        auditData: _auditData?['Filesystem Risk Report'],
        title: 'Archivos del Sistema',
      ),
      LastAuditTemplate(
        auditData: _auditData?['Database Risk Report'],
        title: 'Base de datos',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'ÚLTIMA AUDITORÍA DE SEGURIDAD',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomTabsBar(
              titles: const [
                "Credenciales",
                "Nodos",
                "Instancia",
                "Achivos del Sistema",
                "Base de datos",
              ],
              onTabChange: (index) {
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutCirc,
                );
              },
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF27352d)),
                color: Theme.of(context).cardTheme.color,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 16,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Fecha de auditoría: $auditDateText',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.78),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
