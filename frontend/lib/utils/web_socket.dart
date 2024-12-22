import 'package:web_socket_channel/web_socket_channel.dart';

// constants
import '../constants/config.dart';

class WebSocketService {
  final WebSocketChannel channel;

  WebSocketService()
      : channel = WebSocketChannel.connect(Uri.parse(socketBaseUrl));

  Stream<dynamic> get messages => channel.stream;

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  void close() {
    channel.sink.close();
  }
}
