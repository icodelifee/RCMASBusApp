import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';

class EmailTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final email = useProvider(registrationPageViewModelProvider).email;
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email';
        } else if (GetUtils.isEmail(value)) {
          return 'Please enter valid email';
        }
        return null;
      },
      controller: email,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Email'),
    );
  }
}
