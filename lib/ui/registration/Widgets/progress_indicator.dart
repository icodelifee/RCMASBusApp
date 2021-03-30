import 'package:flutter/material.dart';
import 'package:rcmasbusapp/app_theme.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
    ));
  }
}
