import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/models/product_model.dart';
import 'package:supereats/utils/colors.dart';
import 'package:supereats/widgets/shared/food_card_widget.dart';

class ViewAllProductScreen extends StatelessWidget {
  Future<List<FoodModel>> fetchFoodProduct() async {
    try {
      final response =
          await Supabase.instance.client.from("food_product").select();

      return (response as List)
          .map((json) => FoodModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint("Error in fetching data from product table: $e");
      return [];
    }
  }

  const ViewAllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Products"),
      ),
      body: FutureBuilder<List<FoodModel>>(
        future: fetchFoodProduct(),
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                final food = foodList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FoodCardWidget(
                    food: food,
                    onfire: false,
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
