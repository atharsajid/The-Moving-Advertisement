import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserRegController extends GetxController {
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
    String image,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      user(email.text, name.text, phone.text, image);
      shareActive(email.text, false);
      isLoad(false);
      Get.snackbar(
        'Account Created',
        "Your account created successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
      isSelect(false, null);

      name.clear();
      email.clear();
      password.clear();
      phone.clear();
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

  user(
    String email,
    String name,
    String phone,
    String image,
  ) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .collection("Profile")
        .add({
      "Name": name,
      "Email": email,
      "PhoneNo": phone,
      "Image": image,
    });
  }

  driverLoation(String email, bool isActive) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .collection("IsActive")
        .doc('IsActive')
        .set({'IsActive': isActive});
  }

  var results;
  String downloadurl = '';
  bool isSelected = false;
  String filename = '';
  dynamic path;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> uploadfile(String filepath, String filename) async {
    File file = File(filepath);
    try {
      await storage.ref("UserImage/$filename").putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  downloadURL(String filename) async {
    String downloadURL =
        await storage.ref('UserImage/$filename').getDownloadURL();
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
