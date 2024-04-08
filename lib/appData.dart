import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppData extends ChangeNotifier {
  List<List<String>> numeracion = [
    ['a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1'],
    ['a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2'],
    ['a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3'],
    ['a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4'],
    ['a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5'],
    ['a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6'],
    ['a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7'],
    ['a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8']
  ];
  List<List<String>> board_inicio = [
    ['r1', '-', 'r2', '-', 'r3', '-', 'r4', '-'],
    ['-', 'r5', '-', 'r6', '-', 'r7', '-', 'r8'],
    ['r9', '-', 'r10', '-', 'r11', '-', 'r12', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', 'n12', '-', 'n11', '-', 'n10', '-', 'n9'],
    ['n8', '-', 'n7', '-', 'n6', '-', 'n5', '-'],
    ['-', 'n4', '-', 'n3', '-', 'n2', '-', 'n1']
  ];
  List<List<String>> board = [
    ['r1', '-', 'r2', '-', 'r3', '-', 'r4', '-'],
    ['-', 'r5', '-', 'r6', '-', 'r7', '-', 'r8'],
    ['r9', '-', 'r10', '-', 'r11', '-', 'r12', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', 'n12', '-', 'n11', '-', 'n10', '-', 'n9'],
    ['n8', '-', 'n7', '-', 'n6', '-', 'n5', '-'],
    ['-', 'n4', '-', 'n3', '-', 'n2', '-', 'n1']
  ];

  List<List<String>> fichasRojas = [
    ['r1', 'a1'],
    ['r2', 'c1'],
    ['r3', 'e1'],
    ['r4', 'g1'],
    ['r5', 'b2'],
    ['r6', 'd2'],
    ['r7', 'f2'],
    ['r8', 'h2'],
    ['r9', 'a3'],
    ['r10', 'c3'],
    ['r11', 'e3'],
    ['r12', 'g3']
  ];

  List<List<String>> fichasNegras = [
    ['n1', 'a6'],
    ['n2', 'c6'],
    ['n3', 'e6'],
    ['n4', 'g6'],
    ['n5', 'b7'],
    ['n6', 'd7'],
    ['n7', 'f7'],
    ['n8', 'h7'],
    ['n9', 'a8'],
    ['n10', 'c8'],
    ['n11', 'e8'],
    ['n12', 'g8']
  ];

  void printerboard() {
    for (var fila = 0; fila < board.length; fila++) {
      print(board[fila]);
    }
  }

  void colocarfichas(
      String piezaSelecionada, String posicionActual, String nuevaPosicion) {
    if (esMovimientoValido(posicionActual, nuevaPosicion)) {
      for (var fila = 0; fila < board.length; fila++) {
        for (var columna = 0; columna < board[fila].length; columna++) {
          if (board[fila][columna] == piezaSelecionada) {
            // Cambiar la posición de la pieza en el tablero
            board[fila][columna] = '-';
            // Encontrar las coordenadas de la nueva posición
            int nuevaFila = int.parse(nuevaPosicion[1]) - 1;
            int nuevaColumna = nuevaPosicion.codeUnitAt(0) - 'a'.codeUnitAt(0);
            // Colocar la pieza en la nueva posición
            board[nuevaFila][nuevaColumna] = piezaSelecionada;
            notifyListeners();
          }
        }
      }
    }
  }

  bool esMovimientoValido(String posicionInicial, String posicionFinal) {
    // Obtener las coordenadas de la posición inicial y final
    int filaInicial = int.parse(posicionInicial[1]);
    int columnaInicial = posicionInicial.codeUnitAt(0) - 'a'.codeUnitAt(0);
    int filaFinal = int.parse(posicionFinal[1]);
    int columnaFinal = posicionFinal.codeUnitAt(0) - 'a'.codeUnitAt(0);

    // Calcular la diferencia entre las filas y columnas
    int difFilas = (filaFinal - filaInicial).abs();
    int difColumnas = (columnaFinal - columnaInicial).abs();

    // Verificar si el movimiento es diagonal
    if (difFilas == difColumnas) {
      // Verificar si el movimiento es válido según las reglas del juego
      if (difFilas == 1) {
        return true; // Movimiento válido en diagonal
      }
    }

    // Si no es un movimiento válido en diagonal
    return false;
  }

  String? username;
  String? password;

  String? new_username;
  String? new_password;
  String? new_email;

  bool validate = false;

  void CreateUser(String new_username, String new_password, String new_email) {
    this.new_username = new_username;
    this.new_password = new_password;
    this.new_email = new_email;
    CreateUserSend("localhost:3000", new_username, new_password, new_email);
  }

  Future<void> CreateUserSend(
      String serverUrl, String username, String password, String email) async {
    try {
      final response = await http.post(
        Uri.parse('http://$serverUrl/CreateUser'),
        body: {
          'username': username,
          'password': password,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        // Procesar la respuesta si es exitosa
        print('Usuario Creado');

        notifyListeners();
      } else {
        // Manejar errores si la solicitud no es exitosa
        print('Error al autenticar usuario');
      }
    } catch (error) {
      // Manejar errores de conexión
      print('Error de conexión: $error');
    }
  }

  void saveUser(String username, String password) {
    this.username = username;
    this.password = password;
    loginUser("localhost:3000", username, password);
  }

  Future<void> loginUser(
      String serverUrl, String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://$serverUrl/login'),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Procesar la respuesta si es exitosa
        print('Usuario autenticado');
        validate = true;
        notifyListeners();
      } else {
        // Manejar errores si la solicitud no es exitosa
        print('Error al autenticar usuario');
      }
    } catch (error) {
      // Manejar errores de conexión
      print('Error de conexión: $error');
    }
  }
}
