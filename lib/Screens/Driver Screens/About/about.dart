import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Home Screen/home_screen.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(const DriverHomeScreen());
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
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
              "About Us",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: const Text(
                  'Our team includes the brilliant minds of Aizaz, Muhammad Kagdi and Tariq. We started out in a room to create to advertisements for a single person. now we serve a whole home based community for entrepreneurs to market there products.\n \n  Through key partnerships, our company is able to provide each of our clients with the most innovative, high-quality graphics and design services on the market today. We design, print and install vehicle wraps nationwide.\n \n  It is our mission to engage our clients’ branding utilizing the mobile advertising medium. We are proponents of the most effective and unique large format marketing strategies including vehicle wraps, fleet graphics, mobile billboards, and POC media. Our core competency is communicating effectively with our clients’ industry. We dedicate ourselves to the delivery of high-quality products and services, unique solutions, competitive pricing and unparalleled customer service. We do this every day because our clients’ success is our own.\n \n  Whether it’s through vehicle wraps, or fleet graphics, our goal has always been to drive our clients’ brands future.\n \n  Our company caters to your fleet or franchise network needs by creating custom order landing pages specifically for your fleet or graphics design requirements. This assists in the efficiency and transparency of all orders that we process for our fleet and franchise clients.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
