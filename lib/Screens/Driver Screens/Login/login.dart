import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Login/controller.dart';
import '../Registration/registration.dart';

class DriverLogin extends StatefulWidget {
  const DriverLogin({Key? key}) : super(key: key);

  @override
  _DriverLoginState createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final driverLoginController = Get.put(DriverLoginController());
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15, bottom: 20),
                child: const Text(
                  "Login as\nDriver",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Image.asset(
                'images/tma.png',
                height: 200,
              ),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  suffixIcon: IconButton(
                    onPressed: () {
                      emailcontroller.clear();
                    },
                    icon: const Icon(Icons.close),
                  ),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: passcontroller,
                obscureText: isVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (isVisible) {
                            isVisible = false;
                          } else {
                            isVisible = true;
                          }
                        });
                      },
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      )),
                  prefixIcon: const Icon(Icons.lock),
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xff4c505b),
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GetBuilder<DriverLoginController>(builder: (controller) {
                    return CircleAvatar(
                      radius: 30,
                      backgroundColor: secondary,
                      child: controller.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : IconButton(
                              color: Colors.white,
                              onPressed: () async {
                                if (emailcontroller.text.isNotEmpty &&
                                    passcontroller.text.isNotEmpty) {
                                  bool result =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (result == true) {
                                    controller.signin(
                                        emailcontroller, passcontroller);
                                    controller.isLoad(true);
                                  } else {
                                    Get.snackbar(
                                      "Network Error",
                                      "Please check your internet connection",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    "Required",
                                    'Please enter your email and password',
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                    );
                  }),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account? click to "),
                TextButton(
                  onPressed: () {
                    Get.to(const DriverRegistration());
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      color: primary,
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
