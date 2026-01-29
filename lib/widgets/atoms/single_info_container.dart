import 'package:flutter/material.dart';

class SingleInfoContainer extends StatelessWidget {
  final String title;
  final String info;
  const SingleInfoContainer({super.key, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF27352d)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                wordSpacing: 1.5,
                color: Color(0x99FFFFFF),
              ),
          ),
          SizedBox(height: 8),
          Text(
            info,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}