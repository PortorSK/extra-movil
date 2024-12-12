import 'package:examen/modules/login/domain/dto/product_detail_dto.dart';
import 'package:examen/modules/login/domain/repository/product_detail_repository.dart';

class FetchProductDetailUseCase {
  final ProductDetailRepository repository;

  FetchProductDetailUseCase({required this.repository});

  Future<ProductDetailDTO> execute(productId) {
    return repository.fetchProductDetail(productId);
  }
}
