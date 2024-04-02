import 'package:http/http.dart' as http;

class AppData {
  static List<List<String>> numeracion = [
    ['a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1'],
    ['a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2'],
    ['a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3'],
    ['a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4'],
    ['a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5'],
    ['a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6'],
    ['a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7'],
    ['a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8']
  ];
  static List<List<String>> board = [
    ['r1', '-', 'r2', '-', 'r3', '-', 'r4', '-'],
    ['-', 'r5', '-', 'r6', '-', 'r7', '-', 'r8'],
    ['r9', '-', 'r10', '-', 'r11', '-', 'r12', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-', '-', '-'],
    ['-', 'n12', '-', 'n11', '-', 'n10', '-', 'n9'],
    ['n8', '-', 'n7', '-', 'n6', '-', 'n5', '-'],
    ['-', 'n4', '-', 'n3', '-', 'n2', '-', 'n1']
  ];

  static List<List<String>> piezasRojas = [
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

  static List<List<String>> piezasNegras = [
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

  static void colocarfichas(List<List<String>> piezas, String piezaSelecionada,
      String NuevaPosicion) {
    for (var pieza in piezas) {
      if (pieza[0] == piezaSelecionada) {
        bool esPosible = esMovimientoValido(pieza[1], NuevaPosicion);
        print('Pieza: ${pieza[0]}, Coordenada: ${pieza[1]}');
        print(esPosible);
      }
    }
  }

  static bool esMovimientoValido(String posicionInicial, String posicionFinal) {
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

  static String? username;
  static String? password;

  static String? new_username;
  static String? new_password;
  static String? new_email;

  static void saveUserData(String username, String password) {
    AppData.username = username;
    AppData.password = password;
  }

  static void CreateUser(
      String new_username, String new_password, String new_email) {
    AppData.new_username = new_username;
    AppData.new_password = new_password;
    AppData.new_email = new_email;
  }

  static Future<void> loginUser() async {
    try {
      final response = await http.post(
        Uri.parse('http://tu_servidor_nodejs.com/login'),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Procesar la respuesta si es exitosa
        print('Usuario autenticado');
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
