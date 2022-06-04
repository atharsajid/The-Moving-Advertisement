import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Constant/pic_list.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/About/about.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Profile/profile.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/subscription.dart';

Drawer drawer() {
  return Drawer(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/pic/5.jpg'),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Muhammad Athar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'atharsajid@gmail.com',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 25,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.ad_units,
              color: Colors.black,
            ),
            label: Text(
              'Active Ads',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.location_on_rounded,
              color: Colors.black,
            ),
            label: Text(
              'Live tracking',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextButton.icon(
            onPressed: () {
              Get.to(Subscription());
            },
            icon: Icon(
              Icons.amp_stories,
              color: Colors.black,
            ),
            label: Text(
              'Subscription',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.amp_stories_outlined,
              color: Colors.black,
            ),
            label: Text(
              'My Subscription',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextButton.icon(
            onPressed: () {
              Get.to(UserProfile());
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextButton.icon(
            onPressed: () {
              Get.to(About());
            },
            icon: Icon(
              Icons.subtitles_sharp,
              color: Colors.black,
            ),
            label: Text(
              'About',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          Spacer(),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
              color: primary,
            ),
            label: Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
