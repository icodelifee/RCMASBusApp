import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/route/Widgets/route_list_view.dart';
import 'package:rcmasbusapp/ui/admin/route/add_route.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => AddRoute()),
          child: Icon(
            Icons.add_location_alt_rounded,
            color: Colors.white,
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: routes.when(
                data: (data) => RoutesListView(
                      data: data,
                    ),
                loading: () => CustomIndicator(),
                error: (error, stack) =>
                    Center(child: Text('Some Error Occured')))));
  }
}
