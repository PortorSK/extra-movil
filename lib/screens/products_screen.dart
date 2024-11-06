import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryName;

  ProductsScreen({required this.categoryName});

  final List<Map<String, String>> products = List.generate(
    10,
    (index) => {
      'name': 'Product ${index + 1} ${index + 1}',
      'image': 'https://via.placeholder.com/150', // Imagen de ejemplo
      'details': 'Detalles'
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    product['image']!,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(product['name']!),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Selected: ${product['name']}")),
                    );
                  },
                  child: Text(
                    product['details']!,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
