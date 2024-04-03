import 'package:checker/GameSreen.dart';
import 'package:checker/Login/loginForm.dart';
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

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Usuario'),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _repeatPasswordController,
            decoration: InputDecoration(labelText: 'Repetir Contraseña'),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Correo'),
          ),
          SizedBox(height: 20.0),
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
              foregroundColor: Colors.white, backgroundColor: Colors.black,
              side: BorderSide(color: Colors.red), // Borde rojo
            ),
            child: Text('Crear usuario'),
          ),
        ],
      ),
    );
  }
}
