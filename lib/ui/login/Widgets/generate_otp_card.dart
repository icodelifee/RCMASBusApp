import 'package:flutter/material.dart';
import 'package:rcmasbusapp/ui/components/vertical_spacer.dart';
import 'package:rcmasbusapp/ui/login/Widgets/generate_otp_btn.dart';
import 'package:rcmasbusapp/ui/login/Widgets/phone_number_field.dart';
import 'package:rcmasbusapp/ui/login/Widgets/top_text.dart';

class GenerateOTPCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpacer(num: 18),
        TopText(text: 'Login'),
        VerticalSpacer(num: 22),
        PhoneNumberField(),
        GenerateOTPButton(),
      ],
    );
  }
}
