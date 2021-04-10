import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/route/Widgets/route_list_view.dart';
import 'package:rcmasbusapp/ui/admin/route/add_route.dart';
import 'package:rcmasbusapp/ui/admin/route/edit_route.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';

class RouteListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final routes = useProvider(routesProvider);
    return Scaffold(
        appBar: AdminAppBar(
          title: 'Routes List',
        ),
        floatingActionButton: fab(),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(10),
                child: routes.when(
                    data: (data) => RoutesListView(
                          data: data,
                        ),
                    loading: () => CustomIndicator(),
                    error: (error, stack) =>
                        Center(child: Text('Some Error Occured'))))));
  }

  ListView listViewBuilder(data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
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

  FloatingActionButton fab() {
    return FloatingActionButton(
      onPressed: () => Get.to(() => AddRoute()),
      child: Icon(
        Icons.add_location_alt_rounded,
        color: Colors.white,
      ),
    );
  }
}
