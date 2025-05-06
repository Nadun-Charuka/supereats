import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supereats/providers/cart_provider.dart';
import 'package:supereats/widgets/snackbar.dart';

class AddToCardWidget extends ConsumerStatefulWidget {
  final Map<String, dynamic> product;
  final int initialQuantity;
  final void Function(int newQuantity) onQuantityChanged;

  const AddToCardWidget({
    super.key,
    required this.product,
    required this.initialQuantity,
    required this.onQuantityChanged,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddToCardWidgetState();
}

class _AddToCardWidgetState extends ConsumerState<AddToCardWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void updateQuantity(int newQty) {
    setState(() => quantity = newQty);
    widget.onQuantityChanged(newQty); // Notify parent (CartScreen)
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final totalPrice = product['price'] * quantity;

    return ListTile(
      onLongPress: () {
        ref.read(cartProvider.notifier).removeFromCart(product['id']);
        showSnackBar(context, "Item remove from cart");
      },
      leading: CachedNetworkImage(
        imageUrl: product['imageCard'],
        width: 60,
        height: 60,
        placeholder: (context, url) => Shimmer.fromColors(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 60,
            height: 60,
          ),
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
        ),
      ),
      title: Text(product['name']),
      subtitle: Text("Quantity: $quantity"),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("LKR ${totalPrice.toStringAsFixed(2)}"),
          const SizedBox(height: 4),
          Container(
            height: 30,
            width: 110,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    if (quantity > 1) updateQuantity(quantity - 1);
                  },
                  child: const Icon(Icons.remove, size: 18),
                ),
                Text(quantity.toString()),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    updateQuantity(quantity + 1);
                  },
                  child: const Icon(Icons.add, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
