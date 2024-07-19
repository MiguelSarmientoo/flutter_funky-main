import 'package:flutter/material.dart';
import 'package:flutter_funky/screens/home_screen.dart'; // Asegúrate de importar tu pantalla principal

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  void _handleLogin() {
    // Aquí puedes implementar la lógica de validación del login
    if (username == 'admin' && password == '123456') {
      // Redireccionar a HomeScreen si el login es exitoso
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Mostrar mensaje de error si las credenciales son incorrectas
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Login Fallido'),
          content: Text('Credenciales incorrectas.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Usuario',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _handleLogin,
                child: Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
