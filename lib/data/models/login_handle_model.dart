// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_overrides
import 'package:flutter/material.dart';

@immutable
class LoginHandle {
  final String token;
  const LoginHandle({required this.token});

  const LoginHandle.fooBar() : this(token: 'fooBar');

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() => 'LoginHandle(token: $token)';
}

enum LoginErros { invalidHnadle }

@immutable
class Notes {
  final String title;
  const Notes({
    required this.title,
  });

  @override
  String toString() => 'Notes(title: $title)';
}

final mockNotes =
    Iterable.generate(3, (index) => Notes(title: 'Note: ${index + 1}'));
