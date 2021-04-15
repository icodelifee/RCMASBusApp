import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/drivers/drivers_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class DriverSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(driversProvider);
    final busesProvider = useProvider(busViewProvider);
    return provider.when(
        data: (List<Driver> drivers) {
          if (busesProvider.bus != null) {
            busesProvider.driver = drivers.firstWhere(
                (element) => element.driverId == busesProvider.bus!.driverId);
          }
          return DropdownButtonFormField(
            validator: (value) {
              if (value == null) {
                return 'Please select a driver';
              }
              return null;
            },
            hint: Text('Select driver'),
            items: drivers
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text('${e.firstName!} ${e.lastName!}'),
                    ))
                .toList(),
            onChanged: (Driver? val) {
              busesProvider.driver = val;
            },
            value: busesProvider.driver,
            decoration: InputDecoration(
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                fillColor: AppColors.textInputFillColor,
                filled: true),
          );
        },
        loading: () => CustomIndicator(),
        error: (err, stack) {
          return Text('Some Error Occured');
        });
  }
}
