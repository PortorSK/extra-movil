import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen del login
            Image.asset(
              'assets/login_image.png', // Asegúrate de añadir la imagen en assets y declarar en pubspec.yaml
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 24),
            // Campo de usuario
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Usuario',
              ),
            ),
            const SizedBox(height: 16),
            // Campo de contraseña
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
            const SizedBox(height: 24),
            // Botón de ingreso
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para validar el usuario y la contraseña
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  if (username.isNotEmpty && password.isNotEmpty) {
                    // Aquí puedes agregar la lógica de autenticación
                    print("Usuario: $username, Contraseña: $password");
                    Navigator.pushNamed(context, '/categories'); // Navegar a categorías
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Por favor, completa todos los campos')),
                    );
                  }
                },
                child: const Text('Ingresar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
