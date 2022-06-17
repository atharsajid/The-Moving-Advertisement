import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';

class AdsCreated extends StatefulWidget {
  const AdsCreated({Key? key}) : super(key: key);

  @override
  State<AdsCreated> createState() => _AdsCreatedState();
}

class _AdsCreatedState extends State<AdsCreated> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => Get.to(HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congratulations',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
          ),
          Text(
            'You have been\nsubscribed successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          Image.asset('images/splash1.gif'),
          Text(
            'Your Ad has been\nlisted and it will be\n active as driver avail this Ad.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
