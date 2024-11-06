import 'package:examen/screens/products_screen.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'RAÍZ', 'date': '2022-12-01 23:57:02.000', 'icon': Icons.shopping_bag, 'color': Colors.blue},
    {'name': 'INICIO', 'date': '2022-12-01 23:57:02.000', 'icon': Icons.fastfood, 'color': Colors.red},
    {'name': 'CARNES AVES HUEVO', 'date': '2023-11-09 09:46:45.000', 'icon': Icons.fastfood, 'color': Colors.blue},
    {'name': 'DALE SABOR A TUS COMIDAS', 'date': '2023-11-09 09:49:47.000', 'icon': Icons.fastfood, 'color': Colors.red},
    {'name': 'DEL CAMPO A TU CASA', 'date': '2023-11-09 09:50:51.000', 'icon': Icons.shopping_bag, 'color': Colors.blue},
    {'name': 'DERIVADOS 100% DEL MAÍZ', 'date': '2023-11-09 09:53:05.000', 'icon': Icons.shopping_bag, 'color': Colors.blue},
    {'name': 'NUESTRAS MIELES', 'date': '2023-11-09 09:55:52.000', 'icon': Icons.fastfood, 'color': Colors.blue},
    {'name': 'PARA PICAR UN RATO', 'date': '2023-11-09 09:59:00.000', 'icon': Icons.fastfood, 'color': Colors.red},
    {'name': 'PARA REFRESCARSE', 'date': '2023-11-09 10:00:22.000', 'icon': Icons.shopping_bag, 'color': Colors.blue},
    {'name': 'UN DULCE MOMENTO', 'date': '2023-11-09 10:01:10.000', 'icon': Icons.fastfood, 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: Icon(category['icon'], color: category['color']),
            title: Text(category['name'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(category['date']),
            trailing: Icon(Icons.arrow_forward, color: category['color']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsScreen(categoryName: category['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
