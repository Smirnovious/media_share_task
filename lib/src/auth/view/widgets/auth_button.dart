import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({
    Key? key,
    required this.onPressed,
    required this.buttonLabel,
  }) : super(key: key);
  final Function onPressed;
  final String buttonLabel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
          textStyle: Theme.of(context).textTheme.displayMedium),
      onPressed: () async {
        await onPressed();
      },
      child: Text(buttonLabel,
          style: const TextStyle(
            fontFamily: 'Raleway',
          )),
    );
  }
}
