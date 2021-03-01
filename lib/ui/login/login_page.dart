import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerWidget {
  final _phone = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Color(0xFFFF9D01)),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final provider = watch(loginViewModelProvider);
    return Stack(children: [
      bgImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                duration: Duration(milliseconds: 500),
                child: provider.verificationId == null
                    ? Card(
                        key: ValueKey<int>(0),
                        elevation: 10,
                        shadowColor: Colors.black38,
                        shape: roundedRectangleBorder,
                        color: const Color(0xFFF7F7F7),
                        child: Flex(direction: Axis.horizontal, children: [
                          Expanded(
                            child: Column(
                              children: [
                                verticalSpacer(18),
                                topText('Login'),
                                verticalSpacer(22),
                                phoneNumberField(),
                                generateOTPBtn(context),
                              ],
                            ),
                          )
                        ]))
                    : Card(
                        key: ValueKey<int>(1),
                        elevation: 10,
                        shadowColor: Colors.black38,
                        shape: roundedRectangleBorder,
                        color: const Color(0xFFF7F7F7),
                        child: Flex(direction: Axis.horizontal, children: [
                          Expanded(
                            child: Column(
                              children: [
                                verticalSpacer(18),
                                topText('Enter OTP'),
                                verticalSpacer(22),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: PinPut(
                                    pinAnimationType: PinAnimationType.scale,
                                    fieldsCount: 6,
                                    onSubmit: (String pin) {},
                                    focusNode: _pinPutFocusNode,
                                    controller: _pinPutController,
                                    submittedFieldDecoration:
                                        _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    selectedFieldDecoration: _pinPutDecoration,
                                    followingFieldDecoration:
                                        _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color:
                                            Color(0xFFFF9D01).withOpacity(.5),
                                      ),
                                    ),
                                  ),
                                ),
                                submitOTPBtn(context),
                              ],
                            ),
                          ),
                        ]),
                      ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Image bgImage() {
    return Image.asset('assets/bg.png',
        height: Get.height, width: Get.width, fit: BoxFit.cover);
  }

  SizedBox verticalSpacer(double num) {
    return SizedBox(
      height: Get.height / num,
    );
  }

  Padding generateOTPBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: FlatButton(
        onPressed: () async {
          Get.focusScope.unfocus();
          final login = context.read(loginViewModelProvider);
          final isAdded = await login.checkUserEntry(_phone.text);
          if (isAdded) {
            await login.signIn(_phone.text, context);
          } else {
            showSnackbar('Your number has not been registered!',
                'Please contact the administator.');
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              'Generate OTP',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
        color: Color(0xFF4CBD89),
      ),
    );
  }

  Padding submitOTPBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: FlatButton(
        onPressed: () async {
          await context
              .read(loginViewModelProvider)
              .submitOTP(_pinPutController.text);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              'Submit OTP',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
        color: Color(0xFF4CBD89),
      ),
    );
  }

  Padding phoneNumberField() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        controller: _phone,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            fillColor: Color(0xFFE7E7E7),
            hintText: 'Enter your phone number',
            hintStyle: TextStyle(fontWeight: FontWeight.w700),
            prefix: Padding(
              padding: const EdgeInsets.only(left: 4, right: 6),
              child: Text(
                '+91',
                style: TextStyle(color: Colors.black),
              ),
            ),
            focusedBorder: border,
            border: border,
            enabledBorder: border,
            filled: true),
      ),
    );
  }

  Text topText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.w800,
          fontSize: 27,
          color: const Color(0xFF3F4863)),
    );
  }
}
