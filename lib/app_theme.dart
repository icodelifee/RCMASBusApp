import 'package:flutter/material.dart';

final circularBorder = BorderRadius.circular(10);

final border = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ));

final roundedRectangleBorder =
    RoundedRectangleBorder(borderRadius: circularBorder);

class AppColors {
  static final Color accentColor = const Color(0xFF4CBD89);
  static final Color buttonColor = const Color(0xFF4CBD89);
  static final Color textInputFillColor = Color(0xFFE7E7E7);
}
