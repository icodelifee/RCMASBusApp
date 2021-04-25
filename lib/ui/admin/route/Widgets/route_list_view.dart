import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/ui/admin/route/edit_route.dart';
import 'package:rcmasbusapp/ui/admin/route/route_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/stops/stops_page.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';

class RoutesListView extends HookWidget {
  const RoutesListView({Key? key, required this.data}) : super(key: key);

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      showTrackOnHover: true,
      thickness: 5,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              onTap: () =>
                  Get.to(() => StopsPage(routeDocId: data[index]['doc'])),
              contentPadding: EdgeInsets.all(20),
              minLeadingWidth: 5,
              leading: Image.asset(
                'assets/route.png',
                height: 40,
              ),
              title: Text(data[index]['route_name']),
              subtitle: Text(data[index]['route_location']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteRoute(data[index])),
                  IconButton(
                    onPressed: () =>
                        Get.to(() => EditRoute(route: data[index])),
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void deleteRoute(Map<String, dynamic> route) async {
    await Get.dialog(AlertDialog(
      title: Text('Are you sure you want to delete'),
      actions: [
        TextButton(
            onPressed: () async {
              await Get.context!.read(routeProvider).deleteRoute(route['doc']);
              Get.back();
              await Get.context!.refresh(routesProvider);
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
