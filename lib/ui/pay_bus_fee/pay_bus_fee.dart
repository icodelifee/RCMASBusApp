import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/components/app_bar.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';
import 'package:rcmasbusapp/ui/pay_bus_fee/Widgets/paycode_textfield.dart';
import 'package:rcmasbusapp/ui/pay_bus_fee/Widgets/payment_btn.dart';
import 'package:rcmasbusapp/ui/pay_bus_fee/pay_bus_fee_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class PayBusFeePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final buspassProvider = useProvider(busPassProvider);
    final provider = useProvider(payBusFeeProvider);
    final renewal = useFuture(
        provider.getRenewal(buspassProvider.data!.value.passId!),
        initialData: null);
    provider.payCode = useTextEditingController();
    return Scaffold(
      appBar: UAppBar(
        title: 'Pay Bus Fee',
      ),
      body: renewal.hasData
          ? renewal.data?.docId != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Your bus pass renewal is under review, please contact the administator for any queries regarding this process.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(20),
                  child: buspassProvider.when(
                      data: (busPass) {
                        final today = DateTime.now();
                        final renewalDate = busPass.renewalDate!.toDate();
                        if (renewalDate.isBefore(today)) {
                          return Form(
                            key: provider.formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldLabel(label: 'Payment Code *'),
                                  PayCodeTextField(),
                                  Gap(10),
                                  Text(
                                      'Note: Please enter your payment code correctly'),
                                  Spacer(),
                                  PaymentButton(),
                                ]),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your bus pass renewal date',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                DateFormat('EEE, MMM d, ' 'yyyy')
                                    .format(renewalDate),
                                style: TextStyle(fontSize: 40),
                              ),
                              Gap(10),
                              Text(
                                renewalDate
                                        .difference(today)
                                        .inDays
                                        .toString() +
                                    ' days left for renewal',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          );
                        }
                      },
                      loading: () => CustomIndicator(),
                      error: (error, stack) {
                        return SizedBox();
                      }))
          : CustomIndicator(),
    );
  }
}
