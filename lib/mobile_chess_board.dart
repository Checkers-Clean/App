import 'package:flutter/material.dart';

class MobileChessBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // Mantenemos una relación de aspecto cuadrada
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
                    return _buildSquare(context, isWhiteSquare);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquare(BuildContext context, bool isWhite) {
    final screenWidth = MediaQuery.of(context).size.width;
    final squareSize = screenWidth / 8;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Aquí puedes manejar la lógica cuando se hace clic en un cuadro
          print('Cuadro clickeado');
        },
        child: Container(
          color: isWhite ? Colors.white : Colors.black,
          width: squareSize,
          height: squareSize,
        ),
      ),
    );
  }
}
