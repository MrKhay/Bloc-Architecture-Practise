import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/generic_dialog.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: 'Delete account',
      content:
          'Are you sure you want to delete your account? You cannot undo this operation!',
      optionBuilder: () => {
            'Cancle': false,
            'Delete account ': true
          }).then((value) => value ?? false);
}
