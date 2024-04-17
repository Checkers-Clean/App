import 'package:flutter/material.dart';

class EsperaForm extends StatefulWidget {
  @override
  _EsperaFormState createState() => _EsperaFormState();
}

class _EsperaFormState extends State<EsperaForm> {
  String username = "usuario"; // Puedes cambiar el valor aquí

  IconData iconoX = Icons.close;
  Color colorX = Colors.red;

  void cambiarIcono() {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "App de Ejemplo",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  color: Colors.red,
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
                        username,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          iconoX,
                          color: colorX,
                        ),
                        onPressed: cambiarIcono,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
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
                        username,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          iconoX,
                          color: colorX,
                        ),
                        onPressed: cambiarIcono,
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
                cambiarIcono();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
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
      ),
    );
  }
}
