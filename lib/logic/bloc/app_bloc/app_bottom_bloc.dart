import 'package:flutter_bloc_practise/logic/bloc/app_bloc/app_bloc.dart';

class AppBottomBloc extends AppBloc {
  AppBottomBloc({
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
  }) : super(
          urls: urls,
          waitBeforeLoading: waitBeforeLoading,
        );
}
