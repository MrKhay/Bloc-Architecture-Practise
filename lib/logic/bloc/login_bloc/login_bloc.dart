import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_practise/data/api/login_api.dart';
import 'package:flutter_bloc_practise/data/api/notes_api.dart';
import 'package:flutter_bloc_practise/data/models/login_handle_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  LoginBloc({required this.loginApi, required this.notesApi})
      : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      // start loading
      emit(
        const AppState(
            isLoading: true,
            loginErros: null,
            fetchedNotes: null,
            loginHandle: null),
      );

      // log the user in
      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );

      emit(
        AppState(
            isLoading: false,
            loginErros: loginHandle == null ? LoginErros.invalidHnadle : null,
            fetchedNotes: null,
            loginHandle: loginHandle),
      );
    });

    on<LoadNotes>(
      (event, emit) async {
        emit(
          AppState(
              isLoading: true,
              loginErros: null,
              fetchedNotes: null,
              loginHandle: state.loginHandle),
        );
        // get login handle
        final loginHandle = state.loginHandle;

        if (loginHandle != const LoginHandle.fooBar()) {
          emit(
            AppState(
                isLoading: false,
                loginErros: LoginErros.invalidHnadle,
                fetchedNotes: null,
                loginHandle: loginHandle),
          );
        } else {
          /// this is a valid login handle
          final notes = await notesApi.getNotes(loginHandle: loginHandle!);
          emit(
            AppState(
                isLoading: false,
                loginErros: null,
                fetchedNotes: notes,
                loginHandle: loginHandle),
          );
        }
      },
    );
  }
}
