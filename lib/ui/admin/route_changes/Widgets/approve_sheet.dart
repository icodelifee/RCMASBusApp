import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/change_route.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/route_changes/route_changes_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RouteChangeApproveSheet extends HookWidget {
  RouteChangeApproveSheet({required this.changeRoute});
  final ChangeRoute changeRoute;
  @override
  Widget build(BuildContext context) {
    final busFuture = useProvider(busFutureProvider);
    final rDate = useState(DateTime.now());
    final bus = useState(Bus());
    final fee = useTextEditingController();
    final ctrl = useTextEditingController();
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFieldLabel(label: 'Renewal Date'),
          TextField(
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2017),
                  lastDate: DateTime(DateTime.now().year + 6));
              if (date != null) {
                rDate.value = date;
                ctrl.text = DateFormat().add_yMd().format(date).toString();
              }
            },
            controller: ctrl,
            decoration: inputDecoration('Pick Renewal Date'),
          ),
          Gap(15),
          TextField(
            keyboardType: TextInputType.number,
            controller: fee,
            decoration: inputDecoration('Extra Fee'),
          ),
          Gap(15),
          busFuture.when(
              data: (List<Bus> buses) {
                return DropdownButtonFormField<Bus>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a bus';
                    }
                    return null;
                  },
                  hint: Text('Select bus'),
                  items: buses
                      .map((Bus bus) => DropdownMenuItem<Bus>(
                            value: bus,
                            child: Text(bus.busNo!),
                          ))
                      .toList(),
                  onChanged: (Bus? val) {
                    bus.value = val!;
                  },
                  decoration: InputDecoration(
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      fillColor: AppColors.textInputFillColor,
                      filled: true),
                );
              },
              loading: () => CustomIndicator(),
              error: (err, stack) => SizedBox()),
          Gap(15),
          bus.value.busId != null ? steatsText(bus) : SizedBox(),
          Gap(15),
          TextButton(
            onPressed: () =>
                approveButton(bus.value, context, fee.text, rDate.value),
            style: buttonStyle.copyWith(
                padding: MaterialStateProperty.all(EdgeInsets.all(10))),
            child: Center(
                child: Text(
              'APPROVE',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
          )
        ],
      ),
    );
  }

  Row steatsText(ValueNotifier<Bus> bus) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Seats',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Text(
            bus.value.totalSeats!.toString(),
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alloted Seats',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Text(
            bus.value.allottedSeats!.toString(),
            style: TextStyle(fontSize: 17),
          )
        ],
      )
    ]);
  }

  void approveButton(
      Bus bus, BuildContext context, String fee, DateTime date) async {
    if (bus.allottedSeats! >= bus.totalSeats!) {
      showSnackbar('Total Allotted Seats Limit Exceeded!',
          'You cannot add more students because allotted seats limit reached');
      return;
    }
    final data = {
      'docId': changeRoute.docId,
      'renewal_date': date,
      'roll_no': changeRoute.rollNumber,
      'route_id': changeRoute.routeId,
      'stop_id': changeRoute.stopId,
      'bus_id': bus.busId,
      'bus_docId': bus.docId,
      'extra_payment_fee': int.parse(fee == '' ? '0' : fee)
    };
    await context.read(fireStoreRepositoryProvider).approveBusRouteChange(data);
    await context.refresh(routeChangeListProvider);
    Get.back();
  }
}
