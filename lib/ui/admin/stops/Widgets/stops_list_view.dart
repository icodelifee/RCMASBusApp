import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/ui/admin/stops/edit_stop.dart';
import 'package:rcmasbusapp/ui/admin/stops/stops_viewmodel.dart';

class StopsListView extends HookWidget {
  const StopsListView({Key? key, required this.routeId}) : super(key: key);

  final String routeId;

  @override
  Widget build(BuildContext context) {
    final stopProvider = useProvider(stopsProvider);
    final stops = useFuture(stopProvider.getStops(routeId), initialData: []);
    if (stops.connectionState == ConnectionState.waiting) {
      if (stops.data!.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: stops.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(20),
                leading: Image.asset(
                  'assets/bus-stop.png',
                  height: 35,
                ),
                minLeadingWidth: 30,
                title: Text(stops.data![index].stopName!),
                subtitle: Text(stops.data![index].stopLocation!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () =>
                          deleteStop(stops.data![index].toJson(), stopProvider),
                      icon: Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () => Get.to(() => EditStop(
                            stop: stops.data![index].toJson(),
                            routeId: routeId,
                          )),
                      icon: Icon(Icons.edit),
                    ),
                  ],
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

  void deleteStop(
      Map<String, dynamic> stop, StopsViewModel stopProvider) async {
    await Get.dialog(AlertDialog(
      title: Text('Are you sure you want to delete'),
      actions: [
        TextButton(
            onPressed: () async {
              await stopProvider.deleteStop(stop['doc'], routeId);
              Get.context!.refresh(stopsProvider);
              Get.back();
            },
            child: Text('Yes')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('No')),
      ],
    ));
  }
}
