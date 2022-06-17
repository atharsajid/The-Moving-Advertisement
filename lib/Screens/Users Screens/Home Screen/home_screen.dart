import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Onboarding%20Screens/onboarding_screens.dart';
import 'package:the_moving_advertisement/Screens/Shared%20Preferences/shared_preferences.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Active%20Ads/active_ads.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/bottom_sheet.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/no_active_ads_widget.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Login/controller.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/my_subscription.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/subscription.dart';
import '../About/about.dart';
import '../Profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(24.871951512, 67.0552456), zoom: 15.0);

  Set<Marker> markers = {};

  dynamic getLocation = FirebaseFirestore.instance
      .collection("User")
      .doc(userEmail)
      .collection("DriverLocation")
      .snapshots();

  dynamic isActive = FirebaseFirestore.instance
      .collection("User")
      .doc(userEmail)
      .collection("IsActive")
      .snapshots();
  dynamic user = FirebaseFirestore.instance
      .collection("User")
      .doc(userEmail)
      .collection("Profile")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(UserProfile());
              },
              icon: Icon(Icons.person))
        ],
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: drawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: isActive,
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
                return data['IsActive'] == true
                    ? Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: getLocation,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              return ListView(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: snapshot.data!.docs.map(
                                    (DocumentSnapshot document) {
                                      Map<String, dynamic> data = document
                                          .data()! as Map<String, dynamic>;
                                      return Column(
                                        children: [
                                          const Text(
                                            "Live Tracking",
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    offset: const Offset(7, 7),
                                                    blurRadius: 15,
                                                  ),
                                                  const BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(-7, -7),
                                                    blurRadius: 12,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(32),
                                                color: customWhiteColor),
                                            child: GoogleMap(
                                              initialCameraPosition:
                                                  initialCameraPosition,
                                              markers: markers,
                                              zoomControlsEnabled: true,
                                              mapType: MapType.normal,
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                googleMapController =
                                                    controller;
                                              },
                                            ),
                                          ),
                                          const Text(
                                            "Click here to get your Ad Location",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
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
                                                child: TextButton(
                                                  onPressed: () async {
                                                    googleMapController
                                                        .animateCamera(
                                                      CameraUpdate
                                                          .newCameraPosition(
                                                        CameraPosition(
                                                            target: LatLng(
                                                                data[
                                                                    'Latitude'],
                                                                data[
                                                                    'Longtitude']),
                                                            zoom: 14),
                                                      ),
                                                    );

                                                    markers.clear();

                                                    markers.add(Marker(
                                                        markerId: const MarkerId(
                                                            'currentLocation'),
                                                        position: LatLng(
                                                            data['Latitude'],
                                                            data[
                                                                'Longtitude'])));

                                                    setState(() {});
                                                    driverAdEmail =
                                                        data['DriverEmail'];
                                                  },
                                                  child: const Text(
                                                    'Get Location',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Container(
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
                                                child: TextButton(
                                                  onPressed: () async {
                                                    driverAdEmail =
                                                        data['DriverEmail'];
                                                    showModalBottomSheet(
                                                      isDismissible: true,
                                                      enableDrag: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (context) =>
                                                          Bottomsheet(
                                                              data: data),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Get Details',
                                                    style: TextStyle(
                                                      color: secondary,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ).toList());
                            },
                          ),
                        ],
                      )
                    : NoActiveAds();
              }).toList());
        },
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data["Email"],
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.to(const UserActiveAds());
                        },
                        icon: const Icon(
                          Icons.ad_units,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Active Ads',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.location_on_rounded,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Live tracking',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.to(const Subscription());
                        },
                        icon: const Icon(
                          Icons.amp_stories,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Subscription',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.to(const MySubscription());
                        },
                        icon: const Icon(
                          Icons.amp_stories_outlined,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'My Subscription',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.to(const UserProfile());
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.to(const About());
                        },
                        icon: const Icon(
                          Icons.subtitles_sharp,
                          color: Colors.black,
                        ),
                        label: const Text(
                          'About',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          UserDriverPreferences.setUserEmail(userEmail);
                          prefs.setBool('showHome', false);
                          prefs.setBool('isDriver', false);
                          Get.off(const SplashScreen());
                        },
                        icon: Icon(
                          Icons.logout,
                          color: primary,
                        ),
                        label: const Text(
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
