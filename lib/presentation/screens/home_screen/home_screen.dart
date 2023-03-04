// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc_practise/data/models/login_handle_model.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/generic_dialog.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/loading_screen.dart';
import 'package:flutter_bloc_practise/presentation/screens/home_screen/widgets/list_view_tile.dart';
import 'package:flutter_bloc_practise/presentation/screens/login/login_view.dart';

import '../../../core/constants/strings.dart';
import '../../../logic/bloc/login_bloc/login_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.showHomePage)),
      body: BlocConsumer<LoginBloc, AppState>(
        listener: (context, state) {
          /// tahe care of loading screen

          if (state.isLoading) {
            LoadingScreen.instance()
                .show(context: context, text: Strings.pleasWait);
          } else {
            print('Called hide');
            LoadingScreen.instance().hide();
          }

          final loginError = state.loginErros;

          if (loginError != null) {
            showGenericDialog(
              context: context,
              title: Strings.loginErrorDialogTile,
              content: Strings.loginErrorDialogContent,
              optionBuilder: () => {Strings.ok: true},
            );
          }

          /// if we are loaded in and we have no fetch notes fetc them
          if (state.isLoading == false &&
              loginError == null &&
              state.loginHandle == const LoginHandle.fooBar() &&
              state.fetchedNotes == null) {
            context.read<LoginBloc>().add(const LoadNotes());
          }
        },
        builder: (context, state) {
          final notes = state.fetchedNotes;

          if (notes == null) {
            return LoginView(
              onLogInTapped: (email, password) {
                context
                    .read<LoginBloc>()
                    .add(LoginAction(email: email, password: password));
              },
            );
          } else {
            return notes.toListView();
          }
        },
      ),
    );
  }
}
