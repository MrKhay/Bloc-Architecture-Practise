// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class AppAction {
  const AppAction();
}

@immutable
class LoginAction implements AppAction {
  final String email;
  final String password;

  const LoginAction({
    required this.email,
    required this.password,
  });
}

@immutable
class LoadNotes implements AppAction {
const LoadNotes();    
}
