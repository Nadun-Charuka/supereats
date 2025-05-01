import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supereats/screens/food_app_home_screen.dart';
import 'package:supereats/screens/profile_screen.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int currentIdex = 0;
  final List<Widget> _pages = [
    FoodAppHomeScreen(),
    Scaffold(),
    ProfileScreen(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIdex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white),
        height: 90,
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
                    radius: 12,
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -25,
                  right: 150,
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
            size: 28,
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
