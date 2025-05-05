import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supereats/models/product_model.dart';
import 'package:supereats/providers/cart_provider.dart';
import 'package:supereats/providers/favorite_provider.dart';
import 'package:supereats/screens/food_details_screen.dart';
import 'package:supereats/widgets/snackbar.dart';

class FoodCardWidget extends ConsumerWidget {
  final FoodModel food;
  final bool onfire;
  const FoodCardWidget({
    super.key,
    required this.food,
    required this.onfire,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) =>
                FoodDetailsScreen(
              food: food,
            ),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.45,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          onfire
              ? Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red[100],
                    child: Image.asset("assets/food-delivery/icon/fire.png"),
                  ),
                )
              : Text(""),
          Positioned(
            top: 10,
            left: -10,
            child: IconButton(
              icon: Icon(
                ref.watch(favoriteProvider).value?.contains(food.id) == true
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
              color: Colors.pink,
              onPressed: () {
                ref.read(favoriteProvider.notifier).toggleFavorite(food.id);
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: food.imageCard,
                  child: CachedNetworkImage(
                    imageUrl: food.imageCard,
                    height: 110,
                    width: 110,
                    placeholder: (context, url) => Shimmer.fromColors(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 120,
                        height: 120,
                      ),
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.fastfood, size: 70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    food.name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(food.specialItems),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "\$",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        children: [
                          TextSpan(
                            text: food.price.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(ref
                                  .watch(cartProvider)
                                  .value
                                  ?.any((item) => item.productId == food.id) ==
                              true
                          ? Icons.remove_shopping_cart
                          : Icons.add_shopping_cart),
                      onPressed: () {
                        ref.read(cartProvider.notifier).toggleCart(food.id);
                        ref.watch(cartProvider).value?.any(
                                    (item) => item.productId == food.id) ==
                                true
                            ? showSnackBar(
                                context, "${food.name} delete from cart")
                            : showSnackBar(
                                context, "${food.name} added to cart");
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
