import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_practise/logic/bloc/app_bloc/app_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

enum Errors { dummy }

extension ToList on String {
  Uint8List toUint8List() => Uint8List.fromList(codeUnits);
}

final text1Data = 'foo'.toUint8List();
final text2Data = 'Bar'.toUint8List();

void main() {
  blocTest<AppBloc, AppState>(
    'inital state of the bloc sould be empty',
    build: () => AppBloc(
      urls: [],
    ),
    verify: (bloc) => expect(bloc.state, const AppState.empty()),
  );

// load valid data and compare its result
  blocTest<AppBloc, AppState>(
    'load valid data and compare state',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (bloc) => bloc.add(const LoadNextUrlEvent()),
    expect: () => [
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
    ],
  );

  blocTest<AppBloc, AppState>(
    'throw an error in urlloader and catch it',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.error(Errors.dummy),
    ),
    act: (bloc) => bloc.add(const LoadNextUrlEvent()),
    expect: () => [
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      const AppState(
        isLoading: false,
        data: null,
        error: Errors.dummy,
      ),
    ],
  );

  blocTest<AppBloc, AppState>(
    'test ability to load more than one url',
    build: () => AppBloc(
      urls: [],
      urlPicker: (_) => '',
      urlLoader: (_) => Future.value(text2Data),
    ),
    act: (bloc) {
      bloc.add(
        const LoadNextUrlEvent(),
      );
      bloc.add(
        const LoadNextUrlEvent(),
      );
    },
    expect: () => [
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
      const AppState(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
    ],
  );
}
