// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final PersonUrl url;
  const LoadPersonsAction({
    required this.url,
  }) : super();
}

enum PersonUrl {
  person1,
  person2,
}

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return 'http://10.0.2.2:5500/api/person1.json';

      case PersonUrl.person2:
        return 'http://10.0.2.2:5500/api/person2.json';
    }
  }
}

extension Log on Object {
  void log() => devtools.log(toString());
}

@immutable
class Person {
  final String name;
  final int age;
  const Person({
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
    };
  }

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

Future<Iterable<Person>> getPersons(String url) {
  return HttpClient()
      .getUrl(Uri.parse(url))
      .then((value) => value.close())
      .then((value) => value.transform(utf8.decoder).join())
      .then((str) => json.decode(str) as List<dynamic>)
      .then((value) => value.map((e) => Person.fromJson(e)));
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrivedFromCache;
  const FetchResult({
    required this.persons,
    required this.isRetrivedFromCache,
  });

  @override
  String toString() =>
      'FetchResult(persons: $persons, isRetrivedFromCache: $isRetrivedFromCache)';
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        // we have the value in the caach
        final cachedPersons = _cache[url]!;
        final result = FetchResult(
          persons: cachedPersons,
          isRetrivedFromCache: true,
        );
        emit(result);
      } else {
        final persons = await getPersons(url.urlString);
        _cache[url] = persons;
        final result =
            FetchResult(persons: persons, isRetrivedFromCache: false);

        emit(result);
      }
    });
  }
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
                      context
                          .read<PersonsBloc>()
                          .add(const LoadPersonsAction(url: PersonUrl.person1));
                    },
                    child: const Text('Load Json 1')),
                TextButton(
                    onPressed: () {
                      context
                          .read<PersonsBloc>()
                          .add(const LoadPersonsAction(url: PersonUrl.person2));
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
