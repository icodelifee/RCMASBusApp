import 'package:flutter/material.dart';

class TextFieldLabel extends StatelessWidget {
  TextFieldLabel({required String label}) : _label = label;
  final String _label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 5),
      child: Text(
        _label,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
    );
  }
}
