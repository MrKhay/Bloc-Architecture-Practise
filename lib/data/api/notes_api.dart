import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_practise/data/models/login_handle_model.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Notes>?> getNotes({required LoginHandle loginHandle});
}

@immutable
class NotesApi implements NotesApiProtocol {
  @override
  Future<Iterable<Notes>?> getNotes({required LoginHandle loginHandle}) =>
      Future.delayed(const Duration(seconds: 2),
          () => loginHandle == const LoginHandle.fooBar() ? mockNotes : null);
}
