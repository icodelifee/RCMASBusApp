import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StopSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(registrationPageViewModelProvider);
    final future =
        useMemoized(() => provider.getStops(), [provider.routeDocId]);
    final snapshot = useFuture(future, initialData: null);
    if (provider.routeDocId != null) {
      return (snapshot.hasData
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldLabel(label: '*Bus Stop'),
                DropdownButtonFormField<Stop>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a stop';
                    }
                    return null;
                  },
                  hint: Text('Select stop'),
                  items: snapshot.data == null ? [] : items(snapshot.data!),
                  onChanged: (Stop? val) {
                    provider.stopDocId = val!.docId;
                    provider.stopMap = val;
                  },
                  value: provider.stopMap?.stopId != null
                      ? provider.stopMap
                      : null,
                  decoration: InputDecoration(
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      fillColor: AppColors.textInputFillColor,
                      filled: true),
                ),
              ],
            )
          : CustomIndicator());
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
