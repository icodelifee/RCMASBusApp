import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/change_route/Widgets/new_route_selector.dart';
import 'package:rcmasbusapp/ui/change_route/Widgets/new_stop_selector.dart';
import 'package:rcmasbusapp/ui/change_route/change_route_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/app_bar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class ChangeRoutePage extends HookWidget {
  const ChangeRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(changeRouteProvider);
    return Scaffold(
      appBar: UAppBar(
        title: 'Change Route',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: provider.key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldLabel(label: 'Select New Route'),
              Gap(10),
              NewRouteSelector(),
              Gap(30),
              NewStopSelector(),
              Spacer(),
              ElevatedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: SizedBox(
                    height: 60,
                    width: Get.width,
                    child: Center(
                      child: Text(
                        'CHANGE ROUTE',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
