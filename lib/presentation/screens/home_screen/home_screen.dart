import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/core/constants/images.dart';
import 'package:flutter_bloc_practise/logic/bloc/app_bloc/app_bottom_bloc.dart';
import 'package:flutter_bloc_practise/logic/bloc/app_bloc/app_top_bloc.dart';
import 'package:flutter_bloc_practise/presentation/screens/home_screen/widgets/app_bloc_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppTopBloc>(
              create: (context) => AppTopBloc(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
            BlocProvider<AppBottomBloc>(
              create: (context) => AppBottomBloc(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
          ],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [
              AppBlocView<AppTopBloc>(),
              AppBlocView<AppBottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
