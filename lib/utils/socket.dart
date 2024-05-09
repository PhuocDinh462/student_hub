// ignore_for_file: avoid_print, library_prefixes

import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:student_hub/models/models.dart';

class StreamSocketController<T> {
  StreamSocketController() {
    print('Init Stream controller ${T.toString()}');
  }
  final _socketResponse = StreamController<T>();

  void Function(T) get addResponse => _socketResponse.sink.add;

  Stream<T> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class SocketApi {
  factory SocketApi() {
    return _socketApi;
  }

  SocketApi._internal();

  static void init(String token) {
    if (socket.connected == false) {
      socket.io.options?['extraHeaders'] = {'Authorization': 'Bearer $token'};

      socket.connect();

      socket.onConnect((data) => {
            print('Connected to server: ${dotenv.env['API_SERVER']}'),
          });

      socket.on('unauthorized', (dynamic data) {
        print('Unauthorized');
      });

      socket.onError(
        (dynamic error) => {print(error), print('socket error')},
      );
      socket.onDisconnect((dynamic data) {
        print('socket instance disconnected');
      });
    } else {
      print('socket instance already connected');
    }
  }

  // A static private instance to access _socketApi from inside class only
  static final SocketApi _socketApi = SocketApi._internal();

  static IO.Socket socket = IO.io(
    dotenv.env['API_SERVER'],
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .enableForceNewConnection()
        .setTimeout(5000)
        .setReconnectionDelay(10000)
        .enableReconnection()
        .build(),
  );

  // All socket related functions.
  static Stream<NotificationModel> getNotificationModel(int userId) async* {
    final streamSocket = StreamSocketController<NotificationModel>();
    try {
      socket.on('NOTI_$userId', (dynamic data) {
        try {
          Map<String, dynamic> notification = data['notification'];
          streamSocket.addResponse(NotificationModel.fromMap(notification));
        } catch (e) {
          throw Exception(e);
        }
      });
      yield* streamSocket.getResponse.take(20);
    } catch (e) {
      throw Exception(e);
    } finally {
      print('Stream controller asset closed');
      socket.off('NOTI_$userId');
      streamSocket.dispose();
    }
  }
}
