import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/data/api/login_api.dart';
import 'package:flutter_bloc_practise/data/api/notes_api.dart';
import 'package:flutter_bloc_practise/presentation/router/app_router.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'logic/bloc/login_bloc/login_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(loginApi: LoginApi.instance(), notesApi: NotesApi()),
      child: MaterialApp(
        title: Strings.appTitle,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
