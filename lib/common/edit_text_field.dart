import 'package:flutter/material.dart';

import '../utils/validators/validation.dart';

class EditTextField extends StatelessWidget {
  const EditTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => Validator.validateEmptyText(
          value, labelText),
      decoration: InputDecoration(
          border: const OutlineInputBorder().copyWith(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          prefixIcon: const Icon(Icons.account_circle_outlined),
          labelText: labelText),
    );
  }
}


