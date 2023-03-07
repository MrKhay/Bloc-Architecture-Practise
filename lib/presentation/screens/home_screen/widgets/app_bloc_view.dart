import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/core/constants/strings.dart';
import 'package:flutter_bloc_practise/data/extension/streams/start_with.dart';
import 'package:flutter_bloc_practise/logic/bloc/app_bloc/app_bloc.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({Key? key}) : super(key: key);

  void startUpdatingBloc(BuildContext context) {
    final stream = Stream.periodic(
            const Duration(seconds: 10), (_) => const LoadNextUrlEvent())
        .startWith(const LoadNextUrlEvent())
        .forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, state) {
          if (state.error != null) {
            // we have error
            return const Text(Strings.errorOccured);
          } else if (state.data != null) {
            // we have data
            return Image.memory(
              state.data!,
              fit: BoxFit.fitHeight,
            );
          } else {
            // loading state
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
