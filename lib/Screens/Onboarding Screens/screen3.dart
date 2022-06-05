import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Constant/pic_list.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Login/login.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Login/login.dart';

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(top: 150, bottom: 100),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "Welcome to",
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 32,
          //       ),
          //     ),
          //     Text(
          //       " TMA",
          //       style: TextStyle(
          //         color: secondary,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 32,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          Image.asset(
            'images/s3.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(
            height: 30,
          ),

          const Text(
            "Let's Get Started",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Join Us ",
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const Text(
                "today to grow your business.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            "Continue as",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          OutlinedButton(
            onPressed: () {
              picList.shuffle();
              Get.to(const UserLogin());
            },
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: primary,
              side: BorderSide.none,
              fixedSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
            ),
            child: const Text(
              'User',
              style: TextStyle(
                fontSize: 24,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: () {
              Get.to(const DriverLogin());
            },
            style: OutlinedButton.styleFrom(
              primary: primary,
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.blue, width: 2),
              fixedSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
            ),
            child: const Text(
              'Driver',
              style: TextStyle(
                fontSize: 24,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
