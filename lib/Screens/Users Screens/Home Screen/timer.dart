import 'package:flutter/material.dart';
import 'package:the_moving_advertisement/Constant/colors.dart';

Widget buildtime(duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final days = twoDigits(duration.inDays.remainder(30));
  final hours = twoDigits(duration.inHours.remainder(24));
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      builditem(
        seconds: days,
        Header: "Days",
      ),
      const SizedBox(
        width: 7,
      ),
      builditem(
        seconds: hours,
        Header: "Hours",
      ),
      const SizedBox(
        width: 7,
      ),
      builditem(
        seconds: minutes,
        Header: "Minutes",
      ),
      const SizedBox(
        width: 7,
      ),
      // builditem(
      //   seconds: seconds,
      //   Header: "Seconds",
      // ),
    ],
  );
}

class builditem extends StatelessWidget {
  const builditem({
    Key? key,
    required this.seconds,
    required this.Header,
  }) : super(key: key);

  final String seconds;
  final String Header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: shadow),
          child: Text(
            seconds,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 45,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(Header,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
      ],
    );
  }
}
