import 'package:flutter_bloc_practise/data/models/person_model.dart';
import 'package:flutter_bloc_practise/logic/bloc/person_bloc/person_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons1 = [
  Person(name: 'Foo', age: 20),
  Person(name: 'Bar', age: 30),
];

const mockedPersons2 = [
  Person(name: 'Foo', age: 20),
  Person(name: 'Bar', age: 30),
];

Future<Iterable<Person>> mockGetPerson1(String _) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPerson2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing Bloc', () {
    /// write test

    late PersonsBloc bloc;
    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Test initial state',
      build: () => bloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    /// fetch mock data (person1) and compare it with FetchResult
    blocTest('Mock retriving persons from 1st iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
              const LoadPersonsAction(url: person1Url, loader: mockGetPerson1));
          bloc.add(
              const LoadPersonsAction(url: person1Url, loader: mockGetPerson1));
        },
        expect: () => [
              const FetchResult(
                  persons: mockedPersons1, isRetrivedFromCache: false),
              const FetchResult(
                  persons: mockedPersons1, isRetrivedFromCache: true)
            ]);

    /// fetch mock data (person2) and compare it with FetchResult
    blocTest('Mock retriving persons from 2nd iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
              const LoadPersonsAction(url: person2Url, loader: mockGetPerson1));
          bloc.add(
              const LoadPersonsAction(url: person2Url, loader: mockGetPerson1));
        },
        expect: () => [
              const FetchResult(
                  persons: mockedPersons2, isRetrivedFromCache: false),
              const FetchResult(
                  persons: mockedPersons2, isRetrivedFromCache: true)
            ]);
  });
}
