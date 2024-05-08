import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'SocketManager.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class AppData extends ChangeNotifier {
  // Variables de inicio de sesion
  //final String ip = "https://chekers.ieti.site";

  final String ip = "localhost:443";
  late SocketManager socketManager;
  AppData() {
    HttpOverrides.global = MyHttpOverrides();
    // Inicializa la instancia de SocketManager con la URL del servidor
    socketManager = SocketManager();
    // Conecta al servidor cuando se crea una instancia de AppData
    socketManager.initializeSocket();
  }

  String? username;
  String? password;

  late String token = "";
  String ipPartida = "";

  String? new_username;
  String? new_password;
  String? new_email;

  bool validate = false;
  bool play = false;
  bool pintar = true;
  // fin de variable de inicio de session

  // Variables de juego
  bool online = false;
  String player1 = "";
  String player2 = "";

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
          if (online) {
            if (turnoActual != username) {
              hacermov(socketManager.piezaSelecionada,
                  socketManager.nuevaPosicion, socketManager.posicionActual);
            } else {
              hacermov(piezaSelecionada, nuevaPosicion, posicionActual);
              socketManager.move(
                  posicionActual, nuevaPosicion, posicionActual, token);
            }
          } else {
            hacermov(piezaSelecionada, nuevaPosicion, posicionActual);
          }
          print("racha: $racha");
          if (!racha) {
            turno++;
            if (player2 == "") {
              turnoActual = "Black";
            } else {
              turnoActual == player2;
            }
          }
        }
        if (turno % 2 != 0 && piezaSelecionada.contains("n")) {
          if (online) {
            if (turnoActual != username) {
              hacermov(socketManager.piezaSelecionada,
                  socketManager.nuevaPosicion, socketManager.posicionActual);
            } else {
              hacermov(piezaSelecionada, nuevaPosicion, posicionActual);
              socketManager.move(
                  posicionActual, nuevaPosicion, posicionActual, token);
            }
          } else {
            hacermov(piezaSelecionada, nuevaPosicion, posicionActual);
          }

          print("racha: $racha");
          if (!racha) {
            turno++;
            if (player1 == "") {
              turnoActual = "Red";
            } else {
              turnoActual = player1;
            }
          }
        }
      }
    }
    esPosibleSeguir(
        piezaSelecionada, posicionActual, nuevaPosicion, numeracion, board);
    if (red == 0 || black == 0) {
      gameover = true;
    }
  }

  void hacermov(
      String piezaSelecionada, String nuevaPosicion, String posicionActual) {
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

  void esPosibleSeguir(
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

    // Determinar la dirección permitida según el tipo de ficha
    bool permitidoHaciaAdelante = ficha.contains("Q") || ficha.contains("n");
    bool permitidoHaciaAtras = ficha.contains("Q") || ficha.contains("r");

    // Diagonal hacia adelante izquierda desde la posición final
    if (permitidoHaciaAdelante) {
      int filaDiagonalAdelanteIzquierda =
          filaFinal - (filaFinal - filaInicial).abs();
      int columnaDiagonalAdelanteIzquierda =
          columnaFinal - (columnaFinal - columnaInicial).abs();
      if (filaDiagonalAdelanteIzquierda >= 0 &&
          filaDiagonalAdelanteIzquierda < numeracion.length &&
          columnaDiagonalAdelanteIzquierda >= 0 &&
          columnaDiagonalAdelanteIzquierda <
              numeracion[filaDiagonalAdelanteIzquierda].length &&
          tablero[filaDiagonalAdelanteIzquierda]
                  [columnaDiagonalAdelanteIzquierda] ==
              "-") {
        print(
            'Diagonal hacia adelante izquierda desde la posición final: ${numeracion[filaDiagonalAdelanteIzquierda][columnaDiagonalAdelanteIzquierda]}');
      } else {
        print(
            'Diagonal hacia adelante izquierda desde la posición final: No se puede seguir en esta dirección');
      }
    } else {
      print(
          'Diagonal hacia adelante izquierda desde la posición final: Movimiento no permitido');
    }

    // Diagonal hacia adelante derecha desde la posición final
    if (permitidoHaciaAdelante) {
      int filaDiagonalAdelanteDerecha =
          filaFinal - (filaFinal - filaInicial).abs();
      int columnaDiagonalAdelanteDerecha =
          columnaFinal + (columnaFinal - columnaInicial).abs();
      if (filaDiagonalAdelanteDerecha >= 0 &&
          filaDiagonalAdelanteDerecha < numeracion.length &&
          columnaDiagonalAdelanteDerecha >= 0 &&
          columnaDiagonalAdelanteDerecha <
              numeracion[filaDiagonalAdelanteDerecha].length &&
          tablero[filaDiagonalAdelanteDerecha]
                  [columnaDiagonalAdelanteDerecha] ==
              "-") {
        print(
            'Diagonal hacia adelante derecha desde la posición final: ${numeracion[filaDiagonalAdelanteDerecha][columnaDiagonalAdelanteDerecha]}');
      } else {
        print(
            'Diagonal hacia adelante derecha desde la posición final: No se puede seguir en esta dirección');
      }
    } else {
      print(
          'Diagonal hacia adelante derecha desde la posición final: Movimiento no permitido');
    }

    // Diagonal hacia atrás izquierda desde la posición final
    if (permitidoHaciaAtras) {
      int filaDiagonalAtrasIzquierda =
          filaFinal + (filaFinal - filaInicial).abs();
      int columnaDiagonalAtrasIzquierda =
          columnaFinal - (columnaFinal - columnaInicial).abs();
      if (filaDiagonalAtrasIzquierda >= 0 &&
          filaDiagonalAtrasIzquierda < numeracion.length &&
          columnaDiagonalAtrasIzquierda >= 0 &&
          columnaDiagonalAtrasIzquierda <
              numeracion[filaDiagonalAtrasIzquierda].length &&
          tablero[filaDiagonalAtrasIzquierda][columnaDiagonalAtrasIzquierda] ==
              "-") {
        print(
            'Diagonal hacia atrás izquierda desde la posición final: ${numeracion[filaDiagonalAtrasIzquierda][columnaDiagonalAtrasIzquierda]}');
      } else {
        print(
            'Diagonal hacia atrás izquierda desde la posición final: No se puede seguir en esta dirección');
      }
    } else {
      print(
          'Diagonal hacia atrás izquierda desde la posición final: Movimiento no permitido');
    }

    // Diagonal hacia atrás derecha desde la posición final
    if (permitidoHaciaAtras) {
      int filaDiagonalAtrasDerecha =
          filaFinal + (filaFinal - filaInicial).abs();
      int columnaDiagonalAtrasDerecha =
          columnaFinal + (columnaFinal - columnaInicial).abs();
      if (filaDiagonalAtrasDerecha >= 0 &&
          filaDiagonalAtrasDerecha < numeracion.length &&
          columnaDiagonalAtrasDerecha >= 0 &&
          columnaDiagonalAtrasDerecha <
              numeracion[filaDiagonalAtrasDerecha].length &&
          tablero[filaDiagonalAtrasDerecha][columnaDiagonalAtrasDerecha] ==
              "-") {
        print(
            'Diagonal hacia atrás derecha desde la posición final: ${numeracion[filaDiagonalAtrasDerecha][columnaDiagonalAtrasDerecha]}');
      } else {
        print(
            'Diagonal hacia atrás derecha desde la posición final: No se puede seguir en esta dirección');
      }
    } else {
      print(
          'Diagonal hacia atrás derecha desde la posición final: Movimiento no permitido');
    }
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
    if ((ficha.contains("r") && turno % 2 != 0) ||
        (ficha.contains("n") && turno % 2 == 0)) {
      return false;
    }
    if (ficha.contains("Q")) {
      if (difFilas == difColumnas) {
        if (difFilas == 1) {
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

              return true; // Movimiento válido con casilla intermedia ocupada
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
            }
            if (tablero[filaIntermedia][columnaIntermedia].startsWith("n")) {
              black--;
            }

            // Actualizar el tablero: la casilla intermedia se convierte en "-"
            tablero[filaIntermedia][columnaIntermedia] = "-";

            return true; // Movimiento válido en diagonal con casilla intermedia ocupada
          }
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
    CreateUserSend(ip, new_username, new_password, new_email);
  }

  Future<void> CreateUserSend(
      String serverUrl, String username, String password, String email) async {
    try {
      // Configura el cliente HTTP para que acepte todos los certificados
      HttpClient client = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);

      final response = await client
          .postUrl(Uri.parse('https://$serverUrl/api/users'))
          .then((HttpClientRequest request) {
        // Establece el encabezado Content-Type a application/json
        request.headers.set('Content-Type', 'application/json');
        // Convierte los datos a JSON
        String jsonData = json.encode({
          'name': username,
          'password': password,
          'email': email,
        });
        // Agrega los datos al cuerpo de la solicitud
        request.write(jsonData);
        // Envía la solicitud y espera la respuesta
        return request.close();
      });

      if (response.statusCode == 200) {
        // Procesar la respuesta si es exitosa
        print('Usuario Creado');
        notifyListeners();
      } else {
        // Manejar errores si la solicitud no es exitosa
        print(response.statusCode);
      }
    } catch (error) {
      // Manejar errores de conexión
      print('Error de conexión: $error');
    }
  }

  void saveUser(String username, String password) {
    this.username = username;
    this.password = password;
    loginUser(ip, username, password);
  }

  Future<void> loginUser(
      String serverUrl, String email, String password) async {
    try {
      // Configura el cliente HTTP para que acepte todos los certificados
      HttpClient client = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);

      final response = await client
          .postUrl(Uri.parse('https://$serverUrl/api/authenticate'))
          .then((HttpClientRequest request) {
        // Establece el encabezado Content-Type a application/json
        request.headers.set('Content-Type', 'application/json');
        // Convierte los datos a JSON
        String jsonData = json.encode({
          'email': email,
          'password': password,
        });
        // Agrega los datos al cuerpo de la solicitud
        request.write(jsonData);
        // Envía la solicitud y espera la respuesta
        return request.close();
      });

      // Lee el cuerpo de la respuesta como una cadena de texto
      String responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        // Parsea la respuesta JSON
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        // Extrae el token del JSON
        token = jsonResponse['token'];
        print('Token recibido: $token');
        socketManager.getNewToken(token);

        // Imprime el token recibido

        // Procesar la respuesta si es exitosa
        print('Usuario autenticado');
        validate = true;
        notifyListeners();
      } else {
        // Manejar errores si la solicitud no es exitosa
        print('Error al autenticar usuario: $responseBody');
      }
    } catch (error) {
      // Manejar errores de conexión
      print('Error de conexión: $error');
    }
  }

// Fin de inicio de session
// Funciones de jugabilidad en linea

  void assignarPlayers() {
    player1 = socketManager.player1;
    player2 = socketManager.player2;
    turnoActual = player1;
    play = socketManager.play;
    String output = "Player1 = $player1 \n Player2 = $player2";
    print(output);
  }
}
