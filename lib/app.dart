import 'package:checker/GameSreen.dart';
import 'package:checker/MainMenu/mainMenuForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainMenu/maniManuPage.dart';
import 'appData.dart';
import 'Login/loginPage.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);

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
      home: appData.validate ? MainMenuPage() : LoginPage(),
    );
  }
}
