import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supereats/widgets/food_app_home_screen_widgets/app_banner.dart';
import 'package:supereats/widgets/food_app_home_screen_widgets/app_bar.dart';
import 'package:supereats/widgets/food_app_home_screen_widgets/categories_bar.dart';
import 'package:supereats/widgets/food_app_home_screen_widgets/popular_bar.dart';
import 'package:supereats/widgets/food_app_home_screen_widgets/popular_product.dart';

class FoodAppHomeScreen extends ConsumerWidget {
  const FoodAppHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBannerWidget(),
                SizedBox(height: size.height * 0.02),
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                CategoriesBarWidget(),
                SizedBox(height: size.height * 0.02),
                const PopularBarWidget(),
                SizedBox(height: size.height * 0.01),
                PopularProductWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
