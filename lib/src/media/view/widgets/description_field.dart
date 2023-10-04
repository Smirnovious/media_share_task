
import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.descriptionTextController,
  });

  final TextEditingController descriptionTextController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descriptionTextController,
      maxLength: 10,
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }
}
