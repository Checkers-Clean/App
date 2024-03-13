import 'package:flutter/material.dart';
import 'mobile_chess_board.dart';
import 'pc_chess_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Color.fromRGBO(158, 158, 158, 1.0), // Color de fondo de la barra

        leading: IconButton(
          onPressed: () {
            // Acción del botón
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 30, // Reduciendo la altura de la barra
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  // Acción del botón
                },
                iconSize: 20, // Tamaño del icono
                icon: Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  // Acción del botón
                },
                iconSize: 20, // Tamaño del icono
                icon: Icon(Icons.search, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  // Acción del botón
                },
                iconSize: 20, // Tamaño del icono
                icon: Icon(Icons.notifications, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  // Acción del botón
                },
                iconSize: 20, // Tamaño del icono
                icon: Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
        ),
        color: Color.fromRGBO(158, 158, 158, 1.0), // Color de fondo de la barra
        elevation: 0, // Quitando la elevación
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Versión para PC
              return PCChessBoard();
            } else {
              // Versión para móvil
              return MobileChessBoard();
            }
          },
        ),
      ),
    );
  }
}
