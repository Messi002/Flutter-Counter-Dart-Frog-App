import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:counter_repository/counter_repository.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

extension on ConnectionState {
  CounterStatus toStatus() {
    return this is Connected || this is Reconnected
        ? CounterStatus.connected
        : CounterStatus.disconnected;
  }
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({required CounterRepository counterRepository})
      : _counterRepository = counterRepository,
        super(const CounterState()) {
    on<CounterStarted>(_onCounterStarted);
    on<_CounterConnectionStateChanged>(_onCounterConnectionStateChanged);
    on<_CounterCountChanged>(_onCounterCountChanged);
    on<CounterIncrementPressed>(_onCounterIncrementPressed);
    on<CounterDecrementPressed>(_onCounterDecrementPressed);
  }

  final CounterRepository _counterRepository;
  StreamSubscription<int>? _countSubscription;
  StreamSubscription<ConnectionState>? _connectionSubscription;

  /// CounterStarted: notifies the bloc that the counter feature has started and prompts the bloc to subscribe to changes from the backend
  void _onCounterStarted(CounterStarted event, Emitter<CounterState> emit) {
    _countSubscription = _counterRepository.count
        .listen((count) => add(_CounterCountChanged(count)));
    _connectionSubscription = _counterRepository.connection
        .listen((state) => add(_CounterConnectionStateChanged(state)));
  }

  /// CounterIncrementPressed: notifies the bloc that the user has tapped on the increment button
  /// when a bloc receives either event it will invoke increment or decrement on the CounterRepository respectively.
  void _onCounterIncrementPressed(
      CounterIncrementPressed event, Emitter<CounterState> emit) {
    _counterRepository.increment();
  }

  /// CounterDecrementPressed: notifies the bloc that the user has tapped on the decrement button
  /// when a bloc receives either event it will invoke increment or decrement on the CounterRepository respectively.
    void _onCounterDecrementPressed(
      CounterDecrementPressed event, Emitter<CounterState> emit) {
    _counterRepository.decrement();
  }

  ///_CounterCountChanged: notifies the bloc that the count has changed on the backend (internal)
  ///_CounterCountChanged event it will emit a new state with the updated count and in this case always set the status to
  ///connected since the bloc can only ever receive count updates from the server if it is connected.
  void _onCounterCountChanged(
      _CounterCountChanged event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: event.count, status: CounterStatus.connected));
  }

  /// _CounterConnectionStateChanged: notifies the bloc that the connection state has changed (internal)
  void _onCounterConnectionStateChanged(
      _CounterConnectionStateChanged event, Emitter<CounterState> emit) {
    emit(state.copyWith(status: event.state.toStatus()));
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    _countSubscription?.cancel();
    return super.close();
  }
}
