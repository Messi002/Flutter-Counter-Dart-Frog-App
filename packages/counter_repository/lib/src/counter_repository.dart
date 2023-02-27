import 'package:web_socket_client/web_socket_client.dart';
import 'package:web_socket_counter/counter/counter.dart';

/// A Dart package which manages the counter domain
class CounterRepository {
  final WebSocket _ws;

  CounterRepository({WebSocket? socket})
      : _ws = socket ?? WebSocket(Uri.parse('ws://localhost:8080/ws'));

  ///Send an increment message to the server
  void increment() => _ws.send(Message.increment.value);

  ///Send an decrement message to the server
  void decrement() => _ws.send(Message.decrement.value);

  /// Return a stream of real-time count updates from the server
  Stream<int> get count => _ws.messages.cast<String>().map(int.parse);

  ///Return a stream of connection updates from the server
  Stream<ConnectionState> get connection => _ws.connection;

  /// Close the connection
  void close() => _ws.close();
}
