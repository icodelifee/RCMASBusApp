import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerticalSpacer extends StatelessWidget {
  VerticalSpacer({required double num}) : _num = num;
  final double _num;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / _num,
    );
  }
}
