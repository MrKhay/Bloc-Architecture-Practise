import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/loading_screen.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/show_auth_error_dialog.dart';

import 'package:flutter_bloc_practise/presentation/router/app_router.dart';
import 'package:flutter_bloc_practise/presentation/screens/gallery_screen/gallery_screen.dart';
import 'package:flutter_bloc_practise/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter_bloc_practise/presentation/screens/registered_screen/registered_screen.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'logic/bloc/app_bloc/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc()..add(const AppEventInitialize()),
      child: MaterialApp(
        title: Strings.appTitle,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            if (state.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: Strings.laoding,
              );
            } else {
              LoadingScreen.instance().hide();
            }
            final authError = state.authError;

            if (authError != null) {
              showAuthErrorDialog(
                context: context,
                authError: authError,
              );
            }
          },
          builder: (context, state) {
            if (state is AppStateLoggedOut) {
              return const HomeScreen();
            } else if (state is AppStateLoggedIn) {
              return const GalleryScreen();
            } else if (state is AppStateInRegistrationView) {
              return const RegistereScreen();
            } else {
              // this should never happen
              return Container();
            }
          },
        ),

        // initialRoute: AppRouter.home,
        // onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
