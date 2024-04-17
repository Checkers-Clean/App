import 'package:checker/Game/gamePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LobbyForm extends StatefulWidget {
  @override
  _LobbyFormState createState() => _LobbyFormState();
}

class _LobbyFormState extends State<LobbyForm> {
  List<String> lobbyNames = [];

  void _createLobby(String name) {
    setState(() {
      lobbyNames.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lobby', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.black, // Fondo negro
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navegar a la página de creación de lobby
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateLobbyPage(onCreate: _createLobby),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: lobbyNames.length,
        itemBuilder: (context, index) {
          return CustomButton(
            buttonText: lobbyNames[index],
            onPressed: () {
              // Acción al presionar un botón de lobby existente
              print('Botón ${lobbyNames[index]} presionado');
            },
          );
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
}

class CreateLobbyPage extends StatelessWidget {
  final Function(String) onCreate;
  final TextEditingController _textController = TextEditingController();

  CreateLobbyPage({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Lobby'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre del lobby',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final lobbyName = _textController.text;
                if (lobbyName.isNotEmpty) {
                  // Llamar a la función onCreate para añadir el lobby
                  onCreate(lobbyName);
                  // Navegar de regreso a la pantalla principal
                  Navigator.pop(context);
                }
              },
              child: Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }
}
