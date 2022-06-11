import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Registration/controller.dart';
import '../Login/login.dart';

class CarRegistration extends StatefulWidget {
  final TextEditingController namecontroller;
  final TextEditingController emailcontroller;
  final TextEditingController phonecontroller;
  final TextEditingController passcontroller;
  const CarRegistration({
    Key? key,
    required this.namecontroller,
    required this.emailcontroller,
    required this.phonecontroller,
    required this.passcontroller,
  }) : super(key: key);

  @override
  _CarRegistrationState createState() => _CarRegistrationState();
}

class _CarRegistrationState extends State<CarRegistration> {
  TextEditingController carcontroller = TextEditingController();

  final driverRegController = Get.put(DriverRegController());

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
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    bottom: 50, top: MediaQuery.of(context).size.height * 0.06),
                child: const Text(
                  "Car Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 43,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GetBuilder<DriverRegController>(builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Car Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/gallery.png'),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          controller.carSelected
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Image.file(
                                    File(controller.carFilePath),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () async {
                            controller.carResult =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ["jpg", "png", "jpeg"],
                            );
                            controller.carResultUpdate(controller.carResult);

                            if (controller.carResult == null) {
                              Get.snackbar('No File Selected',
                                  'Kindly select your Car Image');
                            }
                            final pathname =
                                controller.carResult.files.single.path;
                            controller.carFileName =
                                controller.carResult.files.single.name;
                            controller
                                .uploadCar(pathname, controller.carFileName)
                                .then(
                                  (value) => controller
                                      .downloadCarURL(controller.carFileName),
                                );
                            if (controller.carResult != null) {
                              controller.carSelect(true, pathname);
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
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: 15,
              ),
              TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: carcontroller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  hintText: 'Car Model',
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 15,
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
                GetBuilder<DriverRegController>(builder: (controller) {
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
                              if (carcontroller.text.isNotEmpty) {
                                if (controller.carResult != null) {
                                  bool result =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (result == true) {
                                    controller.registration(
                                      widget.emailcontroller,
                                      widget.passcontroller,
                                      widget.namecontroller,
                                      widget.phonecontroller,
                                      controller.carUrl,
                                      carcontroller.text,
                                      controller.downloadurl,
                                    );
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
                                    "Please select your car image",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "Required",
                                  "Please enter your car model",
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
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Already have an account? Click here to '),
                TextButton(
                  onPressed: () {
                    Get.to(const DriverLogin());
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
