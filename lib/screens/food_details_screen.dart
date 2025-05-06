import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';
import 'package:supereats/models/product_model.dart';
import 'package:supereats/providers/cart_provider.dart';
import 'package:supereats/utils/colors.dart';
import 'package:supereats/widgets/snackbar.dart';

class FoodDetailsScreen extends ConsumerStatefulWidget {
  final FoodModel food;
  const FoodDetailsScreen({
    super.key,
    required this.food,
  });

  @override
  ConsumerState<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends ConsumerState<FoodDetailsScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final kheight = MediaQuery.of(context).size.height;
    final kwidth = MediaQuery.of(context).size.width;
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
            width: kwidth,
            height: kheight,
            child: Image.asset(
              "assets/food-delivery/food pattern.png",
              fit: BoxFit.cover,
              color: imageBackground2,
            ),
          ),
          Container(
            width: kwidth,
            height: kheight * 0.75,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 64,
                ),
                Hero(
                  tag: widget.food.imageCard,
                  child: CachedNetworkImage(
                    imageUrl: widget.food.imageDetail,
                    height: kheight * 0.4,
                    errorWidget: (context, url, error) => Icon(
                      Icons.fastfood,
                      size: 250,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 40,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
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
                      InkWell(
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
                  height: 16,
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
                  trimLength: 80,
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
        onPressed: () {
          ref.read(cartProvider.notifier).addToCart(
                widget.food.id,
                quantity: quantity,
              );
          showSnackBar(context, "${widget.food.name} added to cart");
        },
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
    final kwidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 45,
      width: kwidth * 0.28,
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
