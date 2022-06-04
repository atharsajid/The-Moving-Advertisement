import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Home Screen/home_screen.dart';

class DriverProfile extends StatelessWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(DriverHomeScreen());
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('images/pic/5.jpg'),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Muhammad Athar',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'atharsajid@gmail.com',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            '+923402110862',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }
}
