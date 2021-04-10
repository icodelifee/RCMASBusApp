import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/components/vertical_spacer.dart';
import 'package:rcmasbusapp/ui/login/Widgets/generate_otp_btn.dart';
import 'package:rcmasbusapp/ui/login/Widgets/phone_number_field.dart';
import 'package:rcmasbusapp/ui/login/Widgets/top_text.dart';

class GenerateOTPCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        key: ValueKey<int>(0),
        // elevation: 10,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        color: const Color(0xFFF7F7F7),
        child: Container(
          height: Get.height * 0.62,
          child: Column(
            children: [
              VerticalSpacer(num: 18),
              TopText(text: 'Login'),
              VerticalSpacer(num: 22),
              PhoneNumberField(),
              GenerateOTPButton(),
            ],
          ),
        ));
  }
}
