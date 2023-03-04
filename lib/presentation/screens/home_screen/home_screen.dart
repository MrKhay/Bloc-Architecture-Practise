// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/logic/bloc/person_bloc/person_bloc.dart';

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      context.read<PersonsBloc>().add(
                            const LoadPersonsAction(
                                url: person1Url, loader: getPersons),
                          );
                    },
                    child: const Text('Load Json 1')),
                TextButton(
                    onPressed: () {
                      context.read<PersonsBloc>().add(
                            const LoadPersonsAction(
                                url: person2Url, loader: getPersons),
                          );
                    },
                    child: const Text('Load Json 2')),
                Expanded(
                  child: BlocBuilder<PersonsBloc, FetchResult?>(
                    buildWhen: (previous, current) {
                      return previous?.persons != current?.persons;
                    },
                    builder: (context, state) {
                      state?.log();
                      final persons = state?.persons;
                      if (persons == null) {
                        return const SizedBox();
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final person = persons[index];

                            return ListTile(
                                title: Text(
                              person!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.black),
                            ));
                          },
                          itemCount: persons.length,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
