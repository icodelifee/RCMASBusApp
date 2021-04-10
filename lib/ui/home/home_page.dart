import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';

import 'package:rcmasbusapp/ui/home/Widgets/drawer.dart';
import 'package:rcmasbusapp/ui/home/Widgets/under_review.dart';
import 'package:rcmasbusapp/ui/pay_bus_fee/pay_bus_fee.dart';
import 'package:rcmasbusapp/ui/your_payments/your_payments_page.dart';
import 'package:rcmasbusapp/ui/your_profile/your_profile_page.dart';
import 'Widgets/bus_details_tile.dart';
import 'Widgets/bus_pass_tile.dart';
import 'Widgets/information_card.dart';
import 'Widgets/bus_fee_tile.dart';
import 'Widgets/your_bus_card.dart';
import 'Widgets/your_profile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width / 3;
    final cardHeight = MediaQuery.of(context).size.height / 10;

    final boxDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)));

    final bgImage = BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage('assets/bg.png')));

    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: DrawerWidget(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          width: Get.size.width,
          height: Get.size.height,
          decoration: bgImage,
          child: Stack(
            children: <Widget>[
              YourBusCard(),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  // margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: boxDecoration,
                  height: Get.height * 0.62,
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Gap(30),
                        InformationCard(),
                        GridView.count(
                          childAspectRatio: cardWidth / cardHeight,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 0,
                          padding: EdgeInsets.only(
                              top: 10, bottom: 40, left: 15, right: 15),
                          children: [
                            BusPassTile(),
                            YourProfileTile(),
                            BusDetailsTile(),
                            PayBusFeeTile(),
                            Container(
                              height: 80.0,
                              decoration: cardShadow,
                              margin: EdgeInsets.all(3.0),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  borderRadius: circularBorder,
                                  onTap: () => Get.to(() => YourPaymentsPage()),
                                  child: SizedBox(
                                    height: 80.0,
                                    width: 150.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Your',
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF44B679)),
                                            ),
                                            Text('Payments',
                                                style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                        ),
                                        Gap(10),
                                        Image.asset(
                                          'assets/your-payments.png',
                                          height: 50,
                                          width: 50,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 80.0,
                              decoration: cardShadow,
                              margin: EdgeInsets.all(3.0),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () => Get.to(() => PayBusFeePage()),
                                  child: SizedBox(
                                    height: 80.0,
                                    width: 150.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Change',
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF44B679)),
                                            ),
                                            Text('Route',
                                                style: TextStyle(
                                                  fontSize: 19,
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
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              UnderReviewWidget(),
            ],
          ),
        ));
  }
}
