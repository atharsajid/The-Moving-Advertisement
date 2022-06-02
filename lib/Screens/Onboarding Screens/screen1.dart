import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 150,bottom: 100),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image.asset(
            'images/s3.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          SizedBox(
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
          SizedBox(
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
          Spacer(),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 30),
             child: Text(
              
              "TMA is the best way to advertise products. It allows to chose location, radius and time to advertise product on targeted people.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
          ),
           ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
