import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../change_route_viewmodel.dart';

class NewStopSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(changeRouteProvider);
    if (provider.newRoute?.docId != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldLabel(label: 'Select New Stop'),
          Gap(10),
          DropdownButtonFormField<Stop>(
            validator: (value) {
              if (value == null) {
                return 'Please select a stop';
              }
              return null;
            },
            hint: Text('Select stop'),
            items: items(provider.newRoute!.stops!),
            onChanged: (Stop? val) {
              provider.newStop = val;
            },
            value: provider.newStop?.stopId != null ? provider.newStop : null,
            decoration: InputDecoration(
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                fillColor: AppColors.textInputFillColor,
                filled: true),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  List<DropdownMenuItem<Stop>> items(List<Stop> snapshot) {
    return snapshot
        .map<DropdownMenuItem<Stop>>((e) => DropdownMenuItem<Stop>(
              value: e,
              child: Text(e.stopName!),
            ))
        .toList();
  }
}
