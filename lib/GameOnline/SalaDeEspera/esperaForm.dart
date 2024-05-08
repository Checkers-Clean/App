import 'package:checker/GameOnline/Game/gameOnlinePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa flutter/services.dart
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Importa fluttertoast.dart

import '../../appData.dart';

class EsperaForm extends StatefulWidget {
  @override
  _EsperaFormState createState() => _EsperaFormState();
}

class _EsperaFormState extends State<EsperaForm> {
  // Puedes cambiar el valor aquí
  String player1 = "";
  String player2 = "";
  String texto = "esperando jugadores";

  Future<void> cambiarnombres(
      AppData appData, String newpj1, String newpj2) async {
    appData.assignarPlayers();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      player1 = newpj1;
      player2 = newpj2;
    });
    if (appData.play & appData.pintar) {
      appData.pintar = false;
      setState(() {
        texto = "comienda en breve";
      });
      await Future.delayed(Duration(seconds: 3));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GameOnlinePage(),
        ),
      );
    }
  }

  // Método para copiar el título al portapapeles
  void _copiarTituloAlPortapapeles(BuildContext context, String titulo) {
    Clipboard.setData(ClipboardData(text: titulo));
  }

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context, listen: true);

    cambiarnombres(appData, appData.player1, appData.player2);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          // Hacer que el título sea interactivo
          onTap: () {
            _copiarTituloAlPortapapeles(context, appData.ipPartida);
          },
          child: Text(
            appData.ipPartida,
            style: TextStyle(
              color: Colors.white, // Cambiar el color del texto a blanco
            ),
          ),
        ),
        backgroundColor: Colors.black, // Cambiar el color de fondo a negro
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Colors.black, // Cambiar el color de fondo a negro
                child: Row(
                  children: <Widget>[
                    Text(
                      "player 1: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      appData.player1,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.black, // Cambiar el color de fondo a negro
                child: Row(
                  children: <Widget>[
                    Text(
                      "player 2: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      appData.player2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            texto,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
