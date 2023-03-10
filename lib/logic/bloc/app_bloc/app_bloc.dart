import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc_practise/core/exceptions/auth_exceptions/auth_error.dart';
import 'package:flutter_bloc_practise/logic/utilities/upload_image.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(const AppStateLoggedOut(
          isLoading: false,
        )) {
    /// handle uploading images
    on<AppEventUploadImage>((event, emit) async {
      final user = state.user;

      /// log user out if we dont have userId
      if (user == null) {
        emit(
          const AppStateLoggedOut(isLoading: false),
        );
        return;
      }

      /// start the loading process

      emit(AppStateLoggedIn(
        images: state.images ?? [],
        user: user,
        isLoading: true,
      ));

      /// upload the file
      final file = File(event.filePathToUpload);
      await uploadImage(
        file: file,
        userId: user.uid,
      );

      /// after upload is complete, grad lateste instance
      final images = await _getImages(user.uid);

      /// emit new images and turn off loading
      emit(AppStateLoggedIn(
        images: images,
        user: user,
        isLoading: false,
      ));
    });

    /// handle account deletion

    on<AppEventDeleteAccount>((event, emit) async {
      final user = FirebaseAuth.instance.currentUser;

      /// log user out if we dont have userId
      if (user == null) {
        emit(
          const AppStateLoggedOut(isLoading: false),
        );
        return;
      }

      /// start laoding
      emit(AppStateLoggedIn(
        images: state.images ?? [],
        user: user,
        isLoading: true,
      ));

      /// delete the user folder

      try {
        final folderContent =
            await FirebaseStorage.instance.ref(user.uid).listAll();
        for (final item in folderContent.items) {
          await item.delete().catchError((_) {});

          /// maybe handle the error?
        }

        /// delete the folder itself
        await FirebaseStorage.instance
            .ref(user.uid)
            .delete()
            .catchError((_) {});

        /// delete user
        await user.delete();

        /// log the user out
        await FirebaseAuth.instance.signOut();
        emit(const AppStateLoggedOut(
          isLoading: false,
        ));
      } on FirebaseAuthException catch (e) {
        emit(AppStateLoggedIn(
            images: state.images ?? [],
            user: user,
            isLoading: false,
            authError: AuthError.from(e)));
      } on FirebaseException {
        /// we might not be able to delete the folder

        emit(const AppStateLoggedOut(
          isLoading: false,
        ));
      }
    });

    /// handle log out
    on<AppEventLogOut>((event, emit) async {
      // start loading
      emit(const AppStateLoggedOut(isLoading: true));

      // log the user out
      await FirebaseAuth.instance.signOut();

      // stop loading
      emit(const AppStateLoggedOut(
        isLoading: false,
      ));
    });

    /// app event initilize
    on<AppEventInitialize>((event, emit) async {
      // get the current user
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
      } else {
// go grab the user uploaded images
        final images = await _getImages(user.uid);

        emit(AppStateLoggedIn(
          images: images,
          user: user,
          isLoading: false,
        ));
      }
    });

    /// register user
    on<AppEventRegister>((event, emit) async {
// start laoding

      emit(const AppStateInRegistrationView(isLoading: true));
      final _email = event.email;
      final _password = event.passWord;

      try {
        // create user
        final credentials =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        final userId = credentials.user!.uid;

        emit(AppStateLoggedIn(
            images: const [], user: credentials.user!, isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateInRegistrationView(
          isLoading: false,
          authError: AuthError.from(e),
        ));
      }
    });

    /// go to login
    on<AppEventGoToLogin>((event, emit) {
      emit(const AppStateLoggedOut(isLoading: false));
    });

    /// login user
    on<AppEventLogIn>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));

      // log user in

      try {
        final email = event.email;
        final password = event.passWord;
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        final user = userCredential.user!;
        final images = await _getImages(user.uid);
        emit(AppStateLoggedIn(
          images: images,
          user: user,
          isLoading: false,
        ));
      } on FirebaseAuthException catch (e) {
        emit(AppStateLoggedOut(
          isLoading: false,
          authError: AuthError.from(e),
        ));
      }
    });

    /// go to registration
    on<AppEventGoToRegistration>((event, emit) {
      emit(const AppStateInRegistrationView(
        isLoading: false,
      ));
    });
  }

  Future<Iterable<Reference>> _getImages(String userId) {
    return FirebaseStorage.instance
        .ref(userId)
        .list()
        .then((lisResult) => lisResult.items);
  }
}
