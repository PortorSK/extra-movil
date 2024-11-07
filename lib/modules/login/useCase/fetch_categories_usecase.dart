import 'package:examen/modules/login/domain/dto/category_dto.dart';
import 'package:examen/modules/login/domain/repository/category_repository.dart';

class FetchCategoriesUseCase {
  final CategoryRepository repository;

  FetchCategoriesUseCase({required this.repository});

  Future<List<CategoryDTO>> execute() async {
    return await repository.getCategories();
  }
}
