import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Home Screen/home_screen.dart';

class UserLoginController extends GetxController {
  
  bool isLoading = false;
  isLoad(bool isloading) {
    isLoading = isloading;
    update();
  }

  signin(TextEditingController email, TextEditingController pass) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: pass.text);
      isLoad(false);
      Get.off(const HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      isLoad(false);

        Get.snackbar(
          'User not found',
          "Write your email and password correctly",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
      isLoad(false);

        Get.snackbar(
          'Wrong password',
          'Write your password correctly',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
