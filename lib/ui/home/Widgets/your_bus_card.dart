import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class YourBusCard extends HookWidget {
  const YourBusCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bpProvider = useProvider(yourBusProvider);
    return Positioned(
      top: 80,
      child: Container(
          // height: 150,
          width: Get.size.width,
          padding: EdgeInsets.only(left: 14, right: 14),
          decoration: cardShadow,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              child: bpProvider.when(
                  error: (err, trace) => Center(
                        child: Text(err.toString()),
                      ),
                  loading: () => CustomIndicator(),
                  data: (val) {
                    final stop = val.route!.stops!.firstWhere(
                        (element) => element.stopId == val.busPass!.stopId);
                    return Container(
                      padding: EdgeInsets.all(25),
                      width: Get.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              busNumber(val),
                              Gap(10),
                              busStop(stop),
                              Gap(4),
                              busTime(stop),
                            ],
                          ),
                          Image.asset(
                            'assets/bus.png',
                            height: 70,
                            width: 70,
                          )
                        ],
                      ),
                    );
                  }))),
    );
  }

  Row busTime(Stop stop) {
    return Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          color: Color(0xFF366BEC),
          size: 26,
        ),
        Gap(6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(DateFormat.jm().format(stop.arrivalTime!.toDate()))
          ],
        ),
      ],
    );
  }

  Row busStop(Stop stop) {
    return Row(
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
            Text(stop.stopLocation!),
          ],
        ),
      ],
    );
  }

  Column busNumber(YourBus val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Bus',
          style: TextStyle(color: Color(0xFF777777)),
        ),
        Text(
          'Bus number ${val.bus!.busNo}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )
      ],
    );
  }
}
