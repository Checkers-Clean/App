import 'package:flutter/material.dart';

import 'lobyForm.dart';

class lobyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro del Scaffold
      body: LobbyForm(),
    );
  }
}
