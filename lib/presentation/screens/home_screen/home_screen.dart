import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' show Random;

const names = ['Foo', 'Bar', 'Baz'];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() => emit(names.getRandomElement());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NamesCubit cubit;
  @override
  void initState() {
    cubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<String?>(
            stream: cubit.stream,
            builder: (context, snapshot) {
              final button = Center(
                child: TextButton(
                    onPressed: () => cubit.pickRandomName(),
                    child: const Text('Get Random Name')),
              );

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return button;
                case ConnectionState.waiting:
                  return button;
                case ConnectionState.active:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(snapshot.data ?? ''), button],
                  );
                case ConnectionState.done:
                  return const SizedBox();
              }
            }));
  }
}
