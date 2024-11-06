import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://dummyjson.com';

  Future<http.Response> getCategories() async {
    final url = Uri.parse('$_baseUrl/products/categories');
    return await http.get(url);
  }

  Future<http.Response> getProductsByCategory(String category) async {
    final url = Uri.parse('$_baseUrl/products/category/$category');
    return await http.get(url);
  }

  Future<http.Response> getProductById(int productId) async {
    final url = Uri.parse('$_baseUrl/products/$productId');
    return await http.get(url);
  }
}
