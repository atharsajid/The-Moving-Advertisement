import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Create%20Ads/controller.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';

class CreateAds extends StatefulWidget {
  int index;
  num price;
  String duration;
  String tag;
  CreateAds({
    Key? key,
    required this.index,
    required this.price,
    required this.duration,
    required this.tag,
  }) : super(key: key);

  @override
  State<CreateAds> createState() => _CreateAdsState();
}

class _CreateAdsState extends State<CreateAds> {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final storage = Get.put(StorageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Text(
            "Create your Ads",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Upload your Ads Image"),
          GetBuilder<StorageController>(builder: (controller) {
            return Container(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/gallery.png'),
                ),
                color: Colors.white,
                boxShadow: shadow,
                borderRadius: BorderRadius.circular(32),
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
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: GetBuilder<StorageController>(
                        builder: (controller) {
                          return IconButton(
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
                            icon: const Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextField(
                        controller: titleController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintText: 'Title',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextField(
                        controller: locationController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintText: 'Location',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: 100,
                      child: TextFormField(
                        controller: descriptionController,
                        expands: true,
                        maxLines: null,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintText: 'Write your description',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  Get.to(HomeScreen());
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  primary: primary,
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  side: BorderSide(color: primary),
                ),
                child: Text(
                  "Cancle",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GetBuilder<StorageController>(builder: (controller) {
                return OutlinedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        locationController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      if (controller.results != null) {
                        controller.adsUpload(
                          titleController.text,
                          locationController.text,
                          descriptionController.text,
                          controller.downloadurl,
                          widget.duration,
                          'atharsajid@gmail.com',
                        );
                        controller.mySubscription(
                            widget.index,
                            widget.tag,
                            widget.duration,
                            widget.price,
                            'atharsajid@gmail.com');
                        controller.adsCampaign(
                          titleController.text,
                          locationController.text,
                          descriptionController.text,
                          controller.downloadurl,
                          widget.duration,
                          "atharsajid@gmail.com",
                        );
                        titleController.clear();
                        locationController.clear();
                        descriptionController.clear();
                        controller.isSelect(false, null);
                      } else {
                        Get.snackbar('Required', 'Image must be selected');
                      }
                    } else {
                      Get.snackbar(
                        "Required",
                        'All fields are required',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: primary,
                      primary: Colors.white,
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      side: BorderSide.none),
                  child: Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
