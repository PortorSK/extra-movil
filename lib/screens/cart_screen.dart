import 'package:examen/modules/login/domain/repository/cart_repository.dart';
import 'package:examen/screens/purchase_screen.dart';
import 'package:flutter/material.dart';
import 'package:examen/modules/login/domain/dto/cart_item_dto.dart';
import 'package:examen/modules/login/useCase/get_cart_items_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:examen/modules/login/domain/repository/purchase_repository.dart';

class CartScreen extends StatefulWidget {
  final GetCartItemsUseCase getCartItemsUseCase;

  const CartScreen({
    super.key,
    required this.getCartItemsUseCase,
    required cartRepository,
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<CartItemDTO>> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = widget.getCartItemsUseCase.execute();
  }

  Future<void> _finalizePurchase(List<CartItemDTO> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final purchasesData = prefs.getString('purchases') ?? '[]';
    final List<dynamic> purchases = jsonDecode(purchasesData);

    final totalPurchase = cartItems.fold<double>(
        0.0, (sum, item) => sum + (item.price * item.quantity));
    final totalProducts = cartItems.fold<int>(
        0, (sum, item) => sum + item.quantity);

    purchases.add({
      'totalPurchase': totalPurchase,
      'totalProducts': totalProducts,
      'date': DateTime.now().toIso8601String(),
      'items': cartItems.map((item) {
        return {
          'name': item.name,
          'quantity': item.quantity,
          'total': item.price * item.quantity,
        };
      }).toList(),
    });

    await prefs.setString('purchases', jsonEncode(purchases));
    await prefs.setString('cart', '[]'); // Limpiar carrito tras finalizar compra

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compra finalizada con éxito')),
    );

    // Navegar a la pantalla de compras realizadas
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PurchaseScreen(
          purchaseRepository: PurchaseRepository(),
        ),
      ),
    );

    setState(() {
      _cartItems = widget.getCartItemsUseCase.execute();
    });
  }

  Future<void> _clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart', '[]'); // Vaciar el carrito

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('El carrito ha sido vaciado')),
    );

    setState(() {
      _cartItems = widget.getCartItemsUseCase.execute();
    });
  }

  double _calculateTotal(List<CartItemDTO> cartItems) {
    return cartItems.fold(
        0.0, (total, item) => total + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de compras'),
      ),
      body: FutureBuilder<List<CartItemDTO>>(
        future: _cartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('El carrito está vacío.'));
          } else {
            final cart = snapshot.data!;
            final total = _calculateTotal(cart);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(item.name),
                        subtitle: Text(
                            'Cantidad: ${item.quantity} | Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => _clearCart(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Vaciar carrito'),
                      ),
                      ElevatedButton(
                        onPressed: () => _finalizePurchase(cart),
                        child: const Text('Finalizar compra'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
