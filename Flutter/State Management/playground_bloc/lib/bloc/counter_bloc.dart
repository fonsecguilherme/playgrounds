import 'package:bloc/bloc.dart';
import 'package:playground_bloc/bloc/counter_event.dart';

part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(value: 0)) {
    on<IncrementEvent>(onNumberIncrease);
    on<DecrementEvent>(onNumberDecrease);
  }
  void onNumberIncrease(IncrementEvent event, Emitter<CounterState> emit) {
    final currentValue = state.value;
    emit(CounterUpdated(value: currentValue + 1));
  }

  void onNumberDecrease(DecrementEvent event, Emitter<CounterState> emit) {
    emit(CounterUpdated(value: state.value - 1));
  }
}
