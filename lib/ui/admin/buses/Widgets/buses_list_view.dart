import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/ui/admin/buses/add_bus.dart';
import 'package:rcmasbusapp/ui/admin/buses/view_bus.dart';

class BusesListView extends StatelessWidget {
  const BusesListView({Key? key, required this.buses}) : super(key: key);
  final List<Bus> buses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: buses.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            shape: roundedRectangleBorder,
            child: ListTile(
              leading: Image.asset(
                'assets/bus.png',
                height: 50,
              ),
              minLeadingWidth: 80,
              onTap: () => Get.to(() => ViewBus(bus: buses[index])),
              contentPadding: EdgeInsets.all(20),
              title: Text('Bus Number ${buses[index].busNo!}'),
              subtitle: Text('${buses[index].busLicenseNo}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Get.to(() => AddBus(
                            edit: true,
                            bus: buses[index],
                          )))
                ],
              ),
            ));
      },
    );
  }
}
