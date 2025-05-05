import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final favoriteProvider =
    AsyncNotifierProvider<FavoriteNotifier, List<String>>(FavoriteNotifier.new);

class FavoriteNotifier extends AsyncNotifier<List<String>> {
  SupabaseClient get _supabase => Supabase.instance.client;
  String? get _userId => _supabase.auth.currentUser?.id;

  @override
  Future<List<String>> build() async {
    if (_userId == null) return [];

    final response = await _supabase
        .from('favorites')
        .select('product_id')
        .eq('user_id', _userId!);

    return (response as List)
        .map((item) => item['product_id'] as String)
        .toList();
  }

  Future<void> toggleFavorite(String productId) async {
    if (_userId == null) return;

    final currentFavs = state.value ?? [];

    if (currentFavs.contains(productId)) {
      await _supabase
          .from('favorites')
          .delete()
          .match({'user_id': _userId!, 'product_id': productId});

      state = AsyncValue.data([...currentFavs]..remove(productId));
    } else {
      await _supabase.from('favorites').insert({
        'user_id': _userId,
        'product_id': productId,
      });

      state = AsyncValue.data([...currentFavs, productId]);
    }
  }

  void reset() {
    state = const AsyncValue.data([]);
  }
}
