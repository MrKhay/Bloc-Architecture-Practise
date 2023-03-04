// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErros? loginErros;
  final LoginHandle? loginHandle;
  final Iterable<Notes>? fetchedNotes;

  const AppState({
    required this.isLoading,
    this.loginErros,
    this.loginHandle,
    this.fetchedNotes,
  });

  const AppState.empty()
      : this(
            isLoading: false,
            loginErros: null,
            loginHandle: null,
            fetchedNotes: null);

  @override
  String toString() {
    return 'AppState(isLoading: $isLoading, loginErros: $loginErros, loginHandle: $loginHandle, fetchedNotes: $fetchedNotes)';
  }
}
