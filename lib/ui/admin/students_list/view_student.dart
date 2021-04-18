import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';

class ViewStudent extends HookWidget {
  const ViewStudent({Key? key, required this.student}) : super(key: key);
  final Student student;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentBusPassProvider(student.busPass ?? ''));
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Student Details',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            ...headingText('First Name'),
            ...dataText(student.firstName!),
            ...headingText('Last Name'),
            ...dataText(student.lastName!),
            ...headingText('Roll Number'),
            ...dataText(student.rollNumber!),
            ...headingText('Email'),
            ...dataText(student.email!),
            ...headingText('Phone Number'),
            ...dataText(student.phone!),
            ...headingText('Course'),
            ...dataText(student.course!),
            ...headingText('Semester'),
            ...dataText(student.semester!),
            ...provider.when(
                data: (yb) {
                  if (yb?.busPass?.passId != null) {
                    return [
                      ...header('Bus Pass Details'),
                      ...headingText('Pass Status'),
                      ...dataText(yb!.busPass!.isApproved!
                          ? 'Approved'
                          : 'Not Approved'),
                      ...headingText('Payment Status'),
                      ...dataText(yb.busPass!.isPaymentComplete!
                          ? 'Payed'
                          : 'Not Payed'),
                      ...headingText('Renewal Date'),
                      ...dataText(yb.busPass?.renewalDate?.toDate().getDate() ??
                          'Not Assigned'),
                      ...headingText('Bus Number'),
                      ...dataText(yb.bus?.busNo ?? 'Not Assigned'),
                      ...headingText('Route Name'),
                      ...dataText(yb.route?.routeName ?? 'Not Assigned'),
                      ...headingText('Stop Name'),
                      ...dataText(yb.route?.stops!
                              .firstWhere((element) =>
                                  element.stopId == yb.busPass!.stopId)
                              .stopName ??
                          'Not Assigned'),
                    ];
                  } else {
                    return [SizedBox()];
                  }
                },
                loading: () => [SizedBox()],
                error: (err, stack) => [SizedBox()])
          ],
        ),
      ),
    );
  }

  List<Widget> dataText(String text) {
    return [
      Text(
        text,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Gap(20)
    ];
  }

  List<Widget> header(String text) {
    return [
      Gap(20),
      Text(
        text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Divider(
        thickness: 1,
      ),
      Gap(10)
    ];
  }

  List<Widget> headingText(String text) {
    return [
      Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Gap(7)
    ];
  }
}
