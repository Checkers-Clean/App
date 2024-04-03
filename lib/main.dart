import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'app.dart';
import 'appData.dart';

void main() async {
  print("--------m0---------");
  AppData.printerboard();
  print("--------m0---------");
  AppData.colocarfichas(AppData.piezasRojas, "r12", "h4");
  print("--------m1---------");
  AppData.printerboard();
  print("--------m1---------");
  AppData.colocarfichas(AppData.piezasRojas, "n12", "a5");
  print("--------m2---------");
  AppData.printerboard();
  print("--------m2---------");
  // For Linux, macOS and Windows, initialize WindowManager
  try {
    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      WidgetsFlutterBinding.ensureInitialized();
      await WindowManager.instance.ensureInitialized();
      windowManager.waitUntilReadyToShow().then(showWindow);
    }
  } catch (e) {
    print(
        e); // Se manejan errores aquí si hay algún problema al inicializar WindowManager
  }

  // Define the app as a ChangeNotifierProvider
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: const App(),
    ),
  );
}

// Show the window when it's ready
void showWindow(_) async {
  windowManager.setMinimumSize(const Size(300.0, 600.0));
  await windowManager.setTitle('Checker');
}
