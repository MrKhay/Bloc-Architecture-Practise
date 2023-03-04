part of 'person_bloc.dart';

const String person1Url = 'http://10.0.2.2:5500/api/person1.json';
const String person2Url = 'http://10.0.2.2:5500/api/person2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({
    required this.url,
    required this.loader
  }) : super();
}

Future<Iterable<Person>> getPersons(String url) {
  return HttpClient()
      .getUrl(Uri.parse(url))
      .then((value) => value.close())
      .then((value) => value.transform(utf8.decoder).join())
      .then((str) => json.decode(str) as List<dynamic>)
      .then((value) => value.map((e) => Person.fromJson(e)));
}
