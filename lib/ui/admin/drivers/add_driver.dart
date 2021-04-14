import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/drivers/Widgets/first_name_textfield.dart';
import 'package:rcmasbusapp/ui/admin/drivers/Widgets/last_name_textfield.dart';
import 'package:rcmasbusapp/ui/admin/drivers/Widgets/license_expiry_textfield.dart';
import 'package:rcmasbusapp/ui/admin/drivers/Widgets/license_textfield.dart';
import 'package:rcmasbusapp/ui/admin/drivers/Widgets/phone_textfield.dart';
import 'package:rcmasbusapp/ui/admin/drivers/drivers_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class AddDriver extends HookWidget {
  AddDriver({required this.edit, this.driver});
  final bool edit;
  final Driver? driver;
  final DateFormat d = DateFormat('d/M/y');
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(driversViewProvider);
    provider.firstName =
        useTextEditingController(text: edit ? driver!.firstName : null);
    provider.lastName =
        useTextEditingController(text: edit ? driver!.lastName : null);
    provider.licenseNumber =
        useTextEditingController(text: edit ? driver!.licenseNo : null);
    provider.phoneNumber =
        useTextEditingController(text: edit ? driver!.phone : null);
    provider.licenseExpiryDate = driver?.licenseExpiryDate!.toDate();
    provider.expiryDate = useTextEditingController(
        text: edit ? d.format(driver!.licenseExpiryDate!.toDate()) : null);

    return Scaffold(
      appBar: AdminAppBar(
        title: !edit ? 'Add Driver' : 'Edit Driver',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (provider.formKey.currentState!.validate()) {
            if (!edit) {
              await provider.addDriver();
            } else {
              await provider.editDriver(driver!);
            }
            Get.back();
            await context.refresh(driversProvider);
          } else {
            showSnackbar('Please fill all the fields',
                'All Fields must be filled to procced');
          }
        },
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.size.height,
          padding: EdgeInsets.all(14),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldLabel(label: 'First Name *'),
                FirstNameTextField(),
                Gap(20),
                TextFieldLabel(label: 'Last Name *'),
                LastNameTextField(),
                Gap(20),
                TextFieldLabel(label: 'Phone Number*'),
                PhoneTextField(),
                Gap(20),
                TextFieldLabel(label: 'License Number *'),
                LicenseTextField(),
                Gap(20),
                TextFieldLabel(label: 'License Expiry Date *'),
                LicenseExpiryTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
