import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/route/Widgets/route_location_textfield.dart';
import 'package:rcmasbusapp/ui/admin/route/Widgets/route_name_textfield.dart';
import 'package:rcmasbusapp/ui/admin/route/route_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class EditRoute extends HookWidget {
  EditRoute({required this.route});
  final routeEditKey = GlobalKey<FormState>();
  final Map<String, dynamic> route;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(routeProvider);
    provider.routeLoc = useTextEditingController(text: route['route_location']);
    provider.routeName = useTextEditingController(text: route['route_name']);
    return Scaffold(
        appBar: AdminAppBar(
          title: 'Add Route',
        ),
        floatingActionButton: fab(provider),
        body: Container(
            height: Get.height,
            padding: EdgeInsets.all(20),
            child: Form(
                key: routeEditKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      TextFieldLabel(label: 'Route Name *'),
                      RouteNameTextField(),
                      Gap(30),
                      TextFieldLabel(label: 'Route Location *'),
                      RouteLocationTextField(),
                    ])))));
  }

  FloatingActionButton fab(RouteViewModel provider) {
    return FloatingActionButton(
      onPressed: () async {
        if (routeEditKey.currentState!.validate()) {
          await provider.editRoute(route);
          Get.back();
        } else {
          showSnackbar('Please fill all the fields',
              'All Fields must be filled to procced');
        }
      },
      child: Icon(
        Icons.done,
        color: Colors.white,
      ),
    );
  }
}
