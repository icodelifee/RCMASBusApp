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
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class ChangeRoutePage extends HookWidget {
  const ChangeRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeChange = useProvider(studentRouteChangeProvider);
    return Scaffold(
      appBar: UAppBar(
        title: 'Change Route',
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: routeChange.when(
              data: (data) {
                if (data.changeRouteId == null) {
                  return ChangeRouteForm();
                } else {
                  if (data.status != 'PENDING') {
                    return ChangeRouteForm();
                  } else {
                    if (!data.isApproved!) {
                      return Center(
                        child: Text(
                          'You request for route change is under review.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      );
                    } else {
                      return PayCodeForm(
                          fee: data.extraPaymentFee.toString(),
                          docId: data.docId!);
                    }
                  }
                }
              },
              loading: () => CustomIndicator(),
              error: (error, stack) => SizedBox())),
    );
  }
}

class PayCodeForm extends HookWidget {
  const PayCodeForm({Key? key, required this.fee, required this.docId})
      : super(key: key);
  final String fee;
  final String docId;
  @override
  Widget build(BuildContext context) {
    final ctrl = useTextEditingController();
    final provider = useProvider(changeRouteProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldLabel(label: 'Pay Code'),
        Gap(20),
        TextFormField(
          controller: ctrl,
          decoration: inputDecoration('Pay Code'),
        ),
        Gap(15),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Extra Payment Fee',
            style: TextStyle(fontSize: 19),
          ),
          trailing: Text(
            'Rs $fee',
            style: TextStyle(fontSize: 19),
          ),
        ),
        Spacer(),
        ElevatedButton(
            onPressed: () async {
              if (ctrl.text != '') {
                await provider.submitPaycode(ctrl.text, docId);
                await context.refresh(studentRouteChangeProvider);
                showSnackbar('Payment Code Submitted',
                    'Your buspass has been approved!');
              } else {
                showSnackbar('Please enter paycode',
                    'Correct paycode must be entered to submit');
              }
            },
            style: buttonStyle,
            child: SizedBox(
              height: 60,
              width: Get.width,
              child: Center(
                child: Text(
                  'SUBMIT',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ))
      ],
    );
  }
}

class ChangeRouteForm extends HookWidget {
  const ChangeRouteForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(changeRouteProvider);
    return Form(
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
              onPressed: () async {
                if (provider.key.currentState!.validate()) {
                  await provider.changeRoute();
                  await context.refresh(studentRouteChangeProvider);
                } else {
                  showSnackbar('Please select all fields',
                      'Both route and stop must be selected');
                }
              },
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
    );
  }
}
