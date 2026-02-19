import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/molecules/divided_card.dart';
import 'package:n8n_monitor/widgets/pages/last_audit_page.dart';

class AuditOptionsCard extends StatelessWidget {
  const AuditOptionsCard({super.key});

  @override
  Widget build(BuildContext context) {


     void navigateToLastAudit() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LastAuditPage(),
        ),
      );
    }


    return DividedCard(
      children: [
        GestureDetector(
          child: Row(
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded),
              Text(
                "Iniciar auditoría de seguridad",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => navigateToLastAudit(),
          child: Row(
            spacing: 20.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.av_timer_rounded),
              Text(
                "Ver última auditoría",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
