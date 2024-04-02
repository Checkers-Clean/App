import 'package:checker/appData.dart';
import 'package:checker/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  AppData.colocarfichas(AppData.piezasRojas, "r12", "h3");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black, // Color de fondo de la barra de navegación
        scaffoldBackgroundColor: Colors.black, // Color de fondo de la pantalla
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white), // Color del texto
          bodyText2: TextStyle(color: Colors.white), // Color del texto
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Color del botón
            textStyle:
                TextStyle(color: Colors.white), // Color del texto del botón
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
              color:
                  Colors.white), // Color del texto de las etiquetas de entrada
          hintStyle: TextStyle(
              color: Colors.grey), // Color del texto de sugerencia de entrada
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey), // Color del borde cuando está habilitado
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red), // Color del borde cuando está enfocado
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
