import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Create\nUser\nAccount",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 43,
                          fontWeight: FontWeight.bold),
                    ),
                    GetBuilder<UserRegController>(builder: (controller) {
                      return Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 120,
                            width: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/gallery.png'),
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                controller.isSelected
                                    ? Align(
                                        alignment: Alignment.center,
                                        child: Image.file(
                                          File(controller.path),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              controller.results =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ["jpg", "png", "jpeg"],
                              );
                              controller.resultUpdate(controller.results);

                              if (controller.results == null) {
                                Get.snackbar('No File Selected',
                                    'Kindly select your Ads Image');
                              }
                              final pathname =
                                  controller.results.files.single.path;
                              controller.filename =
                                  controller.results.files.single.name;
                              controller
                                  .uploadfile(pathname, controller.filename)
                                  .then(
                                    (value) => controller
                                        .downloadURL(controller.filename),
                                  );
                              if (controller.results != null) {
                                controller.isSelect(true, pathname);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: secondary,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Upload Image",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    })
                  ],
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
                                  if (controller.results != null) {
                                    bool result =
                                        await InternetConnectionChecker()
                                            .hasConnection;
                                    if (result == true) {
                                      controller.registration(
                                        emailcontroller,
                                        passcontroller,
                                        namecontroller,
                                        phonecontroller,
                                        controller.downloadurl,
                                      );
                                      controller.driverLoation(
                                          emailcontroller.text, false);
                                      controller.isLoad(true);
                                    } else {
                                      Get.snackbar("Image Required",
                                          "Kingly upload your profile pic",
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
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
