import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appData.dart';
import '../CreateUser/createPage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
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
              foregroundColor: Colors.grey, backgroundColor: Colors.black,
              side: const BorderSide(color: Colors.red), // Borde rojo
            ),
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontFamily: 'Roboto', // Establece la fuente como Roboto
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.grey, backgroundColor: Colors.black,
              side: const BorderSide(color: Colors.red), // Borde rojo
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
