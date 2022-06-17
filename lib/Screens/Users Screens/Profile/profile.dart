import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Login/controller.dart';

import '../../Onboarding Screens/onboarding_screens.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic user = FirebaseFirestore.instance
        .collection("User")
        .doc(userEmail)
        .collection("Profile")
        .snapshots();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', false);
                prefs.setBool('isDriver', false);
                Get.off(const SplashScreen());
              },
              icon: Icon(Icons.logout_outlined),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Get.to(const HomeScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white),
      body: Stack(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/pattern.jpg'), fit: BoxFit.cover),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: user,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: data["Image"],
                            maxHeightDiskCache: 120,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey,
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          data["Name"],
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Advertiser",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email:",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Text(
                                      data["Email"],
                                      style: const TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                indent: 20,
                                endIndent: 20,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Contact No:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    data["PhoneNo"],
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.black,
                                indent: 20,
                                endIndent: 20,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Active Ads:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.amp_stories,
                                    color: primary,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    activeAds,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.black,
                                indent: 20,
                                endIndent: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList());
            },
          ),
        ],
      ),
    );
  }
}

String activeAds = "No Active Ads";
