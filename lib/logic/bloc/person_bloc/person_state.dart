part of 'person_bloc.dart';

@immutable
abstract class PersonState {}

class PersonInitial extends PersonState {}

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

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEualToIgnoringOrdering(other.persons) &&
      isRetrivedFromCache == other.isRetrivedFromCache;
      
        @override
         int get hashCode => Object.hash(persons, isRetrivedFromCache);
      


}
