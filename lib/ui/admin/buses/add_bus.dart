import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/bus_number_textfield.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/driver_selector.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/fitness_textfield.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/insurance_textfield.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/license_number_textfield.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/permit_textfield.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/pollution_textfield.dart';
import 'package:rcmasbusapp/ui/admin/buses/Widgets/tax_textfield.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class AddBus extends HookWidget {
  AddBus({required this.edit, this.bus});
  final Bus? bus;
  final bool edit;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busViewProvider);
    provider.bus = bus;
    return Scaffold(
      appBar: AdminAppBar(
        title: edit ? 'Edit Bus' : 'Add Bus',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (provider.formKey.currentState!.validate()) {
            if (edit) {
              await provider.editBus();
            } else {
              await provider.addBus();
            }
            await context.refresh(busesProvider);
            Get.back();
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
          padding: EdgeInsets.all(20),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldLabel(label: 'Bus number *'),
                Gap(7),
                BusNumberTextField(),
                Gap(20),
                TextFieldLabel(label: 'License number *'),
                Gap(7),
                LicenseNumberTextField(),
                Gap(20),
                TextFieldLabel(label: 'Driver *'),
                Gap(7),
                DriverSelector(),
                Gap(20),
                TextFieldLabel(label: 'Insurance Expiry Date *'),
                Gap(7),
                InsuranceTextField(),
                Gap(20),
                TextFieldLabel(label: 'Pollution Expiry Date *'),
                Gap(7),
                PollutionTextField(),
                Gap(20),
                TextFieldLabel(label: 'Fitness Expiry Date *'),
                Gap(7),
                FitnessTextField(),
                Gap(20),
                TextFieldLabel(label: 'Tax Expiry Date *'),
                Gap(7),
                TaxTextField(),
                Gap(20),
                TextFieldLabel(label: 'Permit Expiry Date *'),
                Gap(7),
                PermitTextField(),
                Gap(20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
