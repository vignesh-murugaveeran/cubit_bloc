import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state - 1);
  }

  void reset() {
    emit(0);
  }
}

/*
1. Cubit<int> --> Cubit manages the int State
2. super(0) --> Initial State is 0
3. void increment() --> Method to change the state
4. emit() --> Method to emit the new state(state or 0 + 1 = 1, state or 0 - 1 = -1)
5. state --> Current State
 */
