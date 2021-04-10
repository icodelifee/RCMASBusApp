import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';

class PaymentCodeField extends HookWidget {
  const PaymentCodeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(registrationPageViewModelProvider);
    provider.paycode = useTextEditingController();
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ther payment code';
        }
        return null;
      },
      controller: provider.paycode,
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
