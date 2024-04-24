// SocketManager.dart

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';
import 'dart:convert'; // Importar para poder decodificar JSON

class SocketManager {
  // URL del servidor Socket.IO
  final String serverUrl = 'https://localhost:443';
  // Cliente Socket.IO
  late IO.Socket socket;
  String partida = "";

  // Método para inicializar la conexión con el servidor
  void initializeSocket() {
    // Inicializar el cliente Socket.IO y conectar al servidor
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false, // Desactivar la conexión automática
    });
    socket.connect();

    // Manejar los eventos de mensaje recibido
    socket.on('message', (data) {
      print('Mensaje recibido: $data');
    });

    // Manejar el evento 'unirse-a-sala'
    // Manejar el evento 'sala-creada'
    socket.on('sala-creada', (mensaje) {
      print('Mensaje recibido del servidor: $mensaje');
      // Transformar el string en JSON

      // Guardar el valor del tag 'gameId' en partida
      partida = mensaje['gameId'];
      print(partida);
    });

    socket.on('sala-creada', (mensaje) {
      print('Mensaje recibido del servidor: $mensaje');
      // Transformar el string en JSON

      // Guardar el valor del tag 'gameId' en partida
      partida = mensaje['gameId'];
      print(partida);
    });

    // Manejar el evento 'prueba' y enviar una respuesta
    socket.on('prueba', (mensaje) {
      print('Mensaje recibido del servidor: $mensaje');
    });
  }

  // Método para enviar un mensaje al servidor
  void sendMessage(String message) {
    // Enviar un mensaje al servidor
    socket.emit('message', message);
  }

  // Método para unirse a una sala en el servidor
  void joinRoom(String roomName, String token) {
    // Crear un mapa con roomName y token
    Map<String, dynamic> data = {
      'id_game': roomName,
      'token': token,
    };

    // Convertir el mapa a una cadena JSON
    String jsonData = json.encode(data);

    // Enviar el JSON al servidor para unirse a una sala
    socket.emit('unirse-a-sala', jsonData);
  }

  // Método para salir de una sala en el servidor
  void leaveRoom(String roomName) {
    // Enviar un evento al servidor para salir de una sala
    socket.emit('salir-de-sala', roomName);
  }

  // Método para salir de una sala en el servidor
  void createRome(String roomName) {
    // Enviar un evento al servidor para salir de una sala
    socket.emit('crear-sala', roomName);
  }

  // Método para enviar un mensaje de prueba al servidor y manejar la respuesta
  void sendTestMessage(String message) {
    // Enviar un evento de prueba al servidor
    socket.emit('prueba', message);
  }

  // Método para desconectar el cliente Socket.IO
  void disconnect() {
    // Desconectar el cliente Socket.IO al cerrar la aplicación
    socket.disconnect();
  }
}
