import 'package:flutter/material.dart';
import 'package:n8n_monitor/utils/enums.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    required SnackbarType type,
    Duration duration = const Duration(seconds: 4),
    bool showCloseIcon = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _buildContent(message, type),
        backgroundColor: _getBackgroundColor(type),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        showCloseIcon: showCloseIcon,
      ),
    );
  }

  static Widget _buildContent(String message, SnackbarType type) {
    return Row(
      spacing: 10,
      children: [
        Icon(_getIcon(type), size: 24, color: _getIconColor(type)),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: _getTextColor(type),
            ),
          ),
        ),
      ],
    );
  }

  static Color _getBackgroundColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.info:
        return Color(0xFF1c3d5a);
      case SnackbarType.error:
        return Color(0xFF3d1c1c);
      case SnackbarType.success:
        return Color(0xFF1c2b22);
    }
  }

  static Color _getTextColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.info:
        return Color(0xFF64b5f6);
      case SnackbarType.error:
        return Color(0xFFef5350);
      case SnackbarType.success:
        return Color(0xFF38e07b);
    }
  }

  static Color _getIconColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.info:
        return Color(0xFF42a5f5);
      case SnackbarType.error:
        return Color(0xFFe53935);
      case SnackbarType.success:
        return Color(0xFF38e07b);
    }
  }

  static IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.info:
        return Icons.info_outlined;
      case SnackbarType.error:
        return Icons.error_outline_rounded;
      case SnackbarType.success:
        return Icons.check_circle_outline_rounded;
    }
  }
}
