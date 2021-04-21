import 'package:flutter/material.dart';
import 'package:get/get.dart';

final circularBorder = BorderRadius.circular(10);

final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ));

final roundedRectangleBorder =
    RoundedRectangleBorder(borderRadius: circularBorder);

final buttonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  backgroundColor: MaterialStateProperty.all(AppColors.buttonColor),
);

InputDecoration inputDecoration(String hint) => InputDecoration(
    border: border,
    focusedBorder: border,
    enabledBorder: border,
    filled: true,
    fillColor: AppColors.textInputFillColor,
    hintText: hint);

final cardShadow = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Get.isDarkMode ? Colors.transparent : Colors.grey.withOpacity(.3),
      blurRadius: 25.0, // soften the shadow
      spreadRadius: 0.0, //extend the shadow
      offset: Offset(
        5.0, // Move to right 10  horizontally
        5.0, // Move to bottom 10 Vertically
      ),
    )
  ],
);

class AppColors {
  static final Color accentColor = const Color(0xFF4CBD89);
  static final Color buttonColor = const Color(0xFF4CBD89);
  static final Color textInputFillColor = Color(0xFFE7E7E7);
  static final Color secondaryColor = const Color(0xFFFF8F60);
}
