import 'package:flutter/material.dart';

import 'gameForm.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro del Scaffold
      body: GameForm(),
    );
  }
}
