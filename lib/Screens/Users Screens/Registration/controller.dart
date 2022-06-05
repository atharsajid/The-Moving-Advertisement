import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/pic_list.dart';

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
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      user(email.text, name.text, phone.text,picList[0]);
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
    await FirebaseFirestore.instance.collection("User").doc(email).set({
      "Name": name,
      "Email": email,
      "PhoneNo": phone,
      "Image":image,
    });
  }
}
