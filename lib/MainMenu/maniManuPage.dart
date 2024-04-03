import 'package:flutter/material.dart';

import 'mainMenuForm.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro del Scaffold
      body: MainMenuForm(),
    );
  }
}
