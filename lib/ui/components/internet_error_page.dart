import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InternetErrorPage extends StatelessWidget {
  const InternetErrorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/no-internet.png',
                  width: Get.width / 1.3,
                  fit: BoxFit.cover,
                ),
                Gap(100),
                Text(
                  'App requires internet connection.',
                  style: TextStyle(fontSize: 21.5, fontWeight: FontWeight.bold),
                ),
                Gap(10),
                Text(
                  'Please connect to internet.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ])),
    );
  }
}
