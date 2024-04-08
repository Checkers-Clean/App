import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../MainMenu/maniManuPage.dart';
import '../appData.dart';

class GameForm extends StatefulWidget {
  @override
  _GameFormState createState() => _GameFormState();
}

class _GameFormState extends State<GameForm> {
  late int contTap = 0;
  late List<String> tap1 = [];
  late List<String> tap2 = [];

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        color: Colors.grey,
        child: Column(
          children: List.generate(
            8,
            (rowIndex) => Expanded(
              child: Row(
                children: List.generate(
                  8,
                  (colIndex) {
                    final isWhiteSquare = (rowIndex + colIndex) % 2 == 0;
                    final position = appData.numeracion[rowIndex][colIndex];
                    final piece = appData.board[rowIndex][colIndex];
                    return _buildSquare(
                      context,
                      isWhiteSquare,
                      position,
                      piece,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquare(
      BuildContext context, bool isWhite, String position, String piece) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth / 8;
    var appData = Provider.of<AppData>(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          contTap++;
          _handleSquareClick(position, piece, contTap, appData);
          print(contTap);
        },
        child: Container(
          color: isWhite ? Colors.white : Colors.black,
          width: squareSize,
          height: squareSize,
          child: Center(
            child: Text(
              piece,
              style: const TextStyle(
                color: Colors.red, // Color de las piezas
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSquareClick(
      String position, String piece, int count, AppData appData) {
    if (count == 1) {
      setState(() {
        tap1.add(position);
        tap1.add(piece);
      });
    }
    if (count == 2) {
      setState(() {
        tap2.add(position);
        tap2.add(piece);

        print(
            "-------\n tap1 : ${tap1[0]}, ${tap1[1]}\n tap2 ${tap2[0]}, ${tap2[1]}\n-------");
        appData.colocarfichas(tap1[1], tap1[0], tap2[0], tap2[1]);

        // Verificar si se ha acabado el juego
        if (appData.red == 0 || appData.black == 0) {
          appData.board == appData.board_inicio;
          String winner = appData.red == 0 ? "black" : "red";
          _showGameOverDialog(context, winner);
        }

        contTap = 0;
        tap1.clear();
        tap2.clear();
      });
    }
  }

  void _showGameOverDialog(BuildContext context, String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Winner: $winner"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                // Cerrar el diálogo
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          MainMenuPage()), // Navegar a MainMenuPage
                  (Route<dynamic> route) =>
                      false, // Eliminar las rutas anteriores
                );
              },
            ),
          ],
        );
      },
    );
  }
}
