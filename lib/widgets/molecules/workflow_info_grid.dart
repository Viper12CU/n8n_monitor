import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:n8n_monitor/widgets/atoms/single_info_container.dart';

class WorkflowInfoGrid extends StatelessWidget {
  final String createdAt;
  final String updatedAt;
  const WorkflowInfoGrid({
    super.key,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    String formatDate(String isoDate) {
      try {
        final dateTime = DateTime.parse(isoDate);
        final formatter = DateFormat('dd-MM-yyyy HH:mm');
        return formatter.format(dateTime);
      } catch (e) {
        return isoDate; // Retorna la fecha original si hay error
      }
    }

    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.1,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SingleInfoContainer(
          title: "Creado el",
          child: Text(
            formatDate(createdAt),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SingleInfoContainer(
            title: "Actualizado",
          child: Text(
            formatDate(updatedAt),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
