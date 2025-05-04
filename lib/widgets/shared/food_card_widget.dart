import 'package:flutter/material.dart';
import 'package:supereats/models/product_model.dart';
import 'package:supereats/screens/food_details_screen.dart';

class FoodCardWidget extends StatelessWidget {
  final FoodModel food;
  final bool onfire;
  const FoodCardWidget({
    super.key,
    required this.food,
    required this.onfire,
  });

  @override
  Widget build(BuildContext context) {
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
                Icons.favorite_border_rounded,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: food.imageCard,
                  child: Image.network(
                    food.imageCard,
                    width: 120,
                    height: 120,
                    errorBuilder: (context, error, stackTrace) =>
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
