import 'package:flutter/material.dart';
import 'package:flutter_funky/screens/home_screen.dart';
import 'package:flutter_funky/screens/login_screen.dart';
import 'package:flutter_funky/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Definir la pantalla de inicio de sesión como la ruta inicial
      routes: {
        '/login': (context) => LoginScreen(),   // Ruta para la pantalla de inicio de sesión
        '/home': (context) => HomeScreen(),     // Ruta para la pantalla principal después del inicio de sesión
        '/splash': (context) => SplashScreen(), // Ruta para la pantalla de splash
      },
    );
  }
}
