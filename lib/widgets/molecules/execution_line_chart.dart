import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/line_chart.dart';

class ExecutionLineChart extends StatelessWidget {
  const ExecutionLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF27352d)),
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0,left: 26.0),
              child: Column(
                spacing: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("EJECUCIONES (24H)", style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                  Text("1,245", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            SizedBox(height: 211, child: const LineChartSample()),
          ],
        ),
      ),
    );
  }
}
