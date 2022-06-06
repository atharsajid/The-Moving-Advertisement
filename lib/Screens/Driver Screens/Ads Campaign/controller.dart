import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdsController extends GetxController {
  getThisAd(String title, String location, String description, String image,
      String duration, String driverEmail, String userEmail) async {
    await FirebaseFirestore.instance
        .collection("Driver")
        .doc(driverEmail)
        .collection("ActiveAds")
        .add({
      "title": title,
      "location": location,
      "description": description,
      "image": image,
      "duration": duration,
      "UserEmail": userEmail,
    });
  }
    userActiveAd(String title, String location, String description, String image,
      String duration, String driverEmail, String userEmail) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userEmail)
        .collection("ActiveAds")
        .add({
      "title": title,
      "location": location,
      "description": description,
      "image": image,
      "duration": duration,
      "driverEmail": driverEmail,
    });
  }
}
