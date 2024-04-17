import 'package:flutter/material.dart';

import 'gameOnlineForm.dart';

class GameOnlinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro del Scaffold
      body: GameOnlineForm(),
    );
  }
}
