import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitialConfHero extends StatelessWidget {
  const InitialConfHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Avatar(),
        const Heading(),
        const Subtitle(),
      ],
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Text(
        "Ingresa los detalles de tu instancia de n8n para comenzar a monitorear tus flujos de trabajo.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.white70),
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Conecta tu n8n",
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: SvgPicture.asset(
              'lib/assets/icons8-brain-nodes.svg',
              height: 80,
              width: 80,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF122017), width: 3),
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            height: 50,
            width: 50,
            child: Icon(Icons.link_rounded, color: Color(0xFF122017), size: 30),
          ),
        ),
      ],
    );
  }
}
