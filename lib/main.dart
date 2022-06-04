import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';
import 'Constant/colors.dart';
import 'Screens/Driver Screens/Home Screen/home_screen.dart';
import 'Screens/Onboarding Screens/onboarding_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: const DriverHomeScreen(),
    );
  }
}
