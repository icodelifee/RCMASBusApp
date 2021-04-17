import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/data_text.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/header_text.dart';
import 'package:rcmasbusapp/ui/admin/renewals/renewals_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/ui/admin/renewals/view_renewal.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';

class RenewalsCard extends StatelessWidget {
  const RenewalsCard({
    Key? key,
    required this.renewals,
    required this.approval,
  }) : super(key: key);

  final Renewal renewals;
  final bool approval;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: roundedRectangleBorder,
        elevation: 2,
        child: InkWell(
          borderRadius: circularBorder,
          onTap: () => Get.to(() => ViewRenewal(
                renewal: renewals,
              )),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(text: 'Renewal ID'),
                DataText(text: renewals.renewalId!),
                Gap(13),
                HeaderText(text: 'Payment ID'),
                DataText(text: renewals.paymentId!),
                Gap(13),
                HeaderText(text: 'Roll Number'),
                DataText(text: renewals.rollNo!),
                Gap(13),
                HeaderText(text: 'Renewal Date'),
                DataText(text: renewals.renewalDate!.toDate().getDate()),
                Gap(20),
                !approval ? approveButton(context) : SizedBox()
              ],
            ),
          ),
        ));
  }

  TextButton approveButton(BuildContext context) {
    return TextButton(
        onPressed: () async {
          final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year),
              lastDate: DateTime(DateTime.now().year + 5),
              confirmText: 'APPROVE');
          if (date != null) {
            await context
                .read(renewalViewProvider)
                .approveRenewal(date, renewals);
            await context.refresh(renewalsProvider);
          }
        },
        style: buttonStyle,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Text(
              'APPROVE',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ));
  }
}
