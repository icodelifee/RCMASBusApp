import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RouteSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(registrationPageViewModelProvider);
    final routes = useProvider(routesProvider);
    return routes.when(
        data: (data) => dropDown(data, provider),
        loading: () => CustomIndicator(),
        error: (error, stack) => Center(child: Text('Some Error Occured')));
  }

  DropdownButtonFormField<String> dropDown(
      data, RegistrationPageViewModel provider) {
    return DropdownButtonFormField(
      validator: (value) {
        if (value == null) {
          return 'Please select a route';
        }
        return null;
      },
      hint: Text('Select route'),
      items: data
          .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                value: e['doc'],
                child: Text(e['route_name']),
              ))
          .toList(),
      onChanged: (String? val) {
        provider.routeDocId = val;
        provider.stopDocId = null;
      },
      decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          fillColor: AppColors.textInputFillColor,
          filled: true),
    );
  }
}
