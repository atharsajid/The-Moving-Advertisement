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
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(children: [
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          data["image"],
                        ),
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
                      "This Ad is active now you  can share your location with user.",
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
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> driverData =
                                  document.data()! as Map<String, dynamic>;
                              return Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 20),
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
                                      true,
                                    );
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
                                      )),
                                ),
                              );
                            }).toList());
                      })
                ]);
              }).toList());
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
      bool isActive) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .collection("DriverLocation")
        .doc('Location')
        .set({
      "DriverEmail": driverEmail,
      "DriverName": driverName,
      "CarImage": carImage,
      "CarModel": carModel,
      "Longtitude": langtitude,
      "Latitude": latitude,
      'IsActive': isActive,
    });
  }
}
