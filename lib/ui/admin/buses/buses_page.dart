import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/buses_list_view.dart';
import 'package:rcmasbusapp/ui/admin/buses/add_bus.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class BusesPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final bProvider = useProvider(busesProvider);
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Buses List',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddBus(edit: false)),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: bProvider.when(
            data: (List<Bus> buses) {
              if (buses.isNotEmpty) {
                return BusesListView(buses: buses);
              } else {
                return Center(
                  child: Text('No Buses Found'),
                );
              }
            },
            loading: () => CustomIndicator(),
            error: (error, stack) {
              return Center(
                child: Text('Some Error Occured'),
              );
            }),
      ),
    );
  }
}
