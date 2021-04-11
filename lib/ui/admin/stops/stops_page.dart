import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/stops/Widgets/stops_list_view.dart';
import 'package:rcmasbusapp/ui/admin/stops/add_stop.dart';
import 'package:rcmasbusapp/ui/admin/stops/stops_viewmodel.dart';

class StopsPage extends HookWidget {
  StopsPage({required this.routeDocId});
  final String routeDocId;
  @override
  Widget build(BuildContext context) {
    final stopProvider = useProvider(stopsProvider);
    final stops = useFuture(stopProvider.getStops(routeDocId), initialData: []);
    return Scaffold(
        appBar: AdminAppBar(
          title: 'Stops List',
        ),
        floatingActionButton: fab(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: StopsListView(
                  stops: stops,
                  routeId: routeDocId,
                ))));
  }

  FloatingActionButton fab() {
    return FloatingActionButton(
      onPressed: () => Get.to(() => AddStop(
            routeId: routeDocId,
          )),
      child: Icon(
        Icons.add_location_alt_rounded,
        color: Colors.white,
      ),
    );
  }
}
