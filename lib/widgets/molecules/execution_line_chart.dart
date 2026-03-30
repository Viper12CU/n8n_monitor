import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:n8n_monitor/api/executions.dart';
import 'package:n8n_monitor/provider/nav_index_provider.dart';
import 'package:n8n_monitor/utils/enums.dart';
import 'package:n8n_monitor/widgets/atoms/custom_dropdown_button.dart';
import 'package:n8n_monitor/widgets/atoms/custom_loader.dart';
import 'package:n8n_monitor/widgets/atoms/line_chart.dart';
import 'package:provider/provider.dart';

class ExecutionLineChart extends StatefulWidget {
  const ExecutionLineChart({super.key});

  @override
  State<ExecutionLineChart> createState() => _ExecutionLineChartState();
}

class _ExecutionLineChartState extends State<ExecutionLineChart> {
  String? selectedStatus = "24h";
  Map<String, dynamic> executionData = {'total': 0, 'data': []};
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchExecutions();
  }

  Future<void> _fetchExecutions() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final period = _getPeriodFromStatus(selectedStatus);
      final result = await getExecutionsByTimePeriod(period);

      setState(() {
        executionData = result;
        isLoading = false;

        if (result['error'] != null) {
          errorMessage = result['error'];
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error al cargar ejecuciones: $e';
        isLoading = false;
      });
    }
  }

  ExecutionTimePeriod _getPeriodFromStatus(String? status) {
    switch (status) {
      case '12h':
        return ExecutionTimePeriod.last12Hours;
      case '7d':
        return ExecutionTimePeriod.last7Days;
      case '15d':
        return ExecutionTimePeriod.last15Days;
      case '30d':
        return ExecutionTimePeriod.last30Days;
      default:
        return ExecutionTimePeriod.last24Hours;
    }
  }

  List<FlSpot> _convertDataToFlSpots() {
    final data = executionData['data'] as List? ?? [];
    if (data.isEmpty) return [];

    return List.generate(data.length, (index) {
      double count = 0;
      try {
        if (data[index] is Map) {
          final item = data[index] as Map<String, dynamic>;
          count = (item['count'] as int? ?? 0).toDouble();
        }
      } catch (e) {
        // Ignorar errores de parsing
      }
      return FlSpot(index.toDouble(), count);
    });
  }

  int _getMaxCount() {
    final data = executionData['data'] as List? ?? [];
    if (data.isEmpty) return 1;
    int maxCount = 0;
    for (final item in data) {
      try {
        if (item is Map<String, dynamic>) {
          final count = item['count'] as int? ?? 0;
          if (count > maxCount) maxCount = count;
        }
      } catch (e) {
        continue;
      }
    }

    return maxCount > 0 ? maxCount + 1 : 5;
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(value: "12h", child: Text("12H")),
      DropdownMenuItem(value: "24h", child: Text("24H")),
      DropdownMenuItem(value: "7d", child: Text("7D")),
      DropdownMenuItem(value: "15d", child: Text("15D")),
      DropdownMenuItem(value: "30d", child: Text("30D")),
    ];

    void onChanged(String? value) {
      // Lógica para manejar el cambio de selección
      setState(() {
        selectedStatus = value;
      });
      _fetchExecutions();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF27352d)),
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 26.0,
                right: 26.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 3,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EJECUCIONES ($selectedStatus)",
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                      Text(
                        "${executionData['total'] ?? 0}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CustomDropdownButton<String>(
                    icon: Icons.keyboard_arrow_down_rounded,
                    items: items,
                    onChanged: onChanged,
                    iconOnly: true,
                  ),
                ],
              ),
            ),

            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red.withAlpha(80)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[400], size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: TextStyle(
                            color: Colors.red[300],
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (isLoading)
              SizedBox(
                height: 211,
                child: Center(
                  child: CustomLoader(variant: LoaderVariant.light),
                ),
              )
            else if ((executionData['total'] == 0))
              SizedBox(
                height: 211,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 48,
                        color: Colors.grey[500],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No hay ejecuciones',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'en este período',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            else
              SizedBox(
                height: 190,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 28.0,
                    top: 0,
                    left: 28.0,
                    right: 28.0,
                  ),
                  child: LineChartSample(
                    dataPoints: _convertDataToFlSpots(),
                    maxX:
                        (executionData['data'] as List?)?.length.toDouble() ??
                        10,
                    maxY: _getMaxCount().toDouble(),
                    isHourly:
                        selectedStatus == "12h" || selectedStatus == "24h",
                  ),
                ),
              ),

            if (!isLoading && errorMessage == null)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      final navProvider = Provider.of<NavIndexProvider>(
                        context,
                        listen: false,
                      );
                      navProvider.selectedIndex = 2;
                    },
                    child: Text(
                      'Ver todas las ejecuciones',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
