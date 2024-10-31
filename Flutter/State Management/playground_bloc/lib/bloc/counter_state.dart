part of 'counter_bloc.dart';

sealed class CounterState {
  final int value;

  CounterState(this.value);
}

final class CounterInitial extends CounterState {
  CounterInitial({
    required int value,
  }) : super(value);
}

final class CounterUpdated extends CounterState {
  CounterUpdated({
    required int value,
  }) : super(value);
}
