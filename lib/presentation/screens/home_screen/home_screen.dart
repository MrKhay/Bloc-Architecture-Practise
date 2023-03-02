import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/presentation/router/app_router.dart';

import '../../../core/constants/strings.dart';
import '../../../logic/bloc/counter_bloc/bloc/counter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is CounterInitial) {
            return CounterWidget(height: height, width: width, counter: 0);
          } else if (state is UpdateCounter) {
            return CounterWidget(
              height: height,
              width: width,
              counter: state.counter,
            );
          }
          return Container();
        },
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.counter});

  final double height;
  final double width;
  final int counter;

  @override
  Widget build(BuildContext context) {
    var counterBloc = context.read<CounterBloc>();
    return Center(
      child: Container(
        height: height * 0.3,
        width: width * 0.8,
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              counter.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      counterBloc.add(NumberIncrement());
                    },
                    icon: const Icon(Icons.plus_one)),
                IconButton(
                    onPressed: () {
                      counterBloc.add(NumberDecrement());
                    },
                    icon: const Icon(Icons.exposure_minus_1)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
