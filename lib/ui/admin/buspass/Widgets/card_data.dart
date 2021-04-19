import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/data_text.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/header_text.dart';
import 'package:rcmasbusapp/ui/admin/buspass/view_buspass.dart';

class CardData extends StatelessWidget {
  const CardData({
    Key? key,
    required this.buspass,
  }) : super(key: key);

  final BusPass buspass;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ViewBusPass(pass: buspass)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(
              text: 'Bus Pass Id',
            ),
            DataText(text: buspass.passId!),
            Gap(8),
            HeaderText(
              text: 'Roll Number',
            ),
            DataText(text: buspass.rollNo!),
            Gap(8),
            HeaderText(
              text: 'Pass Creation Date',
            ),
            DataText(text: getTime(buspass.timestamp!)),
            Gap(8),
            HeaderText(text: 'Pass Status'),
            DataText(
              text: buspass.isApproved! ? 'Approved' : 'Not Approved',
            ),
            Gap(8),
            HeaderText(text: 'Pass Payment Status'),
            DataText(text: buspass.isPaymentComplete! ? 'Payed' : 'Not Payed')
          ],
        ),
      ),
    );
  }

  String getTime(Timestamp ts) {
    return DateFormat.yMd().add_jm().format(ts.toDate());
  }
}
