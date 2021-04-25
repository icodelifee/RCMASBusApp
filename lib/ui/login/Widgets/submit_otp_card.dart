import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rcmasbusapp/ui/components/vertical_spacer.dart';
import 'package:rcmasbusapp/ui/login/Widgets/submit_otp_btn.dart';
import 'package:rcmasbusapp/ui/login/Widgets/top_text.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';

class SubmitOTPCard extends HookWidget {
  final FocusNode _pinPutFocusNode = FocusNode();
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Color(0xFFFF9D01)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(loginViewModelProvider);
    return Column(
      children: [
        VerticalSpacer(num: 18),
        TopText(text: 'Enter OTP'),
        VerticalSpacer(num: 22),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: PinPut(
            pinAnimationType: PinAnimationType.scale,
            fieldsCount: 6,
            onSubmit: (String pin) {},
            focusNode: _pinPutFocusNode,
            controller: provider.pinPutController,
            submittedFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(20.0),
            ),
            selectedFieldDecoration: _pinPutDecoration,
            followingFieldDecoration: _pinPutDecoration.copyWith(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Color(0xFFFF9D01).withOpacity(.5),
              ),
            ),
          ),
        ),
        SubmitOTPBtn(),
        Gap(10),
        TextButton(
            onPressed: () {
              context.refresh(loginViewModelProvider);
            },
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: Colors.black),
                  Gap(14),
                  Text(
                    'Go Back',
                    style: TextStyle(color: Colors.black),
                  ),
                ]))
      ],
    );
  }
}
