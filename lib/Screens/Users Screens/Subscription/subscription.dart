import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Create%20Ads/create_ads.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/controller.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Subscription/model.dart';

class Subscription extends StatelessWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slidercontroller = Get.put(SliderController());
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
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            width: double.infinity,
          ),
          const Text(
            "Choose Your Plan",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetBuilder<SliderController>(builder: (controller) {
            return CarouselSlider.builder(
              itemCount: subsList.length,
              itemBuilder: (context, index, realIndex) {
                return buildMemes(index);
              },
              carouselController: controller.controller,
              options: CarouselOptions(
                height: 550,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  controller.index(index);
                },
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<SliderController>(builder: (controller) {
            return subsList[controller.activeIndex].isSubscribed
                ? OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        backgroundColor: secondary,
                        primary: Colors.white,
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        side: BorderSide.none),
                    child: const Text(
                      "Subscribed",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : OutlinedButton(
                    onPressed: () {
                      controller.price(subsList[controller.activeIndex].price);
                      controller.indexSelected(controller.activeIndex);
                      Get.to(
                        CreateAds(
                            tag: subsList[controller.selectedIndex].tag,
                            index: controller.selectedIndex,
                            price: controller.priceSelected,
                            duration:
                                subsList[controller.selectedIndex].duration),
                      );
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
                      "Subscribe",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
          }),
          const SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }

  Widget buildMemes(int index) {
    return Container(
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  subsList[index].duration,
                  style: GoogleFonts.pacifico(
                      textStyle: TextStyle(color: Colors.white, fontSize: 32)),
                ),
                Text(
                  "\$${subsList[index].price}",
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 15,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        subsList[index].radius,
                        style: GoogleFonts.merriweather(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        subsList[index].location,
                        style: GoogleFonts.merriweather(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        subsList[index].hours,
                        style: GoogleFonts.merriweather(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        subsList[index].get,
                        style: GoogleFonts.merriweather(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        subsList[index].tracking,
                        style: GoogleFonts.merriweather(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
