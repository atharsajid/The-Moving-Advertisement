import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';
import 'package:the_moving_advertisement/Screens/Users%20Screens/Home%20Screen/timer.dart';

class Bottomsheet extends StatelessWidget {
  const Bottomsheet({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            24,
          ),
          topRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: data['DriverImage'],
                          maxHeightDiskCache: 120,
                          height: 120,
                          width: 120,
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
                      Text(
                        data['DriverName'],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Driver",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildtime(
                        Duration(
                          seconds: data['DurationTime'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Distance Covered:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: primary,
                  ),
                  Text(
                    "${data['Distance'].toStringAsFixed(2) ?? 0.0}KM",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Email:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: primary,
                  ),
                  Text(
                    data['DriverEmail'],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Contact No:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: primary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    data['DriverContact'],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Car Model:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.car_rental,
                    color: primary,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    data['CarModel'],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                indent: 20,
                endIndent: 20,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                height: 200,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadow,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: data['CarImage'],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
