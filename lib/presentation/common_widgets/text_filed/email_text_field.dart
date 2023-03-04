import 'package:flutter/material.dart';
import '../../../core/constants/strings.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController emailControlller;
  const EmailTextField({super.key, required this.emailControlller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailControlller,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        hintText: Strings.enterYourEmailHere,
      ),
    );
  }
}
