import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/models/product_model.dart';
import 'package:supereats/providers/favorite_provider.dart';
import 'package:supereats/widgets/shared/food_card_widget.dart';

final supabase = Supabase.instance.client;

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Favorite Products")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: favoritesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("Error: $e")),
          data: (favoriteIds) {
            if (favoriteIds.isEmpty) {
              return const Center(child: Text("No favorite products found"));
            }

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchFavoriteProducts(favoriteIds),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final favoriteProducts = snapshot.data!;
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: favoriteProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return FoodCardWidget(
                      food: FoodModel.fromJson(product),
                      onfire: true,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchFavoriteProducts(
      List<String> ids) async {
    final allProducts =
        await Supabase.instance.client.from('food_product').select('*');

    return allProducts.where((p) => ids.contains(p['id'])).toList();
  }
}
