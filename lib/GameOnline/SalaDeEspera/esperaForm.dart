import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../appData.dart';

class EsperaForm extends StatefulWidget {
  @override
  _EsperaFormState createState() => _EsperaFormState();
}

class _EsperaFormState extends State<EsperaForm> {
// Puedes cambiar el valor aquí

  IconData iconoX = Icons.close;
  Color colorX = Colors.red;
  IconData iconoY = Icons.close;
  Color colorY = Colors.red;

  void cambiarIconoX() {
    setState(() {
      if (iconoX == Icons.close) {
        iconoX = Icons.check;
        colorX = Colors.green;
      } else {
        iconoX = Icons.close;
        colorX = Colors.red;
      }
    });
  }

  void cambiarIconoY() {
    setState(() {
      if (iconoX == Icons.close) {
        iconoX = Icons.check;
        colorX = Colors.green;
      } else {
        iconoX = Icons.close;
        colorX = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var appData = Provider.of<AppData>(context);

    print(appData.socketManager.partida);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appData.ipPartida,
          style: TextStyle(
            color: Colors.white, // Cambiar el color del texto a blanco
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
                      "Username: ",
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
                    ),
                    IconButton(
                      icon: Icon(
                        iconoX,
                        color: colorX,
                      ),
                      onPressed: cambiarIconoX,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black, // Cambiar el color de fondo a negro
                child: Row(
                  children: <Widget>[
                    Text(
                      "Username: ",
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
                    IconButton(
                      icon: Icon(
                        iconoY,
                        color: colorY,
                      ),
                      onPressed: cambiarIconoY,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Aquí puedes poner la lógica para cambiar el icono a O
              cambiarIconoX();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: Text(
              "Listo",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
