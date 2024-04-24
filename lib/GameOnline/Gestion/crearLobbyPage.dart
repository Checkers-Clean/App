import 'package:flutter/material.dart';

import 'crearLobbyForm.dart';

class crearLobbyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro del Scaffold
      body: crearLobbyForm(),
    );
  }
}
