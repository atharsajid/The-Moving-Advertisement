import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Active%20Ads/active_ads.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Ads%20Campaign/ads_campaign.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Drawer/drawer.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Past%20Ads/past_ads.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Driver's Dashboard"),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            tabs: [
            Column(
              children: [
                Icon(
                  Icons.ad_units,
                  color: Colors.black,
                ),
                Text(
                  'Ads Campaign',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.amp_stories,
                  color: Colors.black,
                ),
                Text(
                  'Active Ads',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.refresh_rounded,
                  color: Colors.black,
                ),
                Text(
                  'Past Ads',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ]),
        ),
        drawer: driverDrawer(),
        body: TabBarView(children: [
          AdsCampaign(),
          ActiveAds(),
          PastAds(),
        ]),
      ));
}
