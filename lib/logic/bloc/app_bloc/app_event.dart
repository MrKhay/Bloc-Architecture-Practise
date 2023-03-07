part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class LoadNextUrlEvent implements AppEvent {
  const LoadNextUrlEvent();
  
}
