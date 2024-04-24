import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/io_client.dart' as http;

class SocketManager {
  late IO.Socket socket;

  SocketManager({required String serverUrl}) {
    // Configurar el cliente HTTP con verificación de certificado desactivada
    http.IOClient httpClient = http.IOClient();
    // Conectarse al servidor Socket.IO
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'httpClient': httpClient,
      'verifyCertificate': false,
      'rejectUnauthorized': false
    });

    // Manejar la conexión exitosa
    socket.on('connect', (_) {
      print('Conectado al servidor Socket.IO');
    });

    // Manejar errores de conexión
    socket.on('connect_error', (data) {
      print('Error de conexión: $data');
    });

    // Manejar cierre de la conexión
    socket.on('disconnect', (_) {
      print('Desconectado del servidor Socket.IO');
    });
  }

  // Método para conectar al servidor
  void connect() {
    socket.connect();
  }

  // Método para desconectar del servidor
  void disconnect() {
    socket.disconnect();
  }

  // Método para enviar un mensaje al servidor
  void sendMessage(String event, dynamic data) {
    socket.emit(event, data);
  }

  // Método para escuchar eventos del servidor
  void listen(String event, Function(dynamic) callback) {
    socket.on(event, (data) {
      callback(data);
    });
  }
}
