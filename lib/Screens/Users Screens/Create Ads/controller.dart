import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  var results;
  String downloadurl = '';
  bool isSelected = false;
  String filename = '';
  dynamic path;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> uploadfile(String filepath, String filename) async {
    File file = File(filepath);
    try {
      await storage.ref("AdsImage/$filename").putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  downloadURL(String filename) async {
    String downloadURL =
        await storage.ref('AdsImage/$filename').getDownloadURL();
    downloadurl = downloadURL;
    print(downloadURL);
  }

  resultUpdate(results) {
    results = results;
    update();
  }

  isSelect(isSelect, dynamic pathname) {
    isSelected = isSelect;
    path = pathname;
    update();
  }

  adsUpload(
    String title,
    String location,
    String description,
    String image,
    String duration,
    String email,
  ) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .collection("AdsCampaign")
        .add({
      "title": title,
      "location": location,
      "description": description,
      "image": image,
      "duration": duration
    });
  }

  adsCampaign(
    String title,
    String location,
    String description,
    String image,
    String duration,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection("AdsCampaign").add({
      "title": title,
      "location": location,
      "description": description,
      "image": image,
      "duration": duration,
      "email": email,
    });
  }

  mySubscription(
    int index,
    String tag,
    String duration,
    num price,
    String email,
  ) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .collection("MySubscription").doc('Subscribed')
        .set({
      "index": index,
      "tag": tag,
      "duration": duration,
      "price": price,
    });
  }
}
