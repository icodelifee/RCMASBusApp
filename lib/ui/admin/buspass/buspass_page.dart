import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class BusPassPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busPassViewProvider);
    final busPassesFuture = useFuture(
        useMemoized(() => provider.getAllBusPass()),
        initialData: null);
    return Scaffold(
        appBar: AdminAppBar(
          title: 'Bus Passes ',
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: busPassesFuture.hasData
              ? ListView.builder(
                  itemCount: busPassesFuture.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bus Pass Id',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            busPassesFuture.data![index].passId!,
                            style: TextStyle(
                                color: Color(0xFF787878), fontSize: 13),
                          ),
                          Gap(8),
                          Text(
                            'Roll Number',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            busPassesFuture.data![index].rollNo!,
                            style: TextStyle(
                                color: Color(0xFF787878), fontSize: 13),
                          ),
                          Gap(8),
                          Text(
                            'Pass Creation Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat.yMd().add_jm().format(busPassesFuture
                                .data![index].timestamp!
                                .toDate()),
                            style: TextStyle(
                                color: Color(0xFF787878), fontSize: 13),
                          ),
                          Gap(8),
                          Text(
                            'Pass Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            busPassesFuture.data![index].isApproved!
                                ? 'Approved'
                                : 'Not Approved',
                            style: TextStyle(
                                color: Color(0xFF787878), fontSize: 13),
                          ),
                          Gap(8),
                          Text(
                            'Pass Payment Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            busPassesFuture.data![index].isPaymentComplete!
                                ? 'Payed'
                                : 'Not Payed',
                            style: TextStyle(
                                color: Color(0xFF787878), fontSize: 13),
                          ),
                        ],
                      ),
                    ));
                  },
                )
              : CustomIndicator(),
        ));
  }
}
