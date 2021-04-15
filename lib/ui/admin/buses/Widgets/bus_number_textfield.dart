import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';

class BusNumberTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busViewProvider);
    provider.busNumber = useTextEditingController(
        text: provider.bus != null ? provider.bus!.busNo : null);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter bus number';
        }
        return null;
      },
      controller: provider.busNumber,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Bus number'),
    );
  }
}
