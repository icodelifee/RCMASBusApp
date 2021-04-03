import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';

class RouteStopDetails extends StatelessWidget {
  const RouteStopDetails({Key? key, required this.stop, required this.data})
      : super(key: key);

  final Stop stop;
  final YourBus data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Route & Stop Details'),
        Gap(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Route Name'),
                Text(
                  data.route!.routeName!,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Gap(14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Route Location'),
                Text(
                  data.route!.routeLocation!,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
        Gap(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stop Name'),
            Text(
              stop.stopName!,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        Gap(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stop Location'),
            Text(
              stop.stopLocation!,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        Gap(10),
        Text('Time'),
        Text(
          DateFormat.jm().format(stop.arrivalTime!.toDate()),
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
