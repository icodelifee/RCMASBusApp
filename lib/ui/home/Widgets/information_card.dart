import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/homepage_info_provider.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class InformationCard extends HookWidget {
  const InformationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoProvider = useProvider(informationStreamProvider);
    return infoProvider.when(
        data: (info) => Visibility(
              visible: info['enabled'],
              child: Container(
                margin: EdgeInsets.only(top: 40, left: 15, right: 15),
                // decoration: Get.isDarkMode ? null : cardShadow,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 0.2,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: Get.size.width,
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
                              fontWeight: FontWeight.normal, fontSize: 14),
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
