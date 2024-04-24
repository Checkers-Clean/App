import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';

void main() {
  // Esta línea anula las verificaciones de certificados
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // URL del servidor Socket.IO
  final String serverUrl = 'https://localhost:3000';
  // Cliente Socket.IO
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    // Inicializar el cliente Socket.IO y conectar al servidor
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false, // Desactivar la conexión automática
    });
    socket.connect();

    // Manejar los eventos de mensaje recibido
    socket.on('message', (data) {
      print('Mensaje recibido: $data');
    });
  }

  @override
  void dispose() {
    // Desconectar el cliente Socket.IO al cerrar la aplicación
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Socket.IO Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Enviar un mensaje al servidor cuando se presiona el botón
                  socket.emit('message', 'Hola desde Flutter');
                },
                child: Text('Enviar mensaje al servidor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clase para anular las verificaciones de certificados
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
