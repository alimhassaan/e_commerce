import 'package:flutter/material.dart';

class MainDialog {
  static Future<void> showCustomDialog({
    required BuildContext context,
    required Object error,
    required String title,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          title,
          style: Theme.of(dialogContext).textTheme.headlineMedium,
        ),
        content: Text(
          error.toString(),
          style: Theme.of(dialogContext).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}