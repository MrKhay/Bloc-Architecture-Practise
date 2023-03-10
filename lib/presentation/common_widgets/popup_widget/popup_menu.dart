// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/core/constants/strings.dart';
import 'package:flutter_bloc_practise/logic/bloc/app_bloc/app_bloc.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/delete_account_dialog.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/logout_dialog.dart';

enum MenuAction { logout, deleteAccount }

class PopupMenu extends StatelessWidget {
  const PopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text(Strings.logout),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text(Strings.deleteAccount),
          ),
        ];
      },
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final shouldLogout = await showLogOutDialog(context);
            if (shouldLogout) {
              context.read<AppBloc>().add(const AppEventLogOut());
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount = await showDeleteAccountDialog(context);

            if (shouldDeleteAccount) {
              context.read<AppBloc>().add(const AppEventDeleteAccount());
            }
            break;
        }
      },
    );
  }
}
