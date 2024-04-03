import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appData.dart';

class MainMenuForm extends StatefulWidget {
  @override
  _MainMenuFormState createState() => _MainMenuFormState();
}

class _MainMenuFormState extends State<MainMenuForm> {
  int _currentIndex = 0;
  final List<String> _texts = [
    'Principiante',
    'Texto 2',
    'Texto 3',
    'Texto 4',
  ];

  void _changeText(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/2/ficha_negra_reina.png', // Ruta de la imagen local
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (_currentIndex > 0) {
                    _changeText(_currentIndex - 1);
                  }
                },
              ),
              Text(
                _texts[_currentIndex],
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_currentIndex < _texts.length - 1) {
                    _changeText(_currentIndex + 1);
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ButtonTheme(
          minWidth: 150, // Anchura personalizada de los botones
          height: 50, // Altura personalizada de los botones
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Acción del primer botón
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.red), // Borde rojo
                ),
                child: Text('Nueva Partida'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Acción del segundo botón
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.red), // Borde rojo
                ),
                child: Text('Reanudar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Acción del tercer botón
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.red), // Borde rojo
                ),
                child: Text('Online'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Acción del cuarto botón
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.red), // Borde rojo
                ),
                child: Text('Jugar con Amigos'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
