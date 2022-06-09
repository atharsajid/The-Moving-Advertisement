// import 'package:flutter/material.dart';

// import '../../../Constant/colors.dart';
// Widget buildAds() {
//   return Container(
//     padding: EdgeInsets.only(left: 30),
//     clipBehavior: Clip.antiAlias,
//     margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//     width: double.infinity,
//     height: 200,
//     decoration: BoxDecoration(
//       image: DecorationImage(
//         image: AssetImage('images/ad2.jpg'),
//         fit: BoxFit.cover,
//         colorFilter: ColorFilter.mode(
//           Colors.black.withOpacity(0.3),
//           BlendMode.darken,
//         ),
//       ),
//       color: Colors.white,
//       boxShadow: shadow,
//       borderRadius: BorderRadius.circular(32),
//     ),
//     child: Stack(
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Title",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               "Location",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               "Duration",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(
//               width: 250,
//               child: Text(
//                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.justify,
//               ),
//             ),
//           ],
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(12),
//               ),
//               color: primary,
//             ),
//             child: IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
