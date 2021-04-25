import 'package:flutter/cupertino.dart';

extension ToBold on String {
  Text toBold() {
    return Text(
      this,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
