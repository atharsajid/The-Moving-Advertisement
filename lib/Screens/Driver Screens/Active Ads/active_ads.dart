import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Ads%20Campaign/ads_campaign.dart';

import '../../../Constant/colors.dart';
import '../Login/controller.dart';

class ActiveAds extends StatelessWidget {
  const ActiveAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic activeAds = FirebaseFirestore.instance
        .collection("User")
        .doc(userAdEmail)
        .collection("ActiveAds")
        .doc(driverEmail)
        .collection('ActiveAds')
        .snapshots();
    dynamic driverDetail = FirebaseFirestore.instance
        .collection("Driver")
        .doc(driverEmail)
        .collection("Profile")
        .snapshots();
    return Scaffold(
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
              children: snapshot.data!.docs.map(
                (DocumentSnapshot document) {
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
                          color: primary,
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
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        child: const Text(
                          "This Ad is active now you  can share your location with Advertiser.",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: driverDetail,
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
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: snapshot.data!.docs.map(
                              (DocumentSnapshot document) {
                                Map<String, dynamic> driverData =
                                    document.data()! as Map<String, dynamic>;
                                return Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  height: 60,
                                  width: 200,
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      Position position =
                                          await _determinePosition();

                                      shareLocation(
                                        userAdEmail,
                                        driverEmail,
                                        driverData['Name'],
                                        driverData['CarImage'],
                                        driverData['CarName'],
                                        position.longitude,
                                        position.latitude,
                                        driverData['Image'],
                                        driverData['PhoneNo'],
                                      );
                                      shareActive(userAdEmail, true);
                                      Get.snackbar("Location Shared",
                                          'Your current Location shared to Advertiser',
                                          snackPosition: SnackPosition.BOTTOM);
                                    },
                                    label: const Text(
                                      'Share Location',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(80, 200),
                                      backgroundColor: primary,
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          );
                        },
                      ),
                    ],
                  );
                },
              ).toList());
        },
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  shareLocation(
      String email,
      String driverEmail,
      String driverName,
      String carImage,
      String carModel,
      num langtitude,
      num latitude,
      String driverImage,
      String contact) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .collection("DriverLocation")
        .doc('Location')
        .set(
      {
        "DriverEmail": driverEmail,
        "DriverName": driverName,
        "CarImage": carImage,
        "CarModel": carModel,
        "Longtitude": langtitude,
        "Latitude": latitude,
        "DriverImage": driverImage,
        'DriverContact': contact
      },
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
