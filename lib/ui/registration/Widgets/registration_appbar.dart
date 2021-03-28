import 'package:flutter/material.dart';

class RegistrationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  RegistrationAppBar({Key? key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);
  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Registration',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
