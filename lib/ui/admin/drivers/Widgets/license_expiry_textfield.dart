import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/drivers/drivers_viewmodel.dart';

class LicenseExpiryTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(driversViewProvider);
    return TextFormField(
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a expiry date';
        }
        return null;
      },
      onTap: () async {
        final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(DateTime.now().year + 20));
        if (date != null) {
          provider.licenseExpiryDate = date;
          provider.expiryDate!.text =
              DateFormat('d/M/y').format(date).toString();
        }
      },
      controller: provider.expiryDate,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'License Expiry Date'),
    );
  }
}
