import 'package:flutter/material.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',
            style: TextStyle(color: Colors.white)), // Color del texto blanco
        backgroundColor: Colors.black, // Fondo negro
        elevation: 0, // Elimina la sombra de la barra de aplicación
      ),
      backgroundColor: Colors.black, // Fondo negro del Scaffold
      body: LoginForm(),
    );
  }
}
