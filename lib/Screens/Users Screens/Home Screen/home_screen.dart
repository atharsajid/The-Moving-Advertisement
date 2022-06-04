import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Drawer/drawer.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/subscription.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Live Tracking",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    'images/map.jpg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1),
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(32),
                color: customWhiteColor),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 60,
                    width: 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 50,
                          color: Colors.black,
                          child: const Icon(
                            Icons.no_cell_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'No Active Ads',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Text(
            "Click here to get Subscription",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            height: 60,
            width: 200,
            decoration: BoxDecoration(
              boxShadow: shadow,
              color: secondary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextButton(
              onPressed: () {
                Get.to(const Subscription());
              },
              child: const Text(
                'Get Subscription',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
