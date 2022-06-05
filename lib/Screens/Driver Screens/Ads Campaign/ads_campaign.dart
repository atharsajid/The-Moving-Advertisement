import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Screens/Driver%20Screens/Ads%20Campaign/ads_widget.dart';

class AdsCampaign extends StatelessWidget {
  const AdsCampaign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildAds(),
        ],
      ),
    );
  }
}
