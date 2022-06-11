import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Create%20Ads/controller.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Login/controller.dart';
import 'package:http/http.dart' as http;
import 'package:the_moving_advertisement/Screens/Users%20Screens/Splash%20Screen/ads_created.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/model.dart';

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

  Map<String, dynamic>? paymentIntentData;

  final storage = Get.put(StorageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            const Text(
              "Create your Ads",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Upload your Ads Image"),
            GetBuilder<StorageController>(builder: (controller) {
              return Container(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                height: 200,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  image: const DecorationImage(
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
                        : const SizedBox(),
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
              padding: const EdgeInsets.only(left: 20),
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const Text(
                          "Title",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
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
                    Get.to(const HomeScreen());
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
                  child: const Text(
                    "Cancle",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GetBuilder<StorageController>(builder: (controller) {
                  return OutlinedButton(
                    onPressed: () async {
                      if (titleController.text.isNotEmpty &&
                          locationController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        if (controller.results != null) {
                          await makePayment(widget.price.toString());
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
                    child: const Text(
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
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntentData = await createPaymentIntent(
          amount, 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        print('payment intent${paymentIntentData!['id']}');
        print('payment intent${paymentIntentData!['client_secret']}');
        print('payment intent${paymentIntentData!['amount']}');
        print('payment intent$paymentIntentData');
        //orderPlaceApi(paymentIntentData!['id'].toString());
        storage.adsUpload(
          titleController.text,
          locationController.text,
          descriptionController.text,
          storage.downloadurl,
          widget.duration,
          userEmail,
        );
        storage.mySubscription(
            widget.index, widget.tag, widget.duration, widget.price, userEmail);
        storage.adsCampaign(
          titleController.text,
          locationController.text,
          descriptionController.text,
          storage.downloadurl,
          widget.duration,
          userEmail,
        );
        subsList[widget.index].isSubscribed = true;
        titleController.clear();
        locationController.clear();
        descriptionController.clear();

        storage.isSelect(false, null);
        Get.to(AdsCreated());
        Get.snackbar(
          "Ads Created Successfully",
          "Your transaction has been performed successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51L87iZLWfZkyaxftNz3VuJ2rEhk7sSG5s664aMzdLhz3idDVBT0q40Q3Ff7nfS3cNz1z6wUAVgS1pItgRTA8ayup00UvhlvmaI',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
