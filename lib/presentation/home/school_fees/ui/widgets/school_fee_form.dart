import 'package:flutter/material.dart';

class SchoolFeeForm extends StatelessWidget {
  const SchoolFeeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          /*TextFormField(
            controller: mailController,
            validator: (value) =>
                Validator.validateEmail(value),
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: AppTexts.email),
          ),*/
        ],
      ),
    );
  }
}
