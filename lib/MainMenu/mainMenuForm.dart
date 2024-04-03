import 'package:checker/Game/gamePage.dart';
import 'package:flutter/material.dart';

class MainMenuForm extends StatefulWidget {
  @override
  _MainMenuFormState createState() => _MainMenuFormState();
}

class _MainMenuFormState extends State<MainMenuForm> {
  int _currentIndex = 0;
  final List<String> _texts = [
    'Principiante',
    'Medio',
    'Avanzado',
    'Dificil',
  ];

  void _changeText(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    //var appData = Provider.of<AppData>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 100),
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
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (_currentIndex > 0) {
                    _changeText(_currentIndex - 1);
                  }
                },
              ),
              Text(
                _texts[_currentIndex],
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  // Establece la fuente como Roboto
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_currentIndex < _texts.length - 1) {
                    _changeText(_currentIndex + 1);
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del primer botón
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              child: const Text(
                'Nueva Partida',
                style: TextStyle(
                  fontFamily: 'Roboto', // Establece la fuente como Roboto
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del segundo botón
              },
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              child: const Text(
                'Reanudar',
                style: TextStyle(
                  fontFamily: 'Roboto', // Establece la fuente como Roboto
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del tercer botón
              },
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              child: const Text(
                'Online',
                style: TextStyle(
                  fontFamily: 'Roboto', // Establece la fuente como Roboto
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del cuarto botón
              },
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(250, 50), // Anchura y altura personalizadas
                foregroundColor: Colors.grey,
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.red), // Borde rojo
              ),
              child: const Text(
                'Jugar con Amigos',
                style: TextStyle(
                  fontFamily: 'Roboto', // Establece la fuente como Roboto
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
