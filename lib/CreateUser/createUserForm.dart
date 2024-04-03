import 'package:checker/Login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:checker/appData.dart';
import 'package:provider/provider.dart';

class CreateUserPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    //var appData = Provider.of<AppData>(context);

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Usuario'),
            style: const TextStyle(
              fontFamily: 'Roboto', // Establece la fuente como Roboto
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            style: const TextStyle(
              fontFamily: 'Roboto', // Establece la fuente como Roboto
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _repeatPasswordController,
            decoration: const InputDecoration(labelText: 'Repetir Contraseña'),
            style: const TextStyle(
              fontFamily: 'Roboto', // Establece la fuente como Roboto
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Correo'),
            style: const TextStyle(
              fontFamily: 'Roboto', // Establece la fuente como Roboto
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Provider.of<AppData>(context, listen: false).CreateUser(
                  _usernameController.text,
                  _passwordController.text,
                  _emailController.text);

              _emailController.clear();
              _passwordController.clear();
              _repeatPasswordController.clear();
              _usernameController.clear();
              // Lógica para crear _usuario

              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.grey, backgroundColor: Colors.black,
              side: BorderSide(color: Colors.red), // Borde rojo
            ),
            child: const Text(
              'Crear usuario',
              style: TextStyle(
                fontFamily: 'Roboto', // Establece la fuente como Roboto
              ),
            ),
          ),
        ],
      ),
    );
  }
}
