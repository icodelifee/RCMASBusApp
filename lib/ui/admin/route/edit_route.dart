import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/route/Widgets/route_fee_textfield.dart';
import 'package:rcmasbusapp/ui/admin/route/Widgets/route_location_textfield.dart';
import 'package:rcmasbusapp/ui/admin/route/Widgets/route_name_textfield.dart';
import 'package:rcmasbusapp/ui/admin/route/route_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';

class EditRoute extends HookWidget {
  EditRoute({required this.route});
  final routeEditKey = GlobalKey<FormState>();
  final Map<String, dynamic> route;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(routeProvider);
    provider.routeLoc = useTextEditingController(text: route['route_location']);
    provider.routeName = useTextEditingController(text: route['route_name']);
    provider.routeFee = useTextEditingController(text: route['route_fee']);
    return Scaffold(
        appBar: AdminAppBar(
          title: 'Edit Route',
        ),
        floatingActionButton: fab(provider, context),
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
                      Gap(30),
                      TextFieldLabel(label: 'Route Fee *'),
                      RouteFeeTextField()
                    ])))));
  }

  FloatingActionButton fab(RouteViewModel provider, BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (routeEditKey.currentState!.validate()) {
          await provider.editRoute(route);
          Get.back();
          await context.refresh(routesProvider);
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
