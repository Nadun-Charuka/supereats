import 'package:flutter/material.dart';
import 'package:supereats/models/on_bording_model.dart';
import 'package:supereats/screens/app_main_screen.dart';
import 'package:supereats/utils/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: imageBackground,
            child: Image.asset(
              "assets/food-delivery/food pattern.png",
              color: imageBackground2,
              repeat: ImageRepeat.repeatY,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -80,
            left: 0,
            right: 0,
            child: Image.asset("assets/food-delivery/chef.png"),
          ),
          Positioned(
            top: 139,
            right: 50,
            child: Image.asset(
              "assets/food-delivery/leaf.png",
              width: 80,
            ),
          ),
          Positioned(
            top: 390,
            right: 40,
            child: Image.asset(
              "assets/food-delivery/chili.png",
              width: 80,
            ),
          ),
          Positioned(
            top: 230,
            left: -20,
            child: Image.asset(
              "assets/food-delivery/ginger.png",
              width: 80,
              height: 90,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(1800, 600),
                topRight: Radius.elliptical(1800, 600),
              ),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 75,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 160,
                        child: PageView.builder(
                          onPageChanged: (value) {
                            setState(() {
                              _currentPage = value;
                            });
                          },
                          controller: _pageController,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: data[index]["title1"],
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: data[index]["title2"],
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  " ${data[index]["description"]}",
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          data.length,
                          (index) => AnimatedContainer(
                            duration: Duration(
                              microseconds: 300,
                            ),
                            width: _currentPage == index ? 20 : 10,
                            height: 10,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? Colors.orange
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: Size(250, 65),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => AppMainScreen()));
                        },
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
