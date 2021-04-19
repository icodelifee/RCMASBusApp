import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/payment.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/students_list/view_student.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';

class ViewBusPass extends HookWidget {
  const ViewBusPass({Key? key, required this.pass}) : super(key: key);
  final BusPass pass;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(routeProvider(pass.routeId!));
    final studentp = useProvider(studentProvider(pass.rollNo!));
    final AsyncValue<Payment> paymentp;
    if (pass.paymentId != null) {
      paymentp = useProvider(paymentProvider(pass.paymentId!));
    } else {
      paymentp = AsyncValue.error('error');
    }
    return Scaffold(
        appBar: AdminAppBar(title: 'Bus Pass Details'),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              ...heading('ID'),
              ...data(pass.passId!),
              ...heading('Created At'),
              ...data(pass.timestamp!.toDate().getDate()),
              ...heading('Pass Status'),
              ...data(pass.isApproved! ? 'Approved' : 'Not Approved'),
              ...heading('Payment Status'),
              ...data(pass.isPaymentComplete! ? 'Payed' : 'Not Payed'),
              ...heading('Renewal Date'),
              ...data(pass.renewalDate!.toDate().getDate()),
              Gap(20),
              ...heading('Payment Details'),
              Divider(
                thickness: 1,
              ),
              ...paymentp.when(
                  data: (Payment payment) {
                    return [
                      ...heading('ID'),
                      ...data(payment.paymentId!),
                      ...heading('Payment Code'),
                      ...data(payment.paymentCode!),
                      ...heading('Date'),
                      ...data(payment.paymentDate!.toDate().getDate()),
                    ];
                  },
                  loading: () => [SizedBox()],
                  error: (error, stack) => [SizedBox()]),
              Gap(20),
              ...heading('Route & Stop Details'),
              Divider(
                thickness: 1,
              ),
              ...provider.when(
                  data: (route) {
                    final stop = route.stops!
                        .firstWhere((element) => element.stopId == pass.stopId);
                    return [
                      ...heading('ID'),
                      ...data(route.routeId!),
                      ...heading('Route Name'),
                      ...data(route.routeName!),
                      ...heading('Route Location'),
                      ...data(route.routeLocation!),
                      ...heading('Route Fee'),
                      ...data(route.routeFee!),
                      ...heading('Stop Name'),
                      ...data(stop.stopName!),
                      ...heading('Stop Location'),
                      ...data(stop.stopLocation!),
                    ];
                  },
                  loading: () => [SizedBox()],
                  error: (error, stack) => [SizedBox()]),
              Gap(20),
              ...heading('Student Details'),
              Divider(
                thickness: 1,
              ),
              ...studentp.when(
                  data: (student) {
                    return [
                      ...heading('First Name'),
                      ...data(student.firstName!),
                      ...heading('Last Name'),
                      ...data(student.lastName!),
                      ...heading('Roll Number'),
                      ...data(student.rollNumber!),
                      ...heading('Phone'),
                      ...data(student.phone!),
                      TextButton(
                          style: buttonStyle,
                          onPressed: () =>
                              Get.to(() => ViewStudent(student: student)),
                          child: Text(
                            'View More Details',
                            style: TextStyle(color: Colors.white),
                          ))
                    ];
                  },
                  loading: () => [SizedBox()],
                  error: (error, stack) => [SizedBox()]),
            ],
          ),
        ));
  }

  List<Widget> heading(String text) => [
        Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Gap(10)
      ];
  List<Widget> data(String text) => [
        Text(
          text,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        Gap(13)
      ];
}
