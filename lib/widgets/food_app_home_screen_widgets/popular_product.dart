import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/models/product_model.dart';
import 'package:supereats/providers/category_provider.dart';
import 'package:supereats/widgets/shared/food_card_widget.dart';

class PopularProductWidget extends ConsumerWidget {
  Future<List<FoodModel>> fetchFoodProduct(String category) async {
    try {
      final response = await Supabase.instance.client
          .from("food_product")
          .select()
          .eq("category", category);

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error in fetching data from product table: $e");
      return [];
    }
  }

  const PopularProductWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kheight = MediaQuery.of(context).size.height;
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return SizedBox(
      child: (selectedCategory == null || selectedCategory.isEmpty)
          ? const Center(child: Text("No category selected."))
          : FutureBuilder<List<FoodModel>>(
              future: fetchFoodProduct(selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Center(child: Text("No products found."));
                }

                final foodList = snapshot.data!;
                return SizedBox(
                  height: kheight * 0.34,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      final food = foodList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FoodCardWidget(
                          food: food,
                          onfire: true,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
