import 'package:flutter/material.dart';

class PreviewGroup extends StatelessWidget {
  final String label;
  final List<Widget>? children;
  const PreviewGroup({super.key, required this.label, this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [header(), if (children != null) ...children!],
      ),
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 22)),
        textButton(),
      ],
    );
  }

  TextButton textButton() {
    return TextButton(
      onPressed: () {},
      child: Row(
        spacing: 4,
        children: [Text("Ver todo"), Icon(Icons.arrow_forward_rounded)],
      ),
    );
  }
}
