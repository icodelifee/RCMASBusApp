import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/change_route/change_route_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/route.dart' as r;

class NewRouteSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final routes = useProvider(newRoutesProvider);
    final provider = useProvider(changeRouteProvider);

    return routes.when(
        data: (data) {
          return DropdownButtonFormField<r.Route>(
            validator: (value) {
              if (value == null) {
                return 'Please select a route';
              }
              return null;
            },
            hint: Text('Select route'),
            decoration: InputDecoration(
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                fillColor: AppColors.textInputFillColor,
                filled: true),
            onChanged: (r.Route? route) {
              provider.newRoute = null;
              provider.newStop = null;
              provider.newRoute = route;
            },
            items: data
                .map<DropdownMenuItem<r.Route>>(
                    (e) => DropdownMenuItem<r.Route>(
                          value: (e),
                          child: Text(e.routeName!),
                        ))
                .toList(),
          );
        },
        loading: () => CustomIndicator(),
        error: (error, stack) => Center(child: Text('Some Error Occured')));
  }
}
