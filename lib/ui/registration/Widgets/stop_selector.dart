import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StopSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(registrationPageViewModelProvider);
    return Visibility(
        visible: !(provider.routeDocId == null),
        child: FutureBuilder(
          future: provider.getStops(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomIndicator();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldLabel(label: '*Bus Stop'),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a stop';
                      }
                      return null;
                    },
                    hint: Text('Select stop'),
                    items: items(snapshot),
                    onChanged: (String? val) {
                      provider.stopDocId = val;
                    },
                    value: provider.stopDocId,
                    decoration: InputDecoration(
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border,
                        fillColor: AppColors.textInputFillColor,
                        filled: true),
                  ),
                ],
              );
            }
          },
        ));
  }

  List<DropdownMenuItem<String>> items(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.data
        .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
              value: e['doc'],
              child: Text(e['stop_name']),
            ))
        .toList();
  }
}
