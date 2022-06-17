import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';

import '../../../Constant/colors.dart';
import '../Login/controller.dart';

class UserActiveAds extends StatelessWidget {
  const UserActiveAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic activeAds = FirebaseFirestore.instance
        .collection("User")
        .doc(userEmail)
        .collection("ActiveAds")
        .doc(driverAdEmail)
        .collection('ActiveAds')
        .snapshots();
    dynamic getLocation = FirebaseFirestore.instance
        .collection("User")
        .doc(userEmail)
        .collection("DriverLocation")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.to(const HomeScreen());
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Active Ads'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: activeAds,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: shadow,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: data["image"],
                              maxHeightDiskCache: 200,
                              height: double.infinity,
                              width: double.infinity,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data["title"],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  data["location"],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  data["duration"],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    data["description"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          boxShadow: shadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: getLocation,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return ListView(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot locationdocument) {
                                    Map<String, dynamic> location = document
                                        .data()! as Map<String, dynamic>;
                                    return TextButton.icon(
                                      onPressed: () {
                                        Get.dialog(AlertDialog(
                                          title: const Text("Delete"),
                                          content: const Text(
                                              "Are your sure to delete this Ad"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                locationdocument.reference
                                                    .delete();
                                                document.reference.delete();
                                                shareActive(userEmail, false);
                                                Get.back();
                                              },
                                              child: const Text("Confirm"),
                                            ),
                                          ],
                                        ));
                                      },
                                      label: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: secondary,
                                          fontSize: 22,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.delete,
                                        color: secondary,
                                      ),
                                    );
                                  }).toList());
                            })),
                  ],
                );
              }).toList());
        },
      ),
    );
  }

  shareActive(String email, bool isActive) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .collection("IsActive")
        .doc('IsActive')
        .set({
      'IsActive': isActive,
    });
  }
}

String driverAdEmail = '';
