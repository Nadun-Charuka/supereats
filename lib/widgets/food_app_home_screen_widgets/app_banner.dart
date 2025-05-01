import 'package:flutter/material.dart';
import 'package:supereats/utils/colors.dart';

class AppBannerWidget extends StatelessWidget {
  const AppBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: imageBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 160,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  text: "The Fastest in \n",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "Food ",
                      style: TextStyle(
                        color: red,
                      ),
                    ),
                    TextSpan(text: "Delivery")
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                ),
                onPressed: () {},
                child: Text(
                  "Order Now",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              "assets/food-delivery/courier.png",
            ),
          ),
        ],
      ),
    );
  }
}
