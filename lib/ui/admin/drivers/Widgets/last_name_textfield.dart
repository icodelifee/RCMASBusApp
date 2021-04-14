import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/drivers/drivers_viewmodel.dart';

class LastNameTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(driversViewProvider);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter last name';
        }
        return null;
      },
      controller: provider.lastName,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Last name'),
    );
  }
}
