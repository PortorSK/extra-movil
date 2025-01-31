import 'package:examen/modules/login/domain/dto/product_dto.dart';
import 'package:examen/modules/login/domain/repository/product_repository.dart';

class FetchProductsByCategoryUseCase {
  final ProductRepository repository;

  FetchProductsByCategoryUseCase({required this.repository});

  Future<List<ProductDTO>> execute(String category) {
    return repository.fetchProductsByCategory(category);
  }
}
