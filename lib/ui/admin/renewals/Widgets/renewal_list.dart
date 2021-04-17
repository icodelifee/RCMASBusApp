import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/data_text.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/header_text.dart';
import 'package:rcmasbusapp/ui/admin/renewals/renewals_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/renewals/view_renewal.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';

class RenewalsList extends StatelessWidget {
  RenewalsList({
    Key? key,
    required this.renewals,
    required this.approval,
  }) : super(key: key);
  final List<Renewal> renewals;
  final bool approval;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: renewals.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            shape: roundedRectangleBorder,
            elevation: 2,
            child: InkWell(
              borderRadius: circularBorder,
              onTap: () => Get.to(() => ViewRenewal(
                    renewal: renewals[index],
                  )),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText(text: 'Renewal ID'),
                    DataText(text: renewals[index].renewalId!),
                    Gap(13),
                    HeaderText(text: 'Payment ID'),
                    DataText(text: renewals[index].paymentId!),
                    Gap(13),
                    HeaderText(text: 'Roll Number'),
                    DataText(text: renewals[index].rollNo!),
                    Gap(13),
                    HeaderText(text: 'Renewal Date'),
                    DataText(
                        text: renewals[index].renewalDate!.toDate().getDate()),
                    Gap(20),
                    !approval
                        ? TextButton(
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
                                    .approveRenewal(date, renewals[index]);
                                await context.refresh(renewalsProvider);
                              }
                            },
                            style: buttonStyle,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  'APPROVE',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ))
                        : SizedBox()
                  ],
                ),
              ),
            ));
      },
    );
  }
}
