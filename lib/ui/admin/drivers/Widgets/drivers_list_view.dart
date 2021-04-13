import 'package:flutter/material.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/driver.dart';

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
              contentPadding: EdgeInsets.all(20),
              leading: CircleAvatar(
                radius: 26,
                child: Text(drivers[index].firstName!.substring(0, 1) +
                    drivers[index].lastName!.substring(0, 1)),
              ),
              title: Text(
                  '${drivers[index].firstName!} ${drivers[index].lastName!}'),
              subtitle: Text('${drivers[index].phone}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: () {})
                ],
              ),
            ));
      },
    );
  }
}
