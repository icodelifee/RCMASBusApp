import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/login/Widgets/generate_otp_card.dart';
import 'package:rcmasbusapp/ui/login/Widgets/submit_otp_card.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookWidget {
  final _transitionBuilder = (Widget c, Animation<double> a) => ScaleTransition(
        scale: a,
        child: c,
      );

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
                decoration: cardShadow,
                child: AnimatedSwitcher(
                    transitionBuilder: _transitionBuilder,
                    duration: Duration(milliseconds: 500),
                    child: provider.verificationId == null
                        ? GenerateOTPCard()
                        : SubmitOTPCard())),
          ),
        ],
      ),
    );
  }
}
