import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Active%20Ads/activeAdsContainer.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Active%20Ads/timer_controller.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Ads%20Campaign/ads_campaign.dart';

import '../../../Constant/colors.dart';
import '../Login/controller.dart';

class ActiveAds extends StatefulWidget {
  const ActiveAds({Key? key}) : super(key: key);

  @override
  State<ActiveAds> createState() => _ActiveAdsState();
}

class _ActiveAdsState extends State<ActiveAds> {
  bool isStoped = true;
  double coveredDistance = 0;
  double lat1 = 0;
  double lat2 = 0;
  double lang1 = 0;
  double lang2 = 0;

  final timercontroller = Get.put(TimerController());
  dynamic timeDuration = FirebaseFirestore.instance
      .collection("User")
      .doc(userAdEmail)
      .collection("DriverLocation")
      .snapshots();
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
  @override
  Widget build(BuildContext context) {
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
                      ActiveAdsContainer(data: data),
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
                      const SizedBox(
                        height: 25,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: timeDuration,
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
                                Map<String, dynamic> timeData =
                                    document.data()! as Map<String, dynamic>;
   
                                coveredDistance = timeData['Distance'] ?? 0;
                                timercontroller.init(Duration(
                                    seconds: timeData['DurationTime'] ?? 0));

                                return Column(
                                  children: [
                                    GetBuilder<TimerController>(
                                        builder: (controller) {
                                      return Container(
                                        child: controller.buildtime(),
                                      );
                                    }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 70,
                                            width: 200,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: shadow),
                                            child: FittedBox(
                                              child: Text(
                                                "${coveredDistance.toStringAsFixed(2)}KM",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 45,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text('Distance Covered',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GetBuilder<TimerController>(builder: (contr) {
                        return Container(
                          child: contr.isStoped
                              ? StreamBuilder<QuerySnapshot>(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 80),
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: snapshot.data!.docs.map(
                                        (DocumentSnapshot document) {
                                          Map<String, dynamic> driverData =
                                              document.data()!
                                                  as Map<String, dynamic>;
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            height: 50,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              boxShadow: shadow,
                                              color: secondary,
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: GetBuilder<TimerController>(
                                                builder: (controller) {
                                              return TextButton.icon(
                                                onPressed: () async {
                                                  Position position =
                                                      await _determinePosition();
                                                  setState(() {
                                                    lat1 = position.latitude;
                                                    lang1 = position.longitude;
                                                  });
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
                                                      seconds,
                                                      coveredDistance);
                                                  shareActive(
                                                      userAdEmail, true);
                                                  Get.snackbar(
                                                      "Location Shared",
                                                      'Your current Location shared to Advertiser',
                                                      snackPosition:
                                                          SnackPosition.BOTTOM);
                                                  controller.starttimer();
                                                  controller
                                                      .isStoppedCheck(false);
                                                },
                                                icon: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                                label: const Text(
                                                  'Start',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ).toList(),
                                    );
                                  },
                                )
                              : StreamBuilder<QuerySnapshot>(
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 80),
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: snapshot.data!.docs.map(
                                        (DocumentSnapshot document) {
                                          Map<String, dynamic> driverData =
                                              document.data()!
                                                  as Map<String, dynamic>;
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            height: 50,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              boxShadow: shadow,
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: GetBuilder<TimerController>(
                                                builder: (controller) {
                                              return TextButton.icon(
                                                onPressed: () async {
                                                  controller.stoptimer();
                                                  Position position =
                                                      await _determinePosition();
                                                  double newDistance = 0;
                                                  double distance =
                                                      await Geolocator
                                                          .distanceBetween(
                                                    lat1,
                                                    lang1,
                                                    position.latitude,
                                                    position.longitude,
                                                  );
                                                  newDistance = distance / 1000;
                                                  newDistance =
                                                      coveredDistance +
                                                          newDistance;
                                                  print(newDistance);

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
                                                      seconds,
                                                      newDistance);
                                                  controller
                                                      .isStoppedCheck(true);
                                                },
                                                icon: Icon(
                                                  Icons.stop,
                                                  color: secondary,
                                                ),
                                                label: Text(
                                                  'Stop',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ).toList(),
                                    );
                                  },
                                ),
                        );
                      }),
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

  getDistance(lat1, lang1, lat2, lang2, distanceCovered) async {
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
    double distance =
        await Geolocator.distanceBetween(lat1, lang1, lat2, lang2);

    // print(coveredDistance.toStringAsFixed(2));
    return distance;
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
      String contact,
      int seconds,
      double distance) async {
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
        'DriverContact': contact,
        'DurationTime': seconds,
        'Distance': distance,
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
