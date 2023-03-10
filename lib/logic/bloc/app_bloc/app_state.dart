// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

@immutable
abstract class AppState {
  final bool isLoading;
  final AuthError? authError;
  const AppState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
class AppStateLoggedIn extends AppState {
  final User user;
  final Iterable<Reference> images;
  const AppStateLoggedIn({
    required this.images,
    required this.user,
    required super.isLoading,
    super.authError,
  });

  @override
  bool operator ==(covariant other) {
    final otherClass = other;
    if (otherClass is AppStateLoggedIn) {
      return isLoading == otherClass.isLoading &&
          user.uid == otherClass.user.uid &&
          images.length == otherClass.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => user.hashCode ^ images.hashCode;

  @override
  String toString() =>
      'AppStateLoggedIn(user: $user, images: ${images.length})';
}

@immutable
class AppStateLoggedOut extends AppState {
  const AppStateLoggedOut({required super.isLoading, super.authError});

  @override
  String toString() {
    return 'AppStateLoggedOut(isLoading: ${super.isLoading} authError:${super.authError})';
  }
}

@immutable
class AppStateInRegistrationView extends AppState {
  const AppStateInRegistrationView({
    required super.isLoading,
    super.authError,
  });
}

extension GetUser on AppState {
  User? get user {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.user;
    } else {
      return null;
    }
  }
}

extension GetImages on AppState {
  Iterable<Reference>? get images {
    final cls = this;
    if (cls is AppStateLoggedIn) {
      return cls.images;
    } else {
      return null;
    }
  }
}
