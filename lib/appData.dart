import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppData extends ChangeNotifier {
  // Variables de inicio de sesion
  String? username;
  String? password;

  String? new_username;
  String? new_password;
  String? new_email;

  bool validate = false;
  // fin de variable de inicio de session

  // Variables de juego
  int red = 1;
  int black = 1;
  int turno = 0;
  int racha = 0;
  bool gameover = false;

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

  //fin de Variables de juego

  // Funciones de juego
  void reset() {
    gameover = false;
    red = 1;
    black = 1;
    turno = 0;
    racha = 0;
    board = board_inicio;
    print("fichas rojas $red, fichas negras $black");
  }

  void printerboard() {
    for (var fila = 0; fila < board.length; fila++) {
      print(board[fila]);
    }
  }

  void colocarfichas(String piezaSelecionada, String posicionActual,
      String nuevaPosicion, String nuevaPosicionNombre) {
    if (piezaSelecionada != "-" && nuevaPosicionNombre == "-") {
      if (piezaSelecionada != nuevaPosicionNombre &&
          esMovimientoValido(piezaSelecionada, posicionActual, nuevaPosicion,
              numeracion, board)) {
        if (turno % 2 == 0 && piezaSelecionada.contains("r")) {
          hacermov(piezaSelecionada, nuevaPosicion);
          turno++;
        }
        if (turno % 2 != 0 && piezaSelecionada.contains("n")) {
          hacermov(piezaSelecionada, nuevaPosicion);
          turno++;
        }
      }
    }
    if (red == 0 || black == 0) {
      gameover = true;
    }
  }

  void hacermov(String piezaSelecionada, String nuevaPosicion) {
    for (var fila = 0; fila < board.length; fila++) {
      for (var columna = 0; columna < board[fila].length; columna++) {
        if (board[fila][columna] == piezaSelecionada) {
          // Cambiar la posición de la pieza en el tablero
          board[fila][columna] = '-';
          // Encontrar las coordenadas de la nueva posición
          int nuevaFila = int.parse(nuevaPosicion[1]) - 1;
          int nuevaColumna = nuevaPosicion.codeUnitAt(0) - 'a'.codeUnitAt(0);
          // Colocar la pieza en la nueva posición

          // Verificar si la posición final es la fila 1 y la pieza contiene "n"
          if (nuevaFila == 0 && piezaSelecionada.contains('n')) {
            print("reina");
            piezaSelecionada = "Q" + piezaSelecionada;
          }

          // Verificar si la posición final es la fila 8 y la pieza contiene "r"
          if (nuevaFila == 7 && piezaSelecionada.contains('r')) {
            // Realizar una acción específica
            // Por ejemplo, eliminar la pieza
            // board[nuevaFila][nuevaColumna] = '-';
            piezaSelecionada = "Q" + piezaSelecionada;
          }
          board[nuevaFila][nuevaColumna] = piezaSelecionada;

          notifyListeners();
        }
      }
    }
  }

  bool esMovimentoBack(String ficha, int filaInicial, int columnaInicial,
      int filaFinal, int columnaFinal) {
    if (ficha.contains("r")) {
      if (filaInicial > filaFinal) {
        return true;
      }
    }
    if (ficha.contains("N")) {
      if (filaFinal > filaInicial) {
        return true;
      }
    }
    return false;
  }

  bool esPosibleMovimientoEnDiagonal(String ficha, String posicion,
      List<List<String>> numeracion, List<List<String>> tablero) {
    // Obtener las coordenadas de la posición
    int fila = numeracion.indexWhere((fila) => fila.contains(posicion));
    int columna = numeracion[fila].indexOf(posicion);

    // Verificar si es posible realizar el movimiento en alguna dirección diagonal
    for (int i = -1; i <= 1; i += 2) {
      for (int j = -1; j <= 1; j += 2) {
        // Calcular la posición final en la diagonal actual
        int filaFinal = fila + i * 2;
        int columnaFinal = columna + j * 2;

        // Verificar si la posición final está dentro del tablero
        if (filaFinal >= 0 &&
            filaFinal < numeracion.length &&
            columnaFinal >= 0 &&
            columnaFinal < numeracion[filaFinal].length) {
          // Verificar si hay una ficha en la posición intermedia
          int filaIntermedia = fila + i;
          int columnaIntermedia = columna + j;
          if (tablero[filaIntermedia][columnaIntermedia] != "-") {
            // Verificar si la ficha es "r" y la posición final es mayor o igual que la inicial
            if (ficha == "r" && filaFinal >= fila) {
              return false; // No es posible realizar el movimiento en esta dirección diagonal
            }
            // Verificar si la ficha es "n" y la posición final es menor que la inicial
            if (ficha == "n" && filaFinal <= fila) {
              return false; // No es posible realizar el movimiento en esta dirección diagonal
            }
            return true; // Se puede realizar el movimiento en esta dirección diagonal
          }
        }
      }
    }

    return false; // No es posible realizar el movimiento en ninguna dirección diagonal
  }

  bool esMovimientoValido(String ficha, posicionInicial, String posicionFinal,
      List<List<String>> numeracion, List<List<String>> tablero) {
    // Obtener las coordenadas de la posición inicial y final
    int filaInicial =
        numeracion.indexWhere((fila) => fila.contains(posicionInicial));
    int columnaInicial = numeracion[filaInicial].indexOf(posicionInicial);
    int filaFinal =
        numeracion.indexWhere((fila) => fila.contains(posicionFinal));
    int columnaFinal = numeracion[filaFinal].indexOf(posicionFinal);

    // Calcular la diferencia entre las filas y columnas
    esMovimentoBack(
        ficha, filaInicial, columnaInicial, filaFinal, columnaFinal);
    int difFilas = (filaFinal - filaInicial).abs();
    int difColumnas = (columnaFinal - columnaInicial).abs();

    // Verificar si el movimiento es diagonal
    if (difFilas == difColumnas &&
        !esMovimentoBack(
            ficha, filaInicial, columnaInicial, filaFinal, columnaFinal)) {
      // Verificar si el movimiento es válido según las reglas del juego
      print('diferencia de filas $difFilas');
      if (difFilas == 1) {
        return true; // Movimiento válido en diagonal
      }
      if (difFilas == 2) {
        // Calcular las coordenadas de la casilla intermedia
        int filaIntermedia = (filaInicial + filaFinal) ~/ 2;
        int columnaIntermedia = (columnaInicial + columnaFinal) ~/ 2;

        // Verificar si la casilla intermedia contiene una ficha
        if (tablero[filaIntermedia][columnaIntermedia] != "-") {
          if (tablero[filaIntermedia][columnaIntermedia].startsWith("r")) {
            red--;
          }
          if (tablero[filaIntermedia][columnaIntermedia].startsWith("n")) {
            black--;
          }

          // Actualizar el tablero: la casilla intermedia se convierte en "-"
          tablero[filaIntermedia][columnaIntermedia] = "-";
          racha++;
          return true; // Movimiento válido en diagonal con casilla intermedia ocupada
        }
      }
    }

    return false; // Movimiento inválido
  }

  // Fin de variables de juego

  // Funciones de inicio de session

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

  Future<void> enviarMove(
      String serverUrl, String posicion, String password) async {
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


// Fin de Funciones de inicio de session
