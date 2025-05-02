import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:supereats/models/product_model.dart';
import 'package:supereats/utils/colors.dart';

class FoodDetailsScreen extends StatefulWidget {
  final FoodModel food;
  const FoodDetailsScreen({
    super.key,
    required this.food,
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        actions: [
          Spacer(
            flex: 1,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
          Spacer(
            flex: 6,
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.more_horiz_rounded,
              color: Colors.black,
              size: 18,
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: imageBackground,
            width: size.width,
            height: size.height,
            child: Image.asset(
              "assets/food-delivery/food pattern.png",
              fit: BoxFit.cover,
              color: imageBackground2,
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.food.imageCard,
                  child: Image.network(
                    widget.food.imageDetail,
                    height: 320,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity > 1 ? quantity-- : 1;
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            quantity >= 1 ? quantity++ : 1;
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.food.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.food.specialItems,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "\$",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                            children: [
                              TextSpan(
                                text: widget.food.price.toString(),
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExtraDetailCard(
                      data: widget.food.rate.toString(),
                      iconUrl: "assets/food-delivery/icon/star.png",
                    ),
                    ExtraDetailCard(
                      data: "${widget.food.kcal.toString()} kcal",
                      iconUrl: "assets/food-delivery/icon/fire.png",
                    ),
                    ExtraDetailCard(
                        data: "${widget.food.time} min",
                        iconUrl: "assets/food-delivery/icon/time.png"),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                ReadMoreText(
                  desc,
                  style: TextStyle(
                    height: 1.5,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  trimLength: 110,
                  trimCollapsedText: "read more",
                  trimExpandedText: "show less",
                  colorClickableText: Colors.redAccent,
                  moreStyle: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        label: SizedBox(
          height: 65,
          width: 300,
          child: Center(
            child: Text(
              "Add to Cart",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class ExtraDetailCard extends StatelessWidget {
  final dynamic data;
  final String iconUrl;
  const ExtraDetailCard({
    super.key,
    required this.data,
    required this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              iconUrl,
              width: 30,
              height: 30,
            ),
            Text(
              data,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
