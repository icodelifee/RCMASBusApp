import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/data/provider/bus_payments_provider.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class YourPaymentsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(paymentsProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Bus Pass Payments',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: provider.when(
            data: (data) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      // decoration: cardShadow,
                      child: Card(
                        elevation: 0.2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: Get.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Id',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                data[index].paymentId!,
                                style: TextStyle(
                                    color: Color(0xFF787878), fontSize: 16),
                              ),
                              Gap(10),
                              Text(
                                'Bus Pass Id',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                data[index].passId!,
                                style: TextStyle(
                                    color: Color(0xFF787878), fontSize: 16),
                              ),
                              Gap(10),
                              Text(
                                'Payment Code',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                data[index].paymentCode!,
                                style: TextStyle(
                                    color: Color(0xFF787878), fontSize: 16),
                              ),
                              Gap(10),
                              Text(
                                'Payment Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                DateFormat.yMd()
                                    .add_jm()
                                    .format(data[index].paymentDate!.toDate()),
                                style: TextStyle(
                                    color: Color(0xFF787878), fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => CustomIndicator(),
            error: (err, stack) {
              showSnackbar(err.toString(), stack.toString());
              return SizedBox();
            }));
  }
}
