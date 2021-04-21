import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/login/Widgets/generate_otp_card.dart';
import 'package:rcmasbusapp/ui/login/Widgets/submit_otp_card.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(loginViewModelProvider);
    provider.phone = useTextEditingController();
    provider.pinPutController = useTextEditingController();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          )),
      body: Stack(
        children: [
          Image.asset('assets/illust.png'),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  decoration: Get.theme!.brightness == Brightness.dark
                      ? null
                      : cardShadow,
                  child: Card(
                    key: ValueKey<int>(0),
                    shadowColor: Colors.black38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    color: const Color(0xFFF7F7F7),
                    child: Container(
                        height: Get.height * 0.58,
                        child: AnimatedSwitcher(
                            transitionBuilder: (c, a) =>
                                ScaleTransition(scale: a, child: c),
                            duration: Duration(milliseconds: 500),
                            child: provider.verificationId == null
                                ? GenerateOTPCard()
                                : SubmitOTPCard())),
                  ))),
        ],
      ),
    );
  }
}
