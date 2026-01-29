import 'package:flutter/material.dart';

class CustomGroupCategory extends StatelessWidget {
  final String category;
  final Widget child;

  const CustomGroupCategory({
    super.key,
    required this.category,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado de la categoría
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            category.toUpperCase(),
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        // Widget hijo
        child,
      ],
    );
  }
}
