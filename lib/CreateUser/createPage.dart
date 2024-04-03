import 'package:checker/CreateUser/createUserForm.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Usuario',
            style: TextStyle(color: Colors.grey)), // Color del texto blanco
        backgroundColor: Colors.black, // Fondo negro
        elevation: 0, // Elimina la sombra de la barra de aplicación
      ),
      backgroundColor: Colors.black, // Fondo negro del Scaffold
      body: CreateUserPage(),
    );
  }
}
