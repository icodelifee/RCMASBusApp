import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class InformationCard extends HookWidget {
  const InformationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoProvider = useProvider(informationProvider);
    return infoProvider.when(
        data: (info) => Visibility(
              visible: info['enabled'],
              child: Container(
                padding: EdgeInsets.only(left: 9, right: 9),
                decoration: cardShadow,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: Get.size.width,
                    // height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Information',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Divider(),
                        Text(
                          info['data'],
                          style: TextStyle(
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        loading: () => CustomIndicator(),
        error: (error, stack) => SizedBox());
  }
}
