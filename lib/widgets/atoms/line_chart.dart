import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample extends StatefulWidget {
  final List<FlSpot> dataPoints;
  final double maxX;
  final double maxY;
  final bool isHourly;
  const LineChartSample({
    super.key,
    required this.dataPoints,
    required this.maxX,
    required this.maxY,
    required this.isHourly,
  });

  @override
  State<LineChartSample> createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  List<Color> gradientColors = [Color(0xFF214d33), Color(0xFF1c2e23)];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return LineChart(mainData());
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).colorScheme.primary,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Theme.of(context).colorScheme.primary,
            strokeWidth: 3,
          );
        },
      ),
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                '${touchedSpot.y.toInt()} executions\n${ touchedSpot.x.toInt() == 0 ? "" : widget.isHourly ? touchedSpot.x.toInt() + 1 : touchedSpot.x.toInt()} ${touchedSpot.x.toInt() == 0
                    ? widget.isHourly
                          ? "Hace un momento"
                          : "Hoy"
                    : touchedSpot.x.toInt() == 1
                    ? widget.isHourly
                          ? "hora"
                          : "día"
                    : widget.isHourly
                    ? "horas"
                    : "días"} ${touchedSpot.x.toInt() == 0 ? "" : "atrás" } ',
                TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ), 
              );
            }).toList();
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: false,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: widget.maxX,
      minY: 0,
      maxY: widget.maxY,
      lineBarsData: [
        LineChartBarData(
          spots: widget.dataPoints,
          isCurved: true,
          color: Theme.of(context).colorScheme.primary,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          ),
        ),
      ],
    );
  }
}
