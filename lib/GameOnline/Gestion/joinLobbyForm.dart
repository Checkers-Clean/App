import 'package:checker/Game/gamePage.dart';
import 'package:checker/GameOnline/SalaDeEspera/esperaPage.dart';
import 'package:checker/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class JoinLobbyForm extends StatefulWidget {
  @override
  _JoinLobbyFormState createState() => _JoinLobbyFormState();
}

class _JoinLobbyFormState extends State<JoinLobbyForm> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);

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
              onPressed: () async {
                // Implementar la lógica para unirse a la partida
                final lobbyCode = _textController.text;
                appData.socketManager
                    .joinRoom(lobbyCode, appData.socketManager.token);

                print("token: " + appData.token);
                await Future.delayed(Duration(seconds: 2));
                appData.token = appData.socketManager.token;
                print("token: " + appData.token);
                // Esperar un par de segundos antes de navegar
                await Future.delayed(Duration(seconds: 2));
                appData.ipPartida = appData.socketManager.partida;
                appData.player2 = appData.username!;
                appData.online = true;
                // Navegar a la página de espera después de esperar el tiempo especificado
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => esperaPage()),
                );
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
