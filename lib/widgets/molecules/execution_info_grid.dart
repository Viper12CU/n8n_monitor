import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:n8n_monitor/widgets/atoms/single_info_container.dart';

class ExecutionInfoGrid extends StatelessWidget {
  final String mode;
  final String executionId;
  final String startedAt;
  final String stoppedAt;
  const ExecutionInfoGrid({
    super.key,
    required this.mode,
    required this.executionId,
    required this.startedAt,
    required this.stoppedAt,
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        StaggeredGridTile.fit(
          crossAxisCellCount: 1,

          child: SingleInfoContainer(
            title: "Modo",
            child: Text(
              mode,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        StaggeredGridTile.fit(
          crossAxisCellCount: 1,
          child: SingleInfoContainer(
            title: "Id de ejecución",
            child: Text(
              executionId,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        StaggeredGridTile.fit(
          crossAxisCellCount: 2,
          child: SingleInfoContainer(
            title: "Detalles de fechas",
            child: Column(
              spacing: 20,
              children: [
                dateRow(Icons.play_arrow_rounded, "INICIADO EN ", startedAt),
                dateRow(Icons.stop_rounded, "DETENIDO EN", stoppedAt),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dateRow(IconData icon, String label, String date) {
    return Row(
      spacing: 10,
      children: [
        Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(24, 255, 255, 255),
            shape: BoxShape.circle,
          ),
          child: Icon(icon),
        ),
        SizedBox(
          width: 270,
          // color: Colors.amberAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0x99FFFFFF),
                ),
              ),
              Text(
                date,
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
