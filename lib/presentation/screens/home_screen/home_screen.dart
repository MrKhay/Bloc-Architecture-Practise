import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/logic/extension/if_debugging.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/constants/strings.dart';
import '../../../logic/bloc/app_bloc/app_bloc.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController =
        useTextEditingController(text: 'ikhaydev@gmail.com'.ifDebugging);
    final passWordController =
        useTextEditingController(text: 'foobarbazz'.ifDebugging);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.login),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /// email [text filed]

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
              decoration:
                  const InputDecoration(hintText: Strings.enterYourEmail),
            ),

            /// password [text field]

            TextField(
              obscureText: true,
              obscuringCharacter: '●',
              controller: passWordController,
              keyboardType: TextInputType.visiblePassword,
              keyboardAppearance: Brightness.dark,
              decoration:
                  const InputDecoration(hintText: Strings.enterYourPassword),
            ),

            /// login [Button]

            TextButton(
              onPressed: () {
                final email = emailController.text;
                final password = passWordController.text;
                context.read<AppBloc>().add(
                      AppEventLogIn(
                        email: email,
                        passWord: password,
                      ),
                    );
              },
              child: const Text(Strings.login),
            ),

            /// not-registerd [Button]

            TextButton(
              onPressed: () {
                context.read<AppBloc>().add(const AppEventGoToRegister());
              },
              child: const Text(Strings.notRegisteredYet),
            ),
          ],
        ),
      ),
    );
  }
}
