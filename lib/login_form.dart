import 'package:checker/appData.dart';
import 'package:flutter/material.dart';
import 'create_user_page.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          ElevatedButton(
            onPressed: () {
              // Guardar las variables utilizando la función de AppData
              AppData.saveUserData(
                  _usernameController.text, _passwordController.text);

              // Lógica para iniciar sesión

              // Vaciar los campos de texto
              _usernameController.clear();
              _passwordController.clear();
            },
            child: Text('Iniciar sesión'),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateUserPage()),
              );
            },
            child: Text('Crear usuario'),
          ),
        ],
      ),
    );
  }
}
