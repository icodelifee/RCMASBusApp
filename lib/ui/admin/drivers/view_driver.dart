import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class ViewDriver extends StatelessWidget {
  ViewDriver({required this.driver});
  final Driver driver;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Driver Details',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            TextFieldLabel(label: 'Phone Number'),
            Text(
              driver.phone!,
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            TextFieldLabel(label: 'License Number'),
            Text(
              driver.licenseNo!,
              style: TextStyle(fontSize: 20),
            ),
            Gap(20),
            TextFieldLabel(label: 'License Expiry Date'),
            Text(
              DateFormat.yMd()
                  .format(driver.licenseExpiryDate!.toDate())
                  .toString(),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
