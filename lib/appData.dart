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
  String turnoActual = "Red";
  int red = 12;
  int black = 12;
  int turno = 0;
  bool racha = false;
  bool gameover = false;
  bool queen = false;

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
    red = 12;
    black = 12;
    turno = 0;
    racha = false;
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
          if (!racha) {
            turno++;
            turnoActual = "Black";
          }
        }
        if (turno % 2 != 0 && piezaSelecionada.contains("n")) {
          hacermov(piezaSelecionada, nuevaPosicion);
          if (!racha) {
            turno++;
            turnoActual = "Red";
          }
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
            if (!piezaSelecionada.contains("Q")) {
              piezaSelecionada = "Q" + piezaSelecionada;
              queen = true;
            }
          }

          // Verificar si la posición final es la fila 8 y la pieza contiene "r"
          if (nuevaFila == 7 && piezaSelecionada.contains('r')) {
            if (!piezaSelecionada.contains("Q")) {
              piezaSelecionada = "Q" + piezaSelecionada;
              queen = true;
            }
          }
          board[nuevaFila][nuevaColumna] = piezaSelecionada;
          if (queen) {
            racha = false;
            queen = false;
          }

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

  bool esPosibleSeguir(
      String ficha,
      String posicionInicial,
      String posicionFinal,
      List<List<String>> numeracion,
      List<List<String>> tablero) {
    // Obtener las coordenadas de la posición inicial y final
    int filaInicial =
        numeracion.indexWhere((fila) => fila.contains(posicionInicial));
    int columnaInicial = numeracion[filaInicial].indexOf(posicionInicial);
    int filaFinal =
        numeracion.indexWhere((fila) => fila.contains(posicionFinal));
    int columnaFinal = numeracion[filaFinal].indexOf(posicionFinal);
    esMovimentoBack(
        ficha, filaInicial, columnaInicial, filaFinal, columnaFinal);
    // Calcular la diferencia entre las filas y columnas
    int difFilas = (filaFinal - filaInicial).abs();
    int difColumnas = (columnaFinal - columnaInicial).abs();
    print("lado 1: " + tablero[difFilas + 1][difColumnas + 1]);
    print("lado 1: " + tablero[difFilas + 1][difColumnas + 1]);

    return false;
  }

  bool esMovimientoValido(
      String ficha,
      String posicionInicial,
      String posicionFinal,
      List<List<String>> numeracion,
      List<List<String>> tablero) {
    // Obtener las coordenadas de la posición inicial y final
    int filaInicial =
        numeracion.indexWhere((fila) => fila.contains(posicionInicial));
    int columnaInicial = numeracion[filaInicial].indexOf(posicionInicial);
    int filaFinal =
        numeracion.indexWhere((fila) => fila.contains(posicionFinal));
    int columnaFinal = numeracion[filaFinal].indexOf(posicionFinal);
    esMovimentoBack(
        ficha, filaInicial, columnaInicial, filaFinal, columnaFinal);
    // Calcular la diferencia entre las filas y columnas
    int difFilas = (filaFinal - filaInicial).abs();
    int difColumnas = (columnaFinal - columnaInicial).abs();
    if (ficha.contains("Q")) {
      if (difFilas == difColumnas) {
        if (difFilas == 1) {
          if (racha) {
            return false;
          }
          return true; // Movimiento válido en diagonal
        } else {
          // Verificar casillas intermedias en movimientos diagonales
          int pasoFila = (filaFinal - filaInicial).sign;
          int pasoColumna = (columnaFinal - columnaInicial).sign;
          for (int i = 1; i < difFilas; i++) {
            int filaIntermedia = filaInicial + pasoFila * i;
            int columnaIntermedia = columnaInicial + pasoColumna * i;

            if (tablero[filaIntermedia][columnaIntermedia] != "-") {
              if (tablero[filaIntermedia][columnaIntermedia].startsWith("r")) {
                red--;
              }
              if (tablero[filaIntermedia][columnaIntermedia].startsWith("n")) {
                black--;
              }
              // Actualizar el tablero: la casilla intermedia se convierte en "-"
              tablero[filaIntermedia][columnaIntermedia] = "-";

              racha = true;

              return true; // Movimiento válido con casilla intermedia ocupada
            } else {
              racha = false;
            }
          }
          return true; // Movimiento válido en diagonal
        }
      }
    } else {
      // Verificar si el movimiento es diagonal
      if (difFilas == difColumnas &&
          !esMovimentoBack(
              ficha, filaInicial, columnaInicial, filaFinal, columnaFinal)) {
        // Verificar si el movimiento es válido según las reglas del juego
        print('diferencia de filas $difFilas');
        if (difFilas == 1) {
          if (racha) {
            return false;
          }
          return true; // Movimiento válido en diagonal
        }
        if (difFilas == 2) {
          // Calcular las coordenadas de la casilla intermedia
          int filaIntermedia = (filaInicial + filaFinal) ~/ 2;
          int columnaIntermedia = (columnaInicial + columnaFinal) ~/ 2;
          print("intermedio: " + tablero[filaIntermedia][columnaIntermedia]);

          // Verificar si la casilla intermedia contiene una ficha
          if (tablero[filaIntermedia][columnaIntermedia] != "-") {
            if (tablero[filaIntermedia][columnaIntermedia].startsWith("r")) {
              red--;
              racha = true;
            }
            if (tablero[filaIntermedia][columnaIntermedia].startsWith("n")) {
              black--;
              racha = true;
            }

            // Actualizar el tablero: la casilla intermedia se convierte en "-"
            tablero[filaIntermedia][columnaIntermedia] = "-";
            esPosibleSeguir(
                ficha, posicionInicial, posicionFinal, numeracion, tablero);
            return true; // Movimiento válido en diagonal con casilla intermedia ocupada
          }
        } else {
          racha = false;
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
        Uri.parse('http://$serverUrl/createUser'),
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

// Fin de Funciones de inicio de session

// Funciones de jugabilidad en linea
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

  Future<void> recivirTurno(
      String serverUrl, String posicion, String password) async {
    try {
      final response = await http.get(
        Uri.parse('http://$serverUrl/api/game/iniciarPartida'),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String turno = jsonResponse['turn'];
        turnoActual = turno;

        print('Turno recibido: $turno');
      } else {
        print('Error al recibir turno del servidor');
      }
    } catch (error) {
      // Manejar errores de conexión
      print('Error de conexión: $error');
    }
  }
}
