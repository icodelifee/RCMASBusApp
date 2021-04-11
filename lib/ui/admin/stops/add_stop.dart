import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/stops/Widgets/stop_location_textfield.dart';
import 'package:rcmasbusapp/ui/admin/stops/Widgets/stop_name_textfield.dart';
import 'package:rcmasbusapp/ui/admin/stops/Widgets/stop_time_picker.dart';
import 'package:rcmasbusapp/ui/admin/stops/stops_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class AddStop extends HookWidget {
  AddStop({required this.routeId});
  final stopAddKey = GlobalKey<FormState>();
  final String routeId;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(stopsProvider);
    provider.stopLoc = useTextEditingController();
    provider.stopName = useTextEditingController();
    provider.timeCtrl = useTextEditingController();
    return Scaffold(
        appBar: AdminAppBar(
          title: 'Add Stop',
        ),
        floatingActionButton: fab(provider, context),
        body: Container(
            height: Get.height,
            padding: EdgeInsets.all(20),
            child: Form(
                key: stopAddKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      TextFieldLabel(label: 'Stop Name *'),
                      StopNameTextField(),
                      Gap(30),
                      TextFieldLabel(label: 'Stop Location *'),
                      StopLocationTextField(),
                      Gap(30),
                      TextFieldLabel(label: 'Stop Arrival Time*'),
                      StopArrivalTimePicker()
                    ])))));
  }

  FloatingActionButton fab(StopsViewModel provider, BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        if (stopAddKey.currentState!.validate()) {
          await provider.addStop(routeId);
          Get.back();
          context.refresh(stopsProvider);
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
