
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';

class ActiveAdsContainer extends StatelessWidget {
  const ActiveAdsContainer({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
          vertical: 30, horizontal: 30),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: primary,
        boxShadow: shadow,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: data["image"],
              maxHeightDiskCache: 200,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey,
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2)),
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["title"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  data["location"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  data["duration"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    data["description"],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                ),
                color: secondary,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
