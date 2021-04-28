import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/ui/home/Widgets/change_route_tile.dart';

import 'package:rcmasbusapp/ui/home/Widgets/drawer.dart';
import 'package:rcmasbusapp/ui/home/Widgets/under_review.dart';
import 'package:rcmasbusapp/ui/home/Widgets/your_payment_tile.dart';
import 'Widgets/bus_details_tile.dart';
import 'Widgets/bus_pass_tile.dart';
import 'Widgets/information_card.dart';
import 'Widgets/bus_fee_tile.dart';
import 'Widgets/your_bus_card.dart';
import 'Widgets/your_profile.dart';

class HomePage extends HookWidget {
  void initMessage() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await FirebaseMessaging.instance.subscribeToTopic('admin');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 101,
        displayOnForeground: true,
        channelKey: 'basic_channel',
        title: message.notification!.title,
        notificationLayout: NotificationLayout.BigText,
        body: message.notification!.body,
        showWhen: true,
        autoCancel: true,
      ));
    });

  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      initMessage();
    }, []);

    final cardWidth = MediaQuery.of(context).size.width / 3;
    final cardHeight = MediaQuery.of(context).size.height / 10;

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
                  decoration: BoxDecoration(
                      color: Color(0xFFF2F2F0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  height: Get.height * 0.6,
                  width: Get.width,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
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
                            top: 25, bottom: 40, left: 15, right: 15),
                        children: [
                          BusPassTile(),
                          YourProfileTile(),
                          BusDetailsTile(),
                          PayBusFeeTile(),
                          YourPaymentsTile(),
                          ChangeRouteTile()
                        ],
                      )
                    ],
                  ),
                ),
              ),
              UnderReviewWidget(),
            ],
          ),
        ));
  }
}
