import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
