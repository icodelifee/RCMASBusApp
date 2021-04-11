import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/stops/Widgets/stops_list_view.dart';
import 'package:rcmasbusapp/ui/admin/stops/add_stop.dart';

class StopsPage extends StatelessWidget {
  StopsPage({required this.routeDocId});
  final String routeDocId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AdminAppBar(
          title: 'Stops List',
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => AddStop(
                routeId: routeDocId,
              )),
          child: Icon(
            Icons.add_location_alt_rounded,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: StopsListView(
                  routeId: routeDocId,
                ))));
  }
}
