import 'package:checker/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gameOnlineForm.dart';

class GameOnlinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);

    return Scaffold(
        backgroundColor: Colors.black, // Fondo negro del Scaffold
        body: GameOnlineForm(appData: appData));
  }
}
