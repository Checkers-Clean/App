import 'package:checker/Game/gamePage.dart';
import 'package:checker/GameOnline/SalaDeEspera/esperaPage.dart';
import 'package:checker/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Gestion/crearLobbyForm.dart';
import '../Gestion/joinLobbyPage.dart';

class LobbyForm extends StatefulWidget {
  @override
  _LobbyFormState createState() => _LobbyFormState();
}

class _LobbyFormState extends State<LobbyForm> {
  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);

    appData.token = appData.socketManager.token;
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
                    builder: (context) => crearLobbyForm(),
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
