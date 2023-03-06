// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc_practise/data/api/login_api.dart';
import 'package:flutter_bloc_practise/data/api/notes_api.dart';
import 'package:flutter_bloc_practise/data/models/login_handle_model.dart';
import 'package:flutter_bloc_practise/logic/bloc/login_bloc/login_bloc.dart';

const Iterable<Notes> mockedNote = [
  Notes(title: 'Note 1'),
  Notes(title: 'Note 2'),
  Notes(title: 'Note 3'),
];

@immutable
class DummyNotesApi implements NotesApiProtocol {
  final LoginHandle acceptedLoginHandle;
  final Iterable<Notes>? notesToReturnFromAcceptedLoginHandle;
  const DummyNotesApi({
    required this.acceptedLoginHandle,
    this.notesToReturnFromAcceptedLoginHandle,
  });

  const DummyNotesApi.empty()
      : this(
            acceptedLoginHandle: const LoginHandle.fooBar(),
            notesToReturnFromAcceptedLoginHandle: null);

  @override
  Future<Iterable<Notes>?> getNotes({required LoginHandle loginHandle}) async {
    if (loginHandle == acceptedLoginHandle) {
      return notesToReturnFromAcceptedLoginHandle;
    } else {
      return null;
    }
  }
}

@immutable
class DummyLoginApi implements LoginApiProtocol {
  final String acceptedEmail;
  final String acceptedPassword;
  final LoginHandle handleToReture;
  const DummyLoginApi({
    required this.acceptedEmail,
    required this.acceptedPassword,
    required this.handleToReture,
  });

  const DummyLoginApi.empty()
      : this(
            acceptedEmail: '',
            acceptedPassword: '',
            handleToReture: const LoginHandle.fooBar());

  @override
  Future<LoginHandle?> login(
      {required String email, required String password}) async {
    if (email == acceptedEmail && password == acceptedPassword) {
      return handleToReture;
    } else {
      return null;
    }
  }
}

void main() {
  blocTest<LoginBloc, AppState>(
    'Initial state of the bloc should be AppState.empty()',
    build: () => LoginBloc(
      acceptedLoginHandle: const LoginHandle(token: 'ABC'),
      loginApi: const DummyLoginApi.empty(),
      notesApi: const DummyNotesApi.empty(),
    ),
    verify: (appState) => expect(appState.state, const AppState.empty()),
  );

  blocTest<LoginBloc, AppState>(
    'Can we login in with correct credentials',
    build: () => LoginBloc(
      acceptedLoginHandle: const LoginHandle(token: 'ABC'),
      loginApi: const DummyLoginApi(
          acceptedEmail: 'bar@baz.com',
          acceptedPassword: 'foo',
          handleToReture: LoginHandle(token: 'ABC')),
      notesApi: const DummyNotesApi.empty(),
    ),
    act: (bloc) => bloc.add(
      const LoginAction(
        email: 'bar@baz.com',
        password: 'foo',
      ),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        fetchedNotes: null,
        loginErros: null,
        loginHandle: null,
      ),
      const AppState(
        isLoading: false,
        fetchedNotes: null,
        loginErros: null,
        loginHandle: LoginHandle(token: 'ABC'),
      ),
    ],
  );

  blocTest<LoginBloc, AppState>(
    'Can we login in with correct incorrect credentials',
    build: () => LoginBloc(
      acceptedLoginHandle: const LoginHandle(token: 'ABC'),
      loginApi: const DummyLoginApi(
          acceptedEmail: 'bar@baz.com',
          acceptedPassword: 'foo',
          handleToReture: LoginHandle(token: 'ABC')),
      notesApi: const DummyNotesApi.empty(),
    ),
    act: (bloc) => bloc.add(
      const LoginAction(
        email: 'bar@baz',
        password: 'foo',
      ),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        fetchedNotes: null,
        loginErros: null,
        loginHandle: null,
      ),
      const AppState(
        isLoading: false,
        fetchedNotes: null,
        loginErros: LoginErros.invalidHandle,
        loginHandle: null,
      ),
    ],
  );

  blocTest<LoginBloc, AppState>(
    'Load some notes with a valid credential',
    build: () => LoginBloc(
      acceptedLoginHandle: const LoginHandle(token: 'ABC'),
      loginApi: const DummyLoginApi(
          acceptedEmail: 'bar@baz.com',
          acceptedPassword: 'foo',
          handleToReture: LoginHandle(token: 'ABC')),
      notesApi: const DummyNotesApi(
          acceptedLoginHandle: LoginHandle(token: 'ABC'),
          notesToReturnFromAcceptedLoginHandle: mockedNote),
    ),
    act: (bloc) {
      bloc.add(
        const LoginAction(
          email: 'bar@baz.com',
          password: 'foo',
        ),
      );
      bloc.add(const LoadNotes());
    },
    expect: () => [
      const AppState(
        isLoading: true,
        fetchedNotes: null,
        loginErros: null,
        loginHandle: null,
      ),
      const AppState(
        isLoading: false,
        fetchedNotes: null,
        loginErros: null,
        loginHandle: LoginHandle(token: 'ABC'),
      ),
      const AppState(
        isLoading: true,
        fetchedNotes: null,
        loginErros: null,
        loginHandle: LoginHandle(token: 'ABC'),
      ),
      const AppState(
        isLoading: false,
        fetchedNotes: mockedNote,
        loginErros: null,
        loginHandle: LoginHandle(token: 'ABC'),
      ),
    ],
  );
}
