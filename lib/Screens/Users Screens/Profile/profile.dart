import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Login/controller.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic user = FirebaseFirestore.instance
        .collection("User")
        .doc(userEmail)
        .collection("Profile")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(const HomeScreen());
          },
          icon: const Icon(
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
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        data["Image"],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      data["Name"],
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data["Email"],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      data["PhoneNo"],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                );
              }).toList());
        },
      ),
    );
  }
}
