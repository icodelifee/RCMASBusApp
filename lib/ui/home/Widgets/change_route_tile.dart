import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/pay_bus_fee/pay_bus_fee.dart';

class ChangeRouteTile extends StatelessWidget {
  const ChangeRouteTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: Get.theme!.brightness == Brightness.dark ? null : cardShadow,
      margin: EdgeInsets.all(3.0),
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => Get.to(() => PayBusFeePage()),
          child: SizedBox(
            height: 80.0,
            width: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF44B679)),
                    ),
                    Text('Route',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                Gap(10),
                Image.asset(
                  'assets/change-route.png',
                  height: 50,
                  width: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
