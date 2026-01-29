import 'package:flutter/material.dart';
import 'package:n8n_monitor/widgets/atoms/custom_button.dart';

class ServerOfflineTemplate extends StatefulWidget {
  const ServerOfflineTemplate({super.key});

  @override
  State<ServerOfflineTemplate> createState() => _ServerOfflineTemplateState();
}

class _ServerOfflineTemplateState extends State<ServerOfflineTemplate> {
  bool isLoading = false;

  void handleClick() async {
    setState(() {
      isLoading = true;
    });

    debugPrint("Comprobando disponibilidad del servidor...");

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        spacing: 15.0,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar(context),
          heading(),
          subtitle(),
          SizedBox(height: 20,),
          CustomButton(
            isLoading: isLoading,
            label: "Reintentar",
            icon: Icons.replay_rounded,
            onTap: () {handleClick();},
          ),
        ],
      ),
    );
  }
}

Widget subtitle() {
  return Text(
    "Parece que hay un problema conectando con tu servidor de n8n. Por favor, verifica tu conexión de internet.",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16, color: Colors.white70),
  );
}

Widget heading() {
  return Text(
    "Servidor no disponible",
    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  );
}

Stack avatar(BuildContext context) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFF0f1c14),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(color: Color(0xFF3c5044), width: 2),
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFF1c2921),
              Color(0xFF1d2b22),
              Color(0xFF1d2e24),
              Color(0xFF1d3225),
              Color(0xFF1e3527),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        height: 150,
        width: 150,
        child: Center(
          child: Icon(
            Icons.wifi_off_outlined,
            size: 70,
            color: Colors.redAccent,
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 32,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF3c5044)),
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).cardTheme.color,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 7.0,
                width: 7.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                ),
              ),
              Text(
                "OFFLINE",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0, color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
