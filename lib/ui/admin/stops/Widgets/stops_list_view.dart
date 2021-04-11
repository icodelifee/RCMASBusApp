import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/ui/admin/route/edit_route.dart';
import 'package:rcmasbusapp/ui/admin/stops/edit_stop.dart';

class StopsListView extends StatelessWidget {
  const StopsListView({Key? key, required this.stops, required this.routeId})
      : super(key: key);

  final AsyncSnapshot<List> stops;
  final String routeId;

  @override
  Widget build(BuildContext context) {
    if (stops.connectionState == ConnectionState.waiting) {
      if (stops.data!.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: stops.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(20),
                title: Text(stops.data![index]['stop_name']),
                subtitle: Text(stops.data![index]['stop_location']),
                trailing: IconButton(
                  onPressed: () => Get.to(() => EditStop(
                        stop: stops.data![index],
                        routeId: routeId,
                      )),
                  icon: Icon(Icons.edit),
                ),
              ),
            );
          },
        );
      } else {
        return Center(child: Text('No Stops Found.'));
      }
    } else {
      return Center(child: Text('Some Error Occured'));
    }
  }
}
