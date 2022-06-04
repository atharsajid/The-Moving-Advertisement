import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Constant/colors.dart';
import 'controller.dart';
import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = Get.put(SplashScreenController());
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: GetBuilder<SplashScreenController>(
        builder: (scontroller) {
          return PageView(
            controller: controller,
            children: const [
              Screen1(),
              Screen2(),
              Screen3(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          height: 70,
          child: Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(activeDotColor: secondary, spacing: 10),
              onDotClicked: (index) {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
