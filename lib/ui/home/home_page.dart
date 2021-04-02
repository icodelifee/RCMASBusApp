import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:rcmasbusapp/ui/home/Widgets/drawer.dart';
import 'package:rcmasbusapp/ui/home/Widgets/under_review.dart';
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
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: boxDecoration,
                  height: Get.height * 0.65,
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
                              top: 10, bottom: 40, left: 8, right: 8),
                          children: [
                            BusPassTile(),
                            YourProfileTile(),
                            BusDetailsTile(),
                            PayBusFeeTile(),
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