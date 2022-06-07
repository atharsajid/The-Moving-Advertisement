import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/home_screen.dart';

import '../../../Constant/colors.dart';
import '../Login/controller.dart';

class UserActiveAds extends StatelessWidget {
  const UserActiveAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic activeAds = FirebaseFirestore.instance
        .collection("User")
        .doc(userEmail)
        .collection("ActiveAds")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Get.to(HomeScreen());
            },
            icon: Icon(Icons.arrow_back_ios),),
            title: Text('Active Ads'),
          backgroundColor: Colors.transparent,
elevation: 0,      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: activeAds,
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
                return Container(
                  padding: EdgeInsets.only(left: 30),
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data["image"]),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                    ),
                    color: primary,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["title"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            data["location"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            data["duration"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              data["description"],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                            ),
                            color: secondary,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.dialog(AlertDialog(
                                title: Text("Close"),
                                content: Text("Are your sure to close this Ad"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      document.reference.delete();
                                      Get.back();
                                    },
                                    child: Text("Confirm"),
                                  ),
                                ],
                              ));
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList());
        },
      ),
    );
  }
}
