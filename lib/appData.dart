import 'package:http/http.dart' as http;

class AppData {
  static String? username;
  static String? password;

  static void saveUserData(String username, String password) {
    AppData.username = username;
    AppData.password = password;
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
