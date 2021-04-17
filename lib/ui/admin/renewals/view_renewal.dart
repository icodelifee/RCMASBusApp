import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';

class ViewRenewal extends HookWidget {
  const ViewRenewal({Key? key, required this.renewal}) : super(key: key);
  final Renewal renewal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Renewal Details',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...headingText('Renewal ID'),
            ...dataText(renewal.renewalId!),
            ...headingText('Renewal Date'),
            ...dataText(renewal.renewalDate!.toDate().getDate()),
            ...headingText('Renewal Status'),
            ...dataText(renewal.isApproved! ? 'Approved' : 'Not Approved'),
            ...headingText('Current Renewal Date'),
            ...dataText(renewal.pass!.renewalDate!.toDate().getDate()),
            ...header('Payment Details'),
            ...headingText('Payment Id'),
            ...dataText(renewal.paymentId!),
            ...headingText('Payment Code'),
            ...dataText(renewal.payment!.paymentCode!),
            ...headingText('Payment Date'),
            ...dataText(renewal.payment!.paymentDate!.toDate().getDate()),
            ...header('Student Details'),
            ...headingText('Roll Number'),
            ...dataText(renewal.student!.rollNumber!),
            ...headingText('Full Name'),
            ...dataText(
                '${renewal.student!.firstName!} ${renewal.student!.lastName!}'),
            ...headingText('Phone Number'),
            ...dataText(renewal.student!.phone!)
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
          fontSize: 16,
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Gap(7)
    ];
  }
}
