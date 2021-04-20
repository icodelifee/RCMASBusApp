import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';
import 'package:rcmasbusapp/ui/login/login_page.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';

class UnderReviewWidget extends HookWidget {
  const UnderReviewWidget({
    Key? key,
  }) : super(key: key);

  final double _sigmaX = 1; // from 0-10
  final double _sigmaY = 1; // from 0-10
  final double _opacity = 0.75; // from 0-1.0

  @override
  Widget build(BuildContext context) {
    final pass = useProvider(busPassProvider);
    return pass.when(
        data: (BusPass bp) => Visibility(
              visible: !bp.isApproved!,
              child: Container(
                width: Get.size.width,
                height: Get.size.height,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                  child: Container(
                    color: Colors.black.withOpacity(_opacity),
                    child: Center(
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: Get.size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Your bus pass request is under review, Please contact the administator if you have any queries regarding this process.',
                                style: TextStyle(fontSize: 19),
                              ),
                              Gap(20),
                              TextButton(
                                  style: buttonStyle,
                                  onPressed: () {
                                    context
                                        .read(loginViewModelProvider)
                                        .signOut();
                                    userContainer.clear();
                                    Get.offAll(LoginPage());
                                  },
                                  child: SizedBox(
                                    height: 30,
                                    width: Get.size.width,
                                    child: Center(
                                      child: Text(
                                        'Sign Out',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  )),
                              Gap(10),
                              TextButton(
                                  style: buttonStyle,
                                  onPressed: () {
                                    SystemNavigator.pop();
                                  },
                                  child: SizedBox(
                                    height: 30,
                                    width: Get.size.width,
                                    child: Center(
                                      child: Text(
                                        'Quit App',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        loading: () => SizedBox(),
        error: (err, trace) => SizedBox());
  }
}
