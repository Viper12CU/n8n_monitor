import 'package:flutter/material.dart';

class AlertBadge extends StatelessWidget {
  final int count;
  final AlertSeverity severity;

  const AlertBadge({
    Key? key,
    required this.count,
    required this.severity,
  }) : super(key: key);

  Color get _backgroundColor {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.redAccent.withOpacity(0.2);
      case AlertSeverity.warning:
        return Colors.orangeAccent.withOpacity(0.2);
      case AlertSeverity.info:
        return Colors.blueAccent.withOpacity(0.2);
    }
  }

  Color get _textColor {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.redAccent;
      case AlertSeverity.warning:
        return Colors.orangeAccent;
      case AlertSeverity.info:
        return Colors.blueAccent;
    }
  }

  IconData get _icon {
    switch (severity) {
      case AlertSeverity.critical:
        return Icons.error_rounded;
      case AlertSeverity.warning:
        return Icons.warning_rounded;
      case AlertSeverity.info:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Icon(_icon, size: 14, color: _textColor),
          Text(
            count.toString(),
            style: TextStyle(
              color: _textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

enum AlertSeverity { critical, warning, info }
