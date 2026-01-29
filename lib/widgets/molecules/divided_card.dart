import 'package:flutter/material.dart';

class DividedCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const DividedCard({
    super.key,
    required this.children,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Crear lista con widgets intercalados con dividers
    final List<Widget> dividedChildren = [];
    for (int i = 0; i < children.length; i++) {
      dividedChildren.add(children[i]);
      // Agregar divider si no es el último elemento
      if (i < children.length - 1) {
        dividedChildren.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: const Divider(
            color: Color(0xFF27352d),
          ),
        ));
      }
    }

    return Card(
      margin: margin,
      color: Theme.of(context).cardTheme.color,
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: dividedChildren,
        ),
      ),
    );
  }
}
