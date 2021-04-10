import 'package:flutter/material.dart';

class InternetErrorPage extends StatelessWidget {
  const InternetErrorPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Please connect to internet'),
      ),
    );
  }
}
