import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/ui/admin/drivers/add_driver.dart';
import 'package:rcmasbusapp/ui/admin/drivers/view_driver.dart';
import 'package:rcmasbusapp/ui/components/avatar_icon.dart';

class DriversListView extends StatelessWidget {
  const DriversListView({Key? key, required this.drivers}) : super(key: key);
  final List<Driver> drivers;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: drivers.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            shape: roundedRectangleBorder,
            child: ListTile(
              onTap: () {
                Get.bottomSheet(ViewDriver(driver: drivers[index]));
              },
              contentPadding: EdgeInsets.all(20),
              leading: AvatarIcon(
                firstName: drivers[index].firstName!,
                lastName: drivers[index].lastName!,
              ),
              title: Text(
                  '${drivers[index].firstName!} ${drivers[index].lastName!}'),
              subtitle: Text('${drivers[index].phone}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Get.to(() => AddDriver(
                            edit: true,
                            driver: drivers[index],
                          )))
                ],
              ),
            ));
      },
    );
  }
}
