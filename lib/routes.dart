// lib/routes.dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/categories_screen.dart'; // Supón que esta pantalla también está creada

class Routes {
  static const String login = '/login';
  static const String categories = '/categories';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case categories:
        return MaterialPageRoute(builder: (_) => CategoriesScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Ruta no definida')),
          ),
        );
    }
  }
}
