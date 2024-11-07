import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  // Método para obtener la lista de nombres de categorías
  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);

      // Extraer solo los nombres de cada categoría en la lista
      return decodedData.map((category) => category['name'] as String).toList();
    } else {
      throw Exception('Error al cargar categorías');
    }
  }

  // Método para obtener los productos por categoría
  Future<List<dynamic>> fetchProductsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/products/category/$category'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(response.body);

      // Retornar la lista de productos en la categoría
      return decodedData['products'] as List<dynamic>;
    } else {
      throw Exception('Error al cargar productos de la categoría');
    }
  }
}
