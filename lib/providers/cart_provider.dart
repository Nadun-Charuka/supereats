import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final cartProvider =
    AsyncNotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);

class CartItem {
  final String productId;
  final int quantity;

  CartItem({required this.productId, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['product_id'],
        quantity: json['quantity'],
      );
}

class CartNotifier extends AsyncNotifier<List<CartItem>> {
  SupabaseClient get _supabase => Supabase.instance.client;
  String? get _userId => _supabase.auth.currentUser?.id;

  @override
  Future<List<CartItem>> build() async {
    if (_userId == null) return [];

    final response = await _supabase
        .from('cart_items')
        .select('product_id, quantity')
        .eq('user_id', _userId!);

    return (response as List).map((item) => CartItem.fromJson(item)).toList();
  }

  Future<void> toggleCart(String productId) async {
    if (_userId == null) return;

    final currentCart = state.value ?? [];
    final existing = currentCart.firstWhere(
      (item) => item.productId == productId,
      orElse: () => CartItem(productId: productId, quantity: 0),
    );

    if (existing.quantity > 0) {
      // Remove from cart
      await _supabase
          .from('cart_items')
          .delete()
          .match({'user_id': _userId!, 'product_id': productId});

      state = AsyncValue.data(
        [...currentCart.where((item) => item.productId != productId)],
      );
    } else {
      // Add to cart
      await _supabase.from('cart_items').insert({
        'user_id': _userId,
        'product_id': productId,
        'quantity': 1,
      });

      state = AsyncValue.data([
        ...currentCart,
        CartItem(productId: productId, quantity: 1),
      ]);
    }
  }

  Future<void> addToCart(String productId, {int quantity = 1}) async {
    if (_userId == null) return;

    final currentCart = state.value ?? [];
    final index = currentCart.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      final updatedQty = currentCart[index].quantity + quantity;
      final updatedItem = CartItem(productId: productId, quantity: updatedQty);

      await _supabase.from('cart_items').update({
        'quantity': updatedQty,
      }).match({'user_id': _userId!, 'product_id': productId});

      final updatedCart = [...currentCart];
      updatedCart[index] = updatedItem;
      state = AsyncValue.data(updatedCart);
    } else {
      await _supabase.from('cart_items').insert({
        'user_id': _userId,
        'product_id': productId,
        'quantity': quantity,
      });

      state = AsyncValue.data([
        ...currentCart,
        CartItem(productId: productId, quantity: quantity),
      ]);
    }
  }

  Future<void> setQuantity(String productId, int quantity) async {
    if (_userId == null) return;
    if (quantity < 1) {
      await removeFromCart(productId);
      return;
    }

    final currentCart = state.value ?? [];
    final index = currentCart.indexWhere((item) => item.productId == productId);

    if (index != -1) {
      final updatedItem = CartItem(productId: productId, quantity: quantity);

      await _supabase.from('cart_items').update({
        'quantity': quantity,
      }).match({'user_id': _userId!, 'product_id': productId});

      final updatedCart = [...currentCart];
      updatedCart[index] = updatedItem;
      state = AsyncValue.data(updatedCart);
    }
  }

  Future<void> removeFromCart(String productId) async {
    if (_userId == null) return;

    await _supabase
        .from('cart_items')
        .delete()
        .match({'user_id': _userId!, 'product_id': productId});

    final currentCart = state.value ?? [];
    state = AsyncValue.data([
      ...currentCart.where((item) => item.productId != productId),
    ]);
  }

  Future<void> clearCart() async {
    if (_userId == null) return;

    await _supabase.from('cart_items').delete().eq('user_id', _userId!);
    state = const AsyncValue.data([]);
  }

  bool isInCart(String productId) {
    return state.value?.any((item) => item.productId == productId) ?? false;
  }

  int getQuantity(String productId) {
    return state.value
            ?.firstWhere((item) => item.productId == productId,
                orElse: () => CartItem(productId: productId, quantity: 0))
            .quantity ??
        0;
  }

  Future<void> checkoutCart(double totalPrice) async {
    if (_userId == null) return;

    final cartItems = state.value ?? [];
    if (cartItems.isEmpty) return;

    final orderRes = await _supabase
        .from('orders')
        .insert({
          'user_id': _userId,
          'total_price': totalPrice,
        })
        .select()
        .single();

    final orderId = orderRes['id'];

    for (final item in cartItems) {
      await _supabase.from('order_items').insert({
        'order_id': orderId,
        'product_id': item.productId,
        'quantity': item.quantity,
      });
    }

    await clearCart();
  }
}
