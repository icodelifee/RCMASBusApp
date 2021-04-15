import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';

class LicenseNumberTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busViewProvider);
    provider.licenseNumber = useTextEditingController(
        text: provider.bus != null ? provider.bus!.busLicenseNo : null);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter license number';
        }
        return null;
      },
      controller: provider.licenseNumber,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'License number'),
    );
  }
}
