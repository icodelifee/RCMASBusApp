import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/not-found.png',
          height: Get.height / 3.5,
        ),
        Gap(30),
        Text(
          'No Data Found!',
          style: TextStyle(fontSize: 20),
        )
      ],
    ));
  }
}
