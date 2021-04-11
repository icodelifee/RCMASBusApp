import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/stops/stops_viewmodel.dart';

class StopArrivalTimePicker extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(stopsProvider);
    return TextFormField(
      // enabled: false,
      onTap: () async {
        final t = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        final now = DateTime.now();

        // if the picker didnt select time handle null
        if (t?.hour != null && t?.minute != null) {
          final tm = DateTime(now.year, now.month, now.day, t!.hour, t.minute);
          provider.time = tm;
          provider.timeCtrl!.text = t.format(context);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please pick a arrival time';
        }
        return null;
      },
      readOnly: true,
      controller: provider.timeCtrl,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Pick Stop Arrival Time'),
    );
  }
}
