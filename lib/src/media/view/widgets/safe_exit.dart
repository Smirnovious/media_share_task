import 'dart:ui';

import 'package:flutter/material.dart';

class SafeExit extends StatelessWidget {
  const SafeExit({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final response = await showDialog<AppExitResponse>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog.adaptive(
            title:
                const Text('Are you sure you want to quit the upload process?'),
            content: const Text('All unsaved progress will be lost.'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(AppExitResponse.cancel);
                },
              ),
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(AppExitResponse.exit);
                },
              ),
            ],
          ),
        );

        return response == AppExitResponse.exit;
      },
      child: child,
    );
  }
}
