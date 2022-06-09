import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/pic_list.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Ads%20Campaign/controller.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Login/controller.dart';
import '../../../Constant/colors.dart';
import '../../Shared Preferences/shared_preferences.dart';

class AdsCampaign extends StatelessWidget {
  const AdsCampaign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adController = Get.put(AdsController());
    dynamic adsCamp =
        FirebaseFirestore.instance.collection("AdsCampaign").snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: adsCamp,
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
                return Container(
                  padding: const EdgeInsets.only(left: 30),
                  clipBehavior: Clip.antiAlias,
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data["image"] ?? unLoadImage),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                    ),
                    color: primary,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Stack(
                    children: [
                      Column(
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
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                            ),
                            color: secondary,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.dialog(AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are your sure to Avail this Ad"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  GetBuilder<AdsController>(
                                      builder: (controller) {
                                    return TextButton(
                                      onPressed: () async {
                                        userAdEmail = data["email"];

                                        UserDriverPreferences.setUserEmail(
                                            userAdEmail);
                                        controller.userActiveAd(
                                          data["title"],
                                          data["location"],
                                          data["description"],
                                          data["image"],
                                          data["duration"],
                                          driverEmail,
                                          userAdEmail,
                                        );
                                        document.reference.delete();
                                        Get.back();
                                      },
                                      child: const Text("Confirm"),
                                    );
                                  }),
                                ],
                              ));
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList());
        },
      ),
    );
  }
}

String userAdEmail = driverEmail;
