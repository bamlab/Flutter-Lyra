import 'package:flutter/material.dart';

enum SnackbarType { success, error }

void showExampleSnackBar(
  BuildContext context, {
  required String message,
  required SnackbarType type,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: type == SnackbarType.success ? Colors.green : Colors.red,
      content: Text(message),
    ),
  );
}
