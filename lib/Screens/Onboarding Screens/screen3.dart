import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';

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
          Image.asset(
            'images/s1.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Live Tracking",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
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
            onPressed: () {},
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
            onPressed: () {},
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
