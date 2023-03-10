// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../constants/strings.dart';

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequireRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser()
};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;
  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
            dialogTitle: Strings.authError,
            dialogText: Strings.authUnknowError);
}

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          dialogText: Strings.noCurrentUser,
          dialogTitle: Strings.noCurrentUserWithTheInformation,
        );
}

@immutable
class AuthErrorRequireRecentLogin extends AuthError {
  const AuthErrorRequireRecentLogin()
      : super(
          dialogText: Strings.requireRecentLogin,
          dialogTitle: Strings.needToLogoutAndLoginAgain,
        );
}

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          dialogText: Strings.operationNotAllowed,
          dialogTitle: Strings.needToLogoutAndLoginAgain,
        );
}

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          dialogText: Strings.userNotFound,
          dialogTitle: Strings.userNotFoundOnServer,
        );
}

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          dialogText: Strings.weakPassword,
          dialogTitle: Strings.chooseBetterPassword,
        );
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          dialogText: Strings.invalidEmail,
          dialogTitle: Strings.doubleCheckEmail,
        );
}

@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          dialogText: Strings.emailInUse,
          dialogTitle: Strings.chooseAnotherEmail,
        );
}
