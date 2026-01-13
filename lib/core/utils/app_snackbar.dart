import 'package:flutter/material.dart';

class AppSnackBar {
  static void success(BuildContext context, String message) {
    show(
      context,
      message,
      Colors.green,
      Icons.check_circle,
    );
  }

  static void error(BuildContext context, String message) {
    show(
      context,
      message,
      Colors.red,
      Icons.error,
    );
  }

  static void show(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
