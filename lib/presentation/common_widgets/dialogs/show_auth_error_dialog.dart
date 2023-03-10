import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_practise/core/exceptions/auth_exceptions/auth_error.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/generic_dialog.dart';

Future<void> showAuthErrorDialog(
    {required BuildContext context, required AuthError authError}) {
  return showGenericDialog<bool>(
      context: context,
      title: authError.dialogTitle,
      content: authError.dialogText,
      optionBuilder: () => {'OK': true});
}
