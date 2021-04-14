import 'dart:math';

import 'package:flutter/material.dart';

class AvatarIcon extends StatelessWidget {
  AvatarIcon({Key? key, required this.firstName, required this.lastName})
      : super(key: key);

  final String firstName;
  final String lastName;
  final Color color =
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: color,
      child: Text(
        firstName.substring(0, 1) + lastName.substring(0, 1),
        style: TextStyle(
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
