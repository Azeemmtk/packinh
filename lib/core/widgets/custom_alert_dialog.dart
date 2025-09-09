import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonText,
  });

  final String title;
  final String message;
  final String confirmButtonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      title: Text(title, style: TextStyle(color: mainColor),),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), // Cancel
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true), // Confirm
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}
