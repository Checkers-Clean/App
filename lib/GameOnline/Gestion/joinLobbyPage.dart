import 'package:checker/GameOnline/Gestion/joinLobbyForm.dart';
import 'package:flutter/material.dart';

class JoinLobbyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro del Scaffold
      body: JoinLobbyForm(),
    );
  }
}
