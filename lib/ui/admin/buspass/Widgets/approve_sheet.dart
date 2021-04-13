import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApproveSheet extends HookWidget {
  ApproveSheet({required this.docId});
  final String docId;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busPassViewProvider);
    final busFuture = useProvider(busFutureProvider);
    final rDate = useState(DateTime.now());
    final bus = useState(Bus());
    final ctrl = useTextEditingController();
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            decoration: InputDecoration(
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                disabledBorder: border,
                filled: true,
                fillColor: AppColors.textInputFillColor,
                hintText: 'Pick Renewal Date'),
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
          TextButton(
            onPressed: () async {
              await provider.approveBusPass(bus.value, rDate.value, docId);
              Get.back();
            },
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
}
