import 'package:checker/Game/gamePage.dart';
import 'package:checker/GameOnline/SalaDeEspera/esperaPage.dart';
import 'package:checker/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class crearLobbyForm extends StatefulWidget {
  @override
  _crearLobbyFormState createState() => _crearLobbyFormState();
}

class _crearLobbyFormState extends State<crearLobbyForm> {
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
              onPressed: () async {
                // Implementar la lógica para crear la partida
                final lobbyName = _textController.text;
                appData.socketManager.sendTestMessage("message");
                appData.socketManager.createRome(appData.token);

                // Esperar un par de segundos antes de navegar
                await Future.delayed(Duration(seconds: 2));
                appData.ipPartida = appData.socketManager.partida;
                appData.player1 = appData.username!;
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
              child: Text('Crear', style: TextStyle(fontFamily: 'Roboto')),
            ),
          ],
        ),
      ),
    );
  }
}
