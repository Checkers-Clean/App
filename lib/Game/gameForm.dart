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
  late List<List<Color>> squareColors;
  late List<List<bool>> isMarked;

  @override
  void initState() {
    super.initState();
    // Inicializar el estado de color y de marcado para cada cuadrado
    squareColors = List.generate(8, (_) => List.filled(8, Colors.grey));
    isMarked = List.generate(8, (_) => List.filled(8, false));
  }

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.black, // Color del lateral izquierdo
            // Aquí puedes colocar cualquier widget para el lateral izquierdo
          ),
        ),
        Expanded(
          flex: 5, // Flexibilidad del centro
          child: Center(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                color: Colors.black,
                child: Column(
                  children: List.generate(
                    8,
                    (rowIndex) => Expanded(
                      child: Row(
                        children: List.generate(
                          8,
                          (colIndex) {
                            final isWhiteSquare =
                                (rowIndex + colIndex) % 2 == 0;
                            final position =
                                appData.numeracion[rowIndex][colIndex];
                            final piece = appData.board[rowIndex][colIndex];
                            return _buildSquare(
                              context,
                              isWhiteSquare,
                              position,
                              piece,
                              squareColors[rowIndex]
                                  [colIndex], // Color del cuadrado
                              isMarked[rowIndex][colIndex], // Estado de marcado
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black, // Color del lateral derecho
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Mostrar el contenido de la variable turnoActual
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    appData.turnoActual, // Aquí muestra la variable turnoActual
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSquare(
    BuildContext context,
    bool isWhite,
    String position,
    String piece,
    Color squareColor,
    bool isSquareMarked, // Nuevo parámetro para el marcado del cuadrado
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth / 8;
    var appData = Provider.of<AppData>(context);
    Widget pieceWidget;
    if (piece != "-") {
      if (piece.contains("r")) {
        if (piece.contains("Q")) {
          pieceWidget = Image.asset("assets/2/ficha_roja_reina.png");
        } else {
          // Si la pieza empieza por "r", mostrar imagen A
          pieceWidget = Image.asset("assets/2/ficha_roja.png");
        }
      } else {
        if (piece.contains("Q")) {
          pieceWidget = Image.asset("assets/2/ficha_negra_reina.png");
        } else {
          // Si la pieza empieza por cualquier otra cosa, mostrar imagen B
          pieceWidget = Image.asset("assets/2/ficha_negra.png");
        }
      }
    } else {
      // Si no se proporciona ninguna imagen
      pieceWidget = SizedBox(); // Dejar sin imagen
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          contTap++;
          _handleSquareClick(position, piece, contTap, appData);
          print("Tap: $contTap");
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: isSquareMarked ? Colors.yellow : Colors.red,
            ), // Línea amarilla si está marcado, roja si no
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), // Esquina superior izquierda
              topRight: Radius.circular(8), // Esquina superior derecha
              bottomLeft: Radius.circular(8), // Esquina inferior izquierda
              bottomRight: Radius.circular(8), // Esquina inferior derecha
            ),
          ),
          width: squareSize,
          height: squareSize,
          child: Center(
            child: pieceWidget, // Mostrar la imagen correspondiente
          ),
        ),
      ),
    );
  }

  void _handleSquareClick(
    String position,
    String piece,
    int count,
    AppData appData,
  ) {
    if (count == 1) {
      setState(() {
        tap1.add(position);
        tap1.add(piece);
        // Marcar el cuadrado seleccionado
        int row = int.parse(position.split("")[1]) - 1;
        int col = position.codeUnitAt(0) - 'a'.codeUnitAt(0);
        isMarked[row][col] = true;
        squareColors[row][col] = Colors.green;
      });
    }
    if (count == 2) {
      setState(() {
        tap2.add(position);
        tap2.add(piece);
        appData.colocarfichas(tap1[1], tap1[0], tap2[0], tap2[1]);
        print(
            "-------\n tap1 : ${tap1[0]}, ${tap1[1]}\n tap2 ${tap2[0]}, ${tap2[1]}\n-------");

        if (appData.gameover) {
          String winner = appData.red == 0 ? "black" : "red";
          _showGameOverDialog(context, winner, appData);
        }

        contTap = 0;
        tap1.clear();
        tap2.clear();
        // Restablecer el estado de marcado de los cuadrados
        isMarked = List.generate(8, (_) => List.filled(8, false));
      });
    }
  }

  void _resetGame(AppData appData) {
    setState(() {
      appData.reset();
      // Reiniciar los colores de los cuadrados a gris
      squareColors = List.generate(8, (_) => List.filled(8, Colors.grey));
    });
  }

  void _showGameOverDialog(
    BuildContext context,
    String winner,
    AppData appData,
  ) {
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
                //reiniciar el juego
                _resetGame(appData);
                // Cerrar el diálogo y volver al menú principal
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => MainMenuPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
