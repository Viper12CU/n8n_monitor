import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';

class AppbarServerStatus extends StatelessWidget {
  final Status status;
  const AppbarServerStatus({super.key, this.status = Status.unavalible});

  @override
  Widget build(BuildContext context) {
    final bool serverAvalible = status == Status.avalible;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 5.0,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: serverAvalible ? Color(0xFF35d374) : Colors.redAccent,
          ),
        ),
        Text(serverAvalible ? "online" : "offline", style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.0
        ),)
      ],
    );
  }
}
