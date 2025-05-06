import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supereats/providers/cart_provider.dart';
import 'package:supereats/screens/add_to_card_screen.dart';
import 'package:supereats/screens/favorite_screen.dart';
import 'package:supereats/screens/food_app_home_screen.dart';
import 'package:supereats/screens/profile_screen.dart';

class AppMainScreen extends ConsumerStatefulWidget {
  const AppMainScreen({super.key});

  @override
  ConsumerState<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends ConsumerState<AppMainScreen> {
  int currentIdex = 0;
  final List<Widget> _pages = [
    FoodAppHomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
    CartScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final kwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pages[currentIdex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItems(Iconsax.home_15, "A", 0),
            SizedBox(
              width: 10,
            ),
            _buildNavItems(Iconsax.heart, "B", 1),
            SizedBox(
              width: 90,
            ),
            _buildNavItems(Icons.person, "C", 2),
            SizedBox(
              width: 15,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildNavItems(Iconsax.shopping_cart, "D", 3),
                Positioned(
                  top: 16,
                  right: -7,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      ref.watch(cartProvider).value?.length.toString() ?? "0",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -25,
                  right: kwidth * 0.36,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 35,
                    child: Icon(
                      CupertinoIcons.search,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItems(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIdex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: index == currentIdex ? Colors.red : Colors.grey,
          ),
          SizedBox(
            height: 3,
          ),
          CircleAvatar(
            radius: 3,
            backgroundColor:
                index == currentIdex ? Colors.red : Colors.transparent,
          )
        ],
      ),
    );
  }
}
