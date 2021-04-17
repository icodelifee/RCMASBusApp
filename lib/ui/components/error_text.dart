import 'package:flutter/cupertino.dart';

class ErrorText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Error Occured!\nPlease Try Again Later.',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
