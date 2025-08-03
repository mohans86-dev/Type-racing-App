import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = IO.io('https://type-racing-app.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    // socket = IO.io('http://192.168.1.6:3001', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    // });
    socket!.connect();

    // ✅ Log socket connection
    socket!.on('connect', (_) {
      print("Socket connected with ID: ${socket!.id}");
    });

    socket!.on('connect_error', (err) {
      print("Socket connection error: $err");
    });

    socket!.on('disconnect', (_) {
      print("Socket disconnected");
    });
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
