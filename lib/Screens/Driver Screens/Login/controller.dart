import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Shared Preferences/shared_preferences.dart';
import '../Home Screen/home_screen.dart';

String driverEmail = '';

class DriverLoginController extends GetxController {
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

      driverEmail = email.text;
      final prefs = await SharedPreferences.getInstance();
      UserDriverPreferences.setDriverEmail(driverEmail);
      prefs.setBool('showHome', true);
      prefs.setBool('isDriver', true);
      Get.off(const DriverHomeScreen());
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
