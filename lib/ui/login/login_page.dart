import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rcmasbusapp/ui/login/Widgets/bg_image.dart';
import 'package:rcmasbusapp/ui/login/Widgets/generate_otp_card.dart';
import 'package:rcmasbusapp/ui/login/Widgets/submit_otp_card.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookWidget {
  final _transitionBuilder =
      (Widget child, Animation<double> animation) => ScaleTransition(
            scale: animation,
            child: child,
          );

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(loginViewModelProvider);
    provider.phone = useTextEditingController();
    provider.pinPutController = useTextEditingController();
    return Stack(children: [
      BgImage(),
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
                  transitionBuilder: _transitionBuilder,
                  duration: Duration(milliseconds: 500),
                  child: provider.verificationId == null
                      ? GenerateOTPCard()
                      : SubmitOTPCard())
            ],
          ),
        ),
      ),
    ]);
  }
}
