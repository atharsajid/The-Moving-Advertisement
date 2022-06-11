import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class DriverRegController extends GetxController {
  bool isLoading = false;
  isLoad(bool isloading) {
    isLoading = isloading;
    update();
  }

  registration(
    TextEditingController email,
    TextEditingController password,
    TextEditingController name,
    TextEditingController phone,
    String carImage,
    String carName,
    String image,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      driver(email.text, name.text, phone.text, carImage, carName, image);
      isLoad(false);
      Get.snackbar(
        'Account Created',
        "Your account created successfully",
        snackPosition: SnackPosition.BOTTOM,
      );

      name.clear();
      email.clear();
      password.clear();
      phone.clear();
      carSelect(false, null);
      isSelect(false, null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isLoad(false);

        Get.snackbar(
          'Weak Password',
          'The password provided is too weak.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'email-already-in-use') {
        isLoad(false);

        Get.snackbar(
          'Account Already exist',
          'The account already exists for that email.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      isLoad(false);

      print(e);
    }
  }

  driver(
    String email,
    String name,
    String phone,
    String carImage,
    String carName,
    String image,
  ) async {
    await FirebaseFirestore.instance
        .collection("Driver")
        .doc(email)
        .collection("Profile")
        .add({
      "Name": name,
      "Email": email,
      "PhoneNo": phone,
      "CarImage": carImage,
      "CarName": carName,
      "Image": image,
    });
  }

  //Profile Pic filepicker functions
  var results;
  String downloadurl = '';
  bool isSelected = false;
  String filename = '';
  dynamic path;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> uploadfile(String filepath, String filename) async {
    File file = File(filepath);
    try {
      await storage.ref("DriverImage/$filename").putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  downloadURL(String filename) async {
    String downloadURL =
        await storage.ref('DriverImage/$filename').getDownloadURL();
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

  var carResult;
  String carUrl = '';
  bool carSelected = false;
  String carFileName = '';
  dynamic carFilePath;
  final FirebaseStorage carStorage = FirebaseStorage.instance;
  Future<void> uploadCar(String filepath, String filename) async {
    File file = File(filepath);
    try {
      await carStorage.ref("CarImage/$filename").putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  downloadCarURL(String filename) async {
    String downloadURL =
        await carStorage.ref('CarImage/$filename').getDownloadURL();
    carUrl = downloadURL;
    print(carUrl);
  }

  carResultUpdate(carResult) {
    carResult = carResult;
    update();
  }

  carSelect(isSelect, dynamic pathname) {
    carSelected = isSelect;
    carFilePath = pathname;
    update();
  }
}
