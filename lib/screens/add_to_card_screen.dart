import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/providers/cart_provider.dart'; // assume this exists

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Colors.orange.shade50,
      ),
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (cartItems) {
          if (cartItems.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchCartProducts(cartItems),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final products = snapshot.data!;
              double total = 0;

              for (var i = 0; i < products.length; i++) {
                final p = products[i];
                final qty = cartItems[i].quantity;
                total += (p['price'] as num) * qty;
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final quantity = cartItems[index].quantity;

                        return ListTile(
                          title: Text(product['name']),
                          subtitle: Text("Quantity: $quantity"),
                          trailing: Text(
                              "LKR ${(product['price'] * quantity).toStringAsFixed(2)}"),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Total: LKR ${total.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await ref
                                .read(cartProvider.notifier)
                                .checkoutCart(total);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Order placed!")),
                            );
                          },
                          child: const Text("Checkout"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchCartProducts(
      List<CartItem> items) async {
    final productIds = items.map((e) => e.productId).toList();
    final allProducts =
        await Supabase.instance.client.from('food_product').select('*');
    return allProducts.where((p) => productIds.contains(p['id'])).toList();
  }
}
