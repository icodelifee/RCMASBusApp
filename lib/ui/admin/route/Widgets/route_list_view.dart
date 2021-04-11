import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/ui/admin/route/edit_route.dart';
import 'package:rcmasbusapp/ui/admin/stops/stops_page.dart';

class RoutesListView extends StatelessWidget {
  const RoutesListView({Key? key, required this.data}) : super(key: key);

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            onTap: () =>
                Get.to(() => StopsPage(routeDocId: data[index]['doc'])),
            contentPadding: EdgeInsets.all(20),
            title: Text(data[index]['route_name']),
            subtitle: Text(data[index]['route_location']),
            trailing: IconButton(
              onPressed: () => Get.to(() => EditRoute(route: data[index])),
              icon: Icon(Icons.edit),
            ),
          ),
        );
      },
    );
  }
}
