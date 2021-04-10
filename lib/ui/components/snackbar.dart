import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar(String title, String message) {
  Get.snackbar(title, message,
      duration: Duration(seconds: 2),
      borderColor: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(15),
      borderWidth: 1);
}
