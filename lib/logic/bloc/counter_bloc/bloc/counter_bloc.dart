import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int counter = 0;
  CounterBloc() : super(CounterInitial.initial()) {
    on<NumberIncrement>(onIncrement);
    on<NumberDecrement>(onDecrement);
  }

  void onIncrement(NumberIncrement event, Emitter<CounterState> emit) async {
    counter++;
    emit(UpdateCounter(counter));
  }

  void onDecrement(NumberDecrement event, Emitter<CounterState> emit) async {
    counter--;
    emit(UpdateCounter(counter));
  }
}
