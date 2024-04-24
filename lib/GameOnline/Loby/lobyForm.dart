import 'package:checker/Game/gamePage.dart';
import 'package:checker/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LobbyForm extends StatefulWidget {
  @override
  _LobbyFormState createState() => _LobbyFormState();
}

class _LobbyFormState extends State<LobbyForm> {
  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lobby', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateLobbyPage(),
                  ),
                );
              },
              child:
                  Text('Crear partida', style: TextStyle(fontFamily: 'Roboto')),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              onPressed: () {
                // Navegar a la pantalla de búsqueda de partida
              },
              child: Text('Buscar partida',
                  style: TextStyle(fontFamily: 'Roboto')),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinLobbyPage(),
                  ),
                );
              },
              child: Text('Unirse a partida',
                  style: TextStyle(fontFamily: 'Roboto')),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateLobbyPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear partida', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.black,
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
                // Implementar la lógica para crear la partida
                final lobbyName = _textController.text;

                // Puedes llamar a la función para crear la partida con el nombre
                // y luego navegar a la página principal o realizar cualquier otra acción
              },
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              child: Text('Crear', style: TextStyle(fontFamily: 'Roboto')),
            ),
          ],
        ),
      ),
    );
  }
}

class JoinLobbyPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Unirse a partida', style: TextStyle(color: Colors.grey)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Código de la partida',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementar la lógica para unirse a la partida
                final lobbyCode = _textController.text;
                //appData.uniteGame(lobbyCode);
                // Puedes llamar a la función para unirse a la partida con el código
                // y luego navegar a la página principal o realizar cualquier otra acción
              },
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              child: Text('Unirse', style: TextStyle(fontFamily: 'Roboto')),
            ),
          ],
        ),
      ),
    );
  }
}
