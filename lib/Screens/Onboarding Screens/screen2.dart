import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 150,
          ),
          Image.asset(
            'images/s1.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Live Tracking",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          Text(
            "Track your Ads.",
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          const Text(
            "TMA allows to track ads at anytime\nfrom anywhere",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
