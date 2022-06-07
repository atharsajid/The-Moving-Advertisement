import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Active%20Ads/active_ads.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Login/controller.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/my_subscription.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/subscription.dart';

import '../About/about.dart';
import '../Profile/profile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // Future initState()  async{
  //   final prefs = await SharedPreferences.getInstance();
  //   userEmail = prefs.getString('userEmail').toString();

  //   super.initState();
  // }

  dynamic user = FirebaseFirestore.instance
      .collection("User")
      .doc(userEmail)
      .collection("Profile")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Live Tracking",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    'images/map.jpg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1),
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(32),
                color: customWhiteColor),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 60,
                    width: 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 50,
                          color: Colors.black,
                          child: const Icon(
                            Icons.no_cell_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'No Active Ads',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Text(
            "Click here to get Subscription",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            height: 60,
            width: 200,
            decoration: BoxDecoration(
              boxShadow: shadow,
              color: secondary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextButton(
              onPressed: () {
                Get.to(const Subscription());
              },
              child: const Text(
                'Get Subscription',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: StreamBuilder<QuerySnapshot>(
          stream: user,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(data["Image"]),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        data["Name"],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data["Email"],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.to(UserActiveAds());
                        },
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
                        height: 15,
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
                        height: 15,
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
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.to(MySubscription());
                        },
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
                        height: 15,
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
                        height: 15,
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
                      SizedBox(
                        height: 15,
                      ),
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
                  );
                }).toList());
          },
        ),
      ),
    );
  }
}
