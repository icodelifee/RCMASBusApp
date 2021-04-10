import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/route/route_viewmodel.dart';

class RouteLocationTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(routeProvider);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter route location';
        }
        return null;
      },
      controller: provider.routeLoc,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Route location'),
    );
  }
}
