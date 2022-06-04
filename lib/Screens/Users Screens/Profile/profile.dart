import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(HomeScreen());
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
