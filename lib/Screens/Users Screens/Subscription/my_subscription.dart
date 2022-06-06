import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Create%20Ads/create_ads.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/controller.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/model.dart';

import '../Login/controller.dart';

class MySubscription extends StatelessWidget {
  const MySubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slidercontroller = Get.put(SliderController());
    dynamic user = FirebaseFirestore.instance
        .collection("User")
        .doc(userEmail)
        .collection("MySubscription")
        .snapshots();
    return Scaffold(
      backgroundColor: customWhiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: user,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                      ),
                      const Text(
                        "My Subscription",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildSubscription(data["index"], context),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 180,
                        decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          "Subscribed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]);
              }).toList());
        },
      ),
    );
  }
}

Widget buildSubscription(int index, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.75,
    height: MediaQuery.of(context).size.height * 0.65,
    // width: 200,
    clipBehavior: Clip.antiAlias,
    padding: const EdgeInsets.symmetric(vertical: 0),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: customWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(7, 7),
            blurRadius: 15,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-7, -7),
            blurRadius: 12,
          ),
        ]),
    child: Column(
      children: [
        Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                height: 30,
                width: 110,
                decoration: BoxDecoration(
                    color: secondary, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  subsList[index].tag,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                subsList[index].duration,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${subsList[index].price}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    subsList[index].radius,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    subsList[index].location,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    subsList[index].hours,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    subsList[index].get,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    subsList[index].tracking,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
