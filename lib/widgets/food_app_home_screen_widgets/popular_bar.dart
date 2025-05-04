import 'package:flutter/material.dart';
import 'package:supereats/screens/view_all_product_screen.dart';

class PopularBarWidget extends StatelessWidget {
  const PopularBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Popular Now",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewAllProductScreen()));
          },
          child: Row(
            children: [
              Text(
                "view all",
                style: TextStyle(
                  letterSpacing: -0.5,
                  fontSize: 18,
                  color: Colors.deepOrange,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 10,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
