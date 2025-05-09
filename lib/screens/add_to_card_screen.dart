import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/providers/cart_provider.dart';
import 'package:supereats/widgets/shared/add_to_card_widget.dart';
import 'package:supereats/widgets/snackbar.dart'; // assume this exists

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 251, 248),
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

              for (final item in cartItems) {
                final product = products.firstWhere(
                  (product) => product['id'] == item.productId,
                  orElse: () =>
                      {}, // We return an empty map here, handle this case
                );
                total += (product['price'] as num) * item.quantity;
              }

              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final cartItem = cartItems.firstWhere(
                          (item) => item.productId == product['id'],
                          orElse: () => CartItem(
                              productId: product['id'],
                              quantity: 0), // Return a fallback CartItem
                        );

                        final quantity = cartItem.quantity;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: AddToCardWidget(
                            product: product,
                            initialQuantity: quantity,
                            onQuantityChanged: (newQty) {
                              ref
                                  .read(cartProvider.notifier)
                                  .setQuantity(product['id'], newQty);
                            },
                          ),
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
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade500,
                            ),
                            onPressed: () async {
                              await ref
                                  .read(cartProvider.notifier)
                                  .checkoutCart(total);
                              showSnackBar(context, "Order Placed");
                            },
                            child: const Text(
                              "Checkout",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
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
