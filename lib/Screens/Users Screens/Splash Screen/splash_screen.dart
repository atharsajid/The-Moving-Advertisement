import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Ads%20Campaign/ads_campaign.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Home%20Screen/home_screen.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Login/controller.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Active%20Ads/active_ads.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';

import '../Login/controller.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    driverSP();
    userSP();
    userAdEm();
    Timer(const Duration(seconds: 3),
        () => Get.to(isDriver ? DriverHomeScreen() : HomeScreen()));
  }



  userSP() async {
    final sharePreferences = await SharedPreferences.getInstance();
    driverAdEmail = sharePreferences.getString('UserEmail').toString();
    userEmail = sharePreferences.getString('UserEmail').toString();
  }

  userAdEm() async {
    final sharePreferences = await SharedPreferences.getInstance();
    userAdEmail = sharePreferences.getString('UserEmail').toString();
  }

  driverSP() async {
    final sharePreferences = await SharedPreferences.getInstance();
    driverEmail = sharePreferences.getString('DriverEmail').toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Image.asset(
            'images/tma.png',
            height: 200,
          ),
        ],
      ),
    );
  }
}

bool isDriver = false;
