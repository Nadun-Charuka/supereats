import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supereats/models/app_banner_model.dart';
import 'package:supereats/models/on_bording_model.dart';

class AppBannerWidget extends StatefulWidget {
  const AppBannerWidget({super.key});

  @override
  State<AppBannerWidget> createState() => _AppBannerWidgetState();
}

class _AppBannerWidgetState extends State<AppBannerWidget> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _autoScroll();
  }

  void _autoScroll() {
    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (_) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final singleScrollAmount =
          MediaQuery.of(context).size.width * 0.9 + 16; // item width + padding

      if (_scrollPosition < maxScroll) {
        _scrollPosition += singleScrollAmount;
      } else {
        _scrollPosition = 0;
      }

      _scrollController.animateTo(
        _scrollPosition,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return FoodBannerScrollingWidget(
              title1: bannerdata[index]["title1"],
              title2: bannerdata[index]["title2"],
              imgUrl: bannerdata[index]["imgUrl"],
              containerColor: bannerdata[index]["containerColor"]);
        },
      ),
    );
  }
}

class FoodBannerScrollingWidget extends StatelessWidget {
  final String title1;
  final String title2;
  final String imgUrl;
  final Color containerColor;
  const FoodBannerScrollingWidget({
    super.key,
    required this.title1,
    required this.title2,
    required this.imgUrl,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 160,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "$title1 \n",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: title2,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: Image.asset(
                imgUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
