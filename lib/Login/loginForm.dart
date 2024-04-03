import 'package:checker/GameSreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appData.dart';
import '../CreateUser/createPage.dart';
import '../CreateUser/createUserForm.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          ElevatedButton(
            onPressed: () {
              // Guardar las variables utilizando la función de AppData
              Provider.of<AppData>(context, listen: false).saveUser(
                _usernameController.text,
                _passwordController.text,
              );

              // Vaciar los campos de texto
              _usernameController.clear();
              _passwordController.clear();

              // Lógica para iniciar sesión
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.black,
              side: BorderSide(color: Colors.red), // Borde rojo
            ),
            child: Text('Iniciar sesión'),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePage()),
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
