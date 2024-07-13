import 'package:flutter/material.dart';
import 'package:flutter_funky/screens/splash_screen.dart'; // Asegúrate de importar tu pantalla de splash

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Aquí puedes implementar la lógica para cerrar sesión
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/splash');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2E1459),
            fixedSize: Size(80, 60),
            shape: CircleBorder(),
          ),
          child: Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo_funcy_btn.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

