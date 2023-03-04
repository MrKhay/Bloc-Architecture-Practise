import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'dart:developer' as devtools show log;
import '../../../data/models/person_model.dart';
import 'package:flutter/foundation.dart' show immutable;
part 'person_event.dart';
part 'person_state.dart';

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
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
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url] = persons;
        final result =
            FetchResult(persons: persons, isRetrivedFromCache: false);

        emit(result);
      }
    });
  }
}

extension Log on Object {
  void log() => devtools.log(toString());
}

extension IsEqualToIgonoringOrdering<T> on Iterable<T> {
  bool isEualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}
