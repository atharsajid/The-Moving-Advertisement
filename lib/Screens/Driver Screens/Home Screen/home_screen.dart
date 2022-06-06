import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/About/about.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Active%20Ads/active_ads.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Ads%20Campaign/ads_campaign.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Past%20Ads/past_ads.dart';

import '../../../Constant/colors.dart';
import '../Login/controller.dart';
import '../Profile/profile.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  dynamic user = FirebaseFirestore.instance
      .collection("Driver")
      .doc(driverEmail)
      .collection("Profile")
      .snapshots();
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Driver's Dashboard"),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(tabs: [
            Column(
              children: [
                Icon(
                  Icons.ad_units,
                  color: Colors.black,
                ),
                Text(
                  'Ads Campaign',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.amp_stories,
                  color: Colors.black,
                ),
                Text(
                  'Active Ads',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.refresh_rounded,
                  color: Colors.black,
                ),
                Text(
                  'Past Ads',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ]),
        ),
        drawer: driverdrawer(),
        body: TabBarView(children: [
          AdsCampaign(),
          ActiveAds(),
          PastAds(),
        ]),
      ));

  Drawer driverdrawer() {
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
                          Get.to(DriverProfile());
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
                          Get.to(AboutUs());
                        },
                        icon: Icon(
                          Icons.subtitles_rounded,
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
                        height: 100,
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
