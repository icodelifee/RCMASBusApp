import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/bg.png',
        height: Get.height, width: Get.width, fit: BoxFit.cover);
  }
}
