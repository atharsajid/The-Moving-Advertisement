import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import '../Home Screen/home_screen.dart';
import '../Login/controller.dart';

class DriverProfile extends StatelessWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic user = FirebaseFirestore.instance
        .collection("Driver")
        .doc(driverEmail)
        .collection("Profile")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(DriverHomeScreen());
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
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
              reverse: true,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(data["Image"]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      data["Name"],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data["Email"],
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      data["PhoneNo"],
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      data["CarName"],
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            data["CarImage"],
                          ),
                        ),
                        color: Colors.white,
                        boxShadow: shadow,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ],
                );
              }).toList());
        },
      ),
    );
  }
}