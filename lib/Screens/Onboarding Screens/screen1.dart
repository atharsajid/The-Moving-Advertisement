import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

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
            'images/s2.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "The Moving Advertisement",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "GROW YOUR BUSINESS",
            style: TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 2),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "TMA is the best way to advertise products. It allows to choose locations, radius and time to help advertise product on targeted people.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
