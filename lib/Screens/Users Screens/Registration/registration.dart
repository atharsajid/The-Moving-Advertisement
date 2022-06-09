import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Login/login.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Registration/controller.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final userRegController = Get.put(UserRegController());
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: const Text(
                  "Create\nUser\nAccount",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 43,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: namecontroller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintText: 'Name',
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: emailcontroller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: phonecontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintText: 'Phone No.',
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: passcontroller,
                obscureText: isVisible,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
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
                      color: Colors.white,
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GetBuilder<UserRegController>(builder: (controller) {
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
                              if (namecontroller.text.isNotEmpty &&
                                  emailcontroller.text.isNotEmpty &&
                                  phonecontroller.text.isNotEmpty &&
                                  passcontroller.text.isNotEmpty) {
                                if (phonecontroller.text.length == 11) {
                                  bool result =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (result == true) {
                                    controller.registration(
                                      emailcontroller,
                                      passcontroller,
                                      namecontroller,
                                      phonecontroller,
                                    );
                                    controller.driverLoation(
                                        emailcontroller.text, false);
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
                                    'Invalid Number',
                                    "Please enter your correct number",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  'Required',
                                  "All Fields are required",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                  );
                }),
              ]),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Already have an account? Click here to '),
                TextButton(
                  onPressed: () {
                    Get.to(const UserLogin());
                  },
                  child: Text(
                    'Login',
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
