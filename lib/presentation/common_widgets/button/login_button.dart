import 'package:flutter/material.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/generic_dialog.dart';

import '../../../core/constants/strings.dart';

typedef OnLogInTapped = void Function(String email, String password);

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLogInTapped onLogInTapped;
  const LoginButton(
      {Key? key,
      required this.emailController,
      required this.passwordController,
      required this.onLogInTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          final email = emailController.text;
          final passWord = passwordController.text;

          if (email.isEmpty || passWord.isEmpty) {
            showGenericDialog(
                context: context,
                title: Strings.emailOrPasswordEmptyDialogTitle,
                content: Strings.emailOrPasswordEmptyDescription,
                optionBuilder: () => {Strings.ok: true});
          } else {
            onLogInTapped(email, passWord); 
          }
        },
        child: const Text(Strings.showLogin));
  }
}
