import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';



class ServerStatus extends StatelessWidget {
  final Status status;
  const ServerStatus({super.key, this.status = Status.unavalible});

  @override
  Widget build(BuildContext context) {
    final bool serverAvalible = status == Status.avalible;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconContainer(serverAvalible),
          Text(
            serverAvalible ?
            "Servidor disponible" : "Servidor no disponible",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Container iconContainer(bool serverAvalible) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: serverAvalible ? Color(0xFF35d374) : Colors.redAccent, width: 2),
        boxShadow: [
          BoxShadow(blurRadius: 20, color: serverAvalible ? Color(0xFF153622) :  Color.fromARGB(72, 255, 107, 107)),
          BoxShadow(blurRadius: 20, color: serverAvalible ? Color(0xFF153622) :Color.fromARGB(27, 136, 30, 30)),
        ],
      ),
      child: Icon( serverAvalible ?  Icons.check_rounded : Icons.close_rounded, size: 30, color: serverAvalible ? Color(0xFF35d374) : Colors.redAccent),
    );
  }
}
