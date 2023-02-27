part of 'counter_bloc.dart';

abstract class CounterEvent {
  const CounterEvent();
}

class CounterStarted extends CounterEvent {
  const CounterStarted();
}

class CounterIncrementPressed extends CounterEvent {
  const CounterIncrementPressed();
}

class CounterDecrementPressed extends CounterEvent {
  const CounterDecrementPressed();
}

class _CounterCountChanged extends CounterEvent {
  final int count;
  const _CounterCountChanged(this.count);
}

class _CounterConnectionStateChanged extends CounterEvent {
  const _CounterConnectionStateChanged(this.state);

  final ConnectionState state;
}
