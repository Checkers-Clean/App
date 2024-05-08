// SocketManager.dart

import 'dart:async';

import 'package:checker/appData.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';
import 'dart:convert'; // Importar para poder decodificar JSON

class SocketManager {
  // URL del servidor Socket.IO
  final String serverUrl = 'https://localhost:443';
  // Cliente Socket.IO
  late IO.Socket socket;
  String partida = "";
  String token = "";
  late String nuevaPosicion, piezaSelecionada, posicionActual;

  String player1 = "";
  String player2 = "";
  final _playersController = StreamController<Map<String, String>>();
  bool play = false;

  Stream<Map<String, String>> get playersStream => _playersController.stream;

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
    socket.on('jugador-unido-sala', (mensaje) {
      print('Mensaje recibido del servidor: $mensaje');
      // Transformar el string en JSON

      // Guardar el valor del tag 'gameId' en partida
    });
    socket.on('sala-creada', (mensaje) {
      print('Mensaje sala creada del servidor: $mensaje');
      // Transformar el string en JSON

      // Guardar el valor del tag 'gameId' en partida
      partida = mensaje['gameId'];
      print(partida);
    });

    socket.on('inicio-de-partida', (mensaje) {
      print('Mensaje inicio del servidor: $mensaje');

      // Transformar el string en JSON
      player1 = mensaje['player1'];
      player2 = mensaje['player2'];

      _playersController.add({'player1': player1, 'player2': player2});
      play = true;
      // Guardar el valor del tag 'gameId' en partida
    });
    socket.on('move', (mensaje) {
      print('Mensaje recibido del servidor: $mensaje');
      // Transformar el string en JSON

      // Guardar el valor del tag 'gameId' en partida
      piezaSelecionada = mensaje['piezaSelecionada'];
      nuevaPosicion = mensaje['nuevaPosicion'];
      posicionActual = mensaje['posicionActual'];
    });

    socket.on('jugador-unido-sala', (mensaje) {
      print('Mensaje unirse a sala del servidor: $mensaje');
      // Transformar el string en JSON
      partida = mensaje;
      print(partida);
      // Guardar el valor del tag 'gameId' en partida
    });
    socket.on('tokenUpdated', (mensaje) {
      print('Mensaje token 1 del servidor: $mensaje');
      // Transformar el string en JSON
      token = mensaje;
      // Guardar el valor del tag 'gameId' en partida
    });
    socket.on('token-actualizado-id-game', (mensaje) {
      print('Mensaje token 2 del servidor: $mensaje');
      // Transformar el string en JSON
      token = mensaje;
      // Guardar el valor del tag 'gameId' en partida
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

  void move(String posint, String postfin, String ficha, String token) {
    // Crear un mapa con roomName y token
    Map<String, dynamic> data = {
      'posint': posint,
      'postfin': postfin,
      'ficha': ficha,
      'token': token,
    };

    // Convertir el mapa a una cadena JSON
    String jsonData = json.encode(data);

    // Enviar el JSON al servidor para unirse a una sala
    socket.emit('move', jsonData);
  }

  // Método para salir de una sala en el servidor
  void leaveRoom(String roomName, String token) {
    Map<String, dynamic> data = {
      'id_game': roomName,
      'token': token,
    };

    String jsonData = json.encode(data);
    // Enviar un evento al servidor para salir de una sala
    socket.emit('salir-de-sala', jsonData);
  }

  void createRome(String token) {
    // Enviar un evento al servidor para salir de una sala
    socket.emit('crear-sala', token);
  }

  // Método para salir de una sala en el servidor
  void getNewToken(String token) {
    // Enviar un evento al servidor para salir de una sala
    socket.emit('token', token);
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
