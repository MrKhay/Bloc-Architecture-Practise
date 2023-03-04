import 'package:flutter/material.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/button/login_button.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/text_filed/email_text_field.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/text_filed/password_text_filed.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  final OnLogInTapped onLogInTapped;

  const LoginView({Key? key, required this.onLogInTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextField(emailControlller: emailController),
          PasswordTextField(passwordController: passwordController),
          LoginButton(
              emailController: emailController,
              passwordController: passwordController,
              onLogInTapped: onLogInTapped)
        ],
      ),
    );
  }
}
