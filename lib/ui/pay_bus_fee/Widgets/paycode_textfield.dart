import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/pay_bus_fee/pay_bus_fee_viewmodel.dart';

import '../../../app_theme.dart';

class PayCodeTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(payBusFeeProvider);
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ther payment code';
        }
        return null;
      },
      controller: provider.payCode,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Enter payment code'),
    );
  }
}
