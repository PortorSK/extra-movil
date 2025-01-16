import 'package:examen/infrastructure/connection/api_service.dart';
import 'package:examen/modules/login/domain/dto/product_dto.dart';
import 'package:examen/modules/login/domain/repository/product_repository.dart';
import 'package:examen/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late ProductRepository productRepository;
  late List<ProductDTO> _products = [];

  @override
  void initState() {
    super.initState();
    productRepository = ProductRepositoryImpl(apiService: ApiService());

    // Agregar un listener para realizar la búsqueda mientras se escribe
    _searchController.addListener(() {
      _searchProducts(_searchController.text);
    });
  }

  void _searchProducts(String query) async {
    try {
      if (query.isEmpty) {
        setState(() {
          _products = [];
        });
        return;
      }

      print('Buscando productos con el término: $query');
      final products = await productRepository.searchProducts(query);
      setState(() {
        _products = products;
      });
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  @override
  void dispose() {
    _searchController.dispose(); // Asegurarse de liberar el controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Productos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _products.isEmpty
                ? const Center(child: Text('No se encontraron productos'))
                : ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return ListTile(
                        title: Text(product.title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                productId: product.id, // Mantén esta lógica
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
