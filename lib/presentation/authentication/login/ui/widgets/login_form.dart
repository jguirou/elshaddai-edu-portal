import 'package:el_shaddai_edu_portal/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/validators/validation.dart';
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.obscureText,
    this.onLoginPressed, required this.mailController, required this.passwordController, this.onHashPassword,
  });

  final bool obscureText;
  final void Function()? onLoginPressed;
  final void Function()? onHashPassword;
  final TextEditingController mailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: mailController,
            validator: (value) =>
                Validator.validateEmail(value),
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: AppTexts.email),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputField,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: obscureText,
            validator: (value) =>
                Validator.validatePassword(value),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                labelText: AppTexts.password,
                suffixIcon: IconButton(
                    onPressed: onHashPassword,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ))),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),
          /// Sign In button
          SizedBox(
            width: HelperFunctions.screenWidth(context)/ 2.5,
            child: ElevatedButton(
              onPressed: onLoginPressed,
              child: const Text(AppTexts.login),
            ),
          ),
        ],
      ),
    );
  }
}