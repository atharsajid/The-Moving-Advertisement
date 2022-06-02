import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
      color: Colors.white
      ),
      padding: EdgeInsets.only(top: 150,bottom: 100),
      child: Column(
   
        children: [
          Image.asset(
            'images/s2.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          SizedBox(
            height: 30,
          ),
          
          const Text(
            "Subscription",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
