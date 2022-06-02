import 'package:flutter/material.dart';
class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/screen1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Text("The Moving Advertisement",style:TextStyle(
           color: Colors.black,
           fontWeight: FontWeight.bold,
           fontSize: 32,
         ),)
         
        ],
      ),
    );
  }
}