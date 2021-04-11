import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/stops/stops_viewmodel.dart';

class StopLocationTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(stopsProvider);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter stop location';
        }
        return null;
      },
      controller: provider.stopLoc,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Stop location'),
    );
  }
}
