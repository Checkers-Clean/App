import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          // Manejo del clic
          contTap++;
          _handleSquareClick(position, piece, contTap, appData);
        },
        child: Container(
          color: isWhite ? Colors.white : Colors.black,
          width: squareSize,
          height: squareSize,
          child: Center(
            child: Text(
              piece,
              style: TextStyle(
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
      String position, String piece, int contTap, AppData appData) {
    if (contTap == 1) {
      setState(() {
        tap1.add(position);
        tap1.add(piece);
      });
    }
    if (contTap == 2) {
      setState(() {
        tap2.add(position);
        tap2.add(piece);

        //appData.colocarfichas(piezas, piezaSelecionada, nuevaPosicion)
        contTap = 0;
        print(
            "-------\n tap1 : ${tap1[0]}, ${tap1[1]}\n tap2 ${tap2[0]}, ${tap2[1]}\n-------");
      });
    }
  }
}
