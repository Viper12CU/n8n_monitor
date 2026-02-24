import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      LastAuditTemplate(),
      Container(color: Theme.of(context).scaffoldBackgroundColor, child: Center(child: Text("2"))),
      Container(color: Theme.of(context).scaffoldBackgroundColor, child: Center(child: Text("3"))),
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
              titles: const ["Credenciales", "Nodos", "Instancia"],
              onTabChange: (index) {
                _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
              },
            ),
            Expanded(
              child: PageView.builder(
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
