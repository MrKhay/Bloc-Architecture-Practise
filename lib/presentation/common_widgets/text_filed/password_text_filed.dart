import 'package:flutter/material.dart';
import '../../../core/constants/strings.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      obscuringCharacter: '●',
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        hintText: Strings.enterYourEmailHere,
      ),
    );
  }
}
