import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Container(
            height: 60,
            width: 200,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 5,
                    color: Colors.grey.shade200,
                  ),
                ],
                borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 50,
                  color: Colors.black,
                  child: const Icon(
                    Icons.no_cell_rounded,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'No Active Ads',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
