import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/change_route.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/students_list/view_student.dart';
import 'package:rcmasbusapp/utils/to_bold.dart';

class ViewRouteChange extends HookWidget {
  const ViewRouteChange({Key? key, required this.changeRoute})
      : super(key: key);
  final ChangeRoute changeRoute;
  @override
  Widget build(BuildContext context) {
    final studentprovider =
        useProvider(studentProvider(changeRoute.rollNumber!));
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Route Change Details',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            headingText('Request Details'),
            Divider(
              thickness: 1,
            ),
            'Approval Status'.toBold(),
            dataText(
              changeRoute.isApproved! ? 'Approved' : 'Not Approved',
            ),
            'Payment Status'.toBold(),
            dataText(
              changeRoute.paymentCompleted! ? 'Payed' : 'Not Payed',
            ),
            'Status'.toBold(),
            dataText(changeRoute.status!),
            'Extra Payment Fee'.toBold(),
            dataText(changeRoute.extraPaymentFee.toString()),
            Gap(20),
            headingText('Student Details'),
            Divider(
              thickness: 1,
            ),
            'Roll Number'.toBold(),
            dataText(changeRoute.rollNumber!),
            studentprovider.when(
                data: (data) => TextButton(
                      onPressed: () => Get.to(() => ViewStudent(student: data)),
                      style: buttonStyle,
                      child: Center(
                          heightFactor: 1.4,
                          child: Text(
                            'View More Strudent Details',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                loading: () => SizedBox(),
                error: (_, __) => SizedBox()),
          ]
              .map((e) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Text dataText(String text) => Text(
        text,
        style: TextStyle(fontSize: 21),
      );

  Text headingText(String text) => Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
}
