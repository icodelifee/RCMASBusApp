import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';

class ViewBus extends HookWidget {
  ViewBus({required this.bus});
  final Bus bus;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busViewProvider);
    final driverFuture = useFuture(
        useMemoized(() => provider.getDriver(bus.driverId!)),
        initialData: null);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Gap(10),
            Text(
              'Bus Details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Divider(),
            TextFieldLabel(
              label: 'Bus Number',
            ),
            Text(
              bus.busNo!,
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            TextFieldLabel(
              label: 'License Number',
            ),
            Text(
              bus.busLicenseNo!,
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            TextFieldLabel(
              label: 'Insurance Expiry Date',
            ),
            Text(
              bus.insurance!.getDate(),
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            TextFieldLabel(
              label: 'Permit Expiry Date',
            ),
            Text(
              bus.permit!.getDate(),
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            TextFieldLabel(
              label: 'Fitness Expiry Date',
            ),
            Text(
              bus.fitness!.getDate(),
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            TextFieldLabel(
              label: 'Pollution Expiry Date',
            ),
            Text(
              bus.pollution!.getDate(),
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            TextFieldLabel(
              label: 'Tax Expiry Date',
            ),
            Text(
              bus.tax!.getDate(),
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            Text(
              'Driver Details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ...(driverFuture.hasData ? _getDriverData(driverFuture.data!) : []),
          ],
        ),
      ),
    );
  }

  List<Widget> _getDriverData(Driver driver) {
    return [
      Gap(10),
      TextFieldLabel(
        label: 'First Name',
      ),
      Text(
        driver.firstName!,
        style: TextStyle(fontSize: 20),
      ),
      Gap(20),
      TextFieldLabel(
        label: 'Last Name',
      ),
      Text(
        driver.lastName!,
        style: TextStyle(fontSize: 20),
      ),
      Gap(20),
      TextFieldLabel(
        label: 'Phone',
      ),
      Text(
        driver.phone!,
        style: TextStyle(fontSize: 20),
      )
    ];
  }
}
