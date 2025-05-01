import 'package:flutter/material.dart';
import 'package:supereats/utils/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox(
        width: 45,
        height: 45,
        child: Image.asset("assets/food-delivery/icon/dash.png"),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.red,
            ),
            Text(
              "Nugeemulla road , Kottawa",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/food-delivery/profile.png"),
              ),
            )
          ],
        ),
      ],
    );
  }
}
