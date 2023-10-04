import 'package:flutter/material.dart';

class AuthErrorDialog extends StatelessWidget {
  const AuthErrorDialog({Key? key, required this.description})
      : super(key: key);
  final String? description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Error',
        style: TextStyle(color: Colors.red, fontSize: 30),
      ),
      content: Text(description!),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
