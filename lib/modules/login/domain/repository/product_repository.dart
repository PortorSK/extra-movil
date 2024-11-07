import 'package:examen/infrastructure/connection/api_service.dart';
import '../dto/product_dto.dart';

abstract class ProductRepository {
  Future<List<ProductDTO>> fetchProductsByCategory(String category);
}

class ProductRepositoryImpl implements ProductRepository {
  final ApiService apiService;

  ProductRepositoryImpl({required this.apiService});

  @override
  Future<List<ProductDTO>> fetchProductsByCategory(String category) async {
    final response = await apiService.fetchProductsByCategory(category);
    return response.map<ProductDTO>((json) => ProductDTO.fromJson(json)).toList();
  }
}
