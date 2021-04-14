import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/drivers/Widgets/drivers_list_view.dart';
import 'package:rcmasbusapp/ui/admin/drivers/add_driver.dart';
import 'package:rcmasbusapp/ui/admin/drivers/drivers_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class DriversPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final dprovider = useProvider(driversProvider);
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Drivers List',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddDriver(edit: false)),
        child: Icon(
          Icons.person_add_alt,
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: dprovider.when(
            data: (List<Driver> drivers) {
              if (drivers.isNotEmpty) {
                return DriversListView(
                  drivers: drivers,
                );
              } else {
                return Center(
                  child: Text('No Drivers Found'),
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
