// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

typedef ClosedLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final ClosedLoadingScreen close;
  final UpdateLoadingScreen update;
  
  const LoadingScreenController({
    required this.close,
    required this.update,
  });

  
}
