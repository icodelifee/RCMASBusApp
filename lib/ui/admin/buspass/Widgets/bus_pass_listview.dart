import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/data_text.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/header_text.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class BusPassListView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busPassViewProvider);
    final busPassesFuture = useFuture(
        useMemoized(() => provider.getAllBusPass()),
        initialData: null);

    if (busPassesFuture.hasData) {
      final buspasses = busPassesFuture.data!;
      return ListView.builder(
        itemCount: buspasses.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            actionPane: SlidableBehindActionPane(),
            actionExtentRatio: 0.25,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Approve',
                foregroundColor: Colors.black,
                color: Colors.transparent,
                iconWidget: Icon(Icons.approval),
                onTap: () {
                  Get.bottomSheet(Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                      ],
                    ),
                  ));
                },
              ),
            ],
            child: Card(
                elevation: 3,
                shape: roundedRectangleBorder,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText(
                        text: 'Bus Pass Id',
                      ),
                      DataText(text: buspasses[index].passId!),
                      Gap(8),
                      HeaderText(
                        text: 'Roll Number',
                      ),
                      DataText(text: buspasses[index].rollNo!),
                      Gap(8),
                      HeaderText(
                        text: 'Pass Creation Date',
                      ),
                      DataText(text: getTime(buspasses[index].timestamp!)),
                      Gap(8),
                      HeaderText(text: 'Pass Status'),
                      DataText(
                        text: buspasses[index].isApproved!
                            ? 'Approved'
                            : 'Not Approved',
                      ),
                      Gap(8),
                      HeaderText(text: 'Pass Payment Status'),
                      DataText(
                          text: buspasses[index].isPaymentComplete!
                              ? 'Payed'
                              : 'Not Payed')
                    ],
                  ),
                )),
          );
        },
      );
    } else {
      return CustomIndicator();
    }
  }

  String getTime(Timestamp ts) {
    return DateFormat.yMd().add_jm().format(ts.toDate());
  }
}
