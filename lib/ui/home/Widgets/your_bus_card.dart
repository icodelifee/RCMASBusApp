import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';

class YourBusCard extends StatelessWidget {
  const YourBusCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90,
      child: Container(
          height: 150,
          width: Get.size.width,
          padding: EdgeInsets.only(left: 14, right: 14),
          decoration: cardShadow,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(25),
                width: Get.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Bus',
                              style: TextStyle(color: Color(0xFF777777)),
                            ),
                            Text(
                              'Bus number 1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/location.png',
                              height: 40,
                              width: 22,
                            ),
                            Gap(6),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bus stop',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Thopumpady')
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Image.asset(
                      'assets/bus.png',
                      height: 70,
                      width: 70,
                    )
                  ],
                ),
              ))),
    );
  }
}
