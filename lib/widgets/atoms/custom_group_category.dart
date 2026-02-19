import 'package:flutter/material.dart';

class CustomGroupCategory extends StatelessWidget {
  final String category;
  final Widget child;
  final EdgeInsetsGeometry categoryPadding;

  const CustomGroupCategory({
    super.key,
    required this.category,
    required this.child, this.categoryPadding = const EdgeInsets.all(20.0) ,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado de la categoría
        Padding(
          padding: categoryPadding,
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
