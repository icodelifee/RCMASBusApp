import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';

class PhoneNumberField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(loginViewModelProvider);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        controller: provider.phone,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            fillColor: AppColors.textInputFillColor,
            hintText: 'Enter your phone number',
            hintStyle: TextStyle(fontWeight: FontWeight.w700),
            prefix: Padding(
              padding: const EdgeInsets.only(left: 4, right: 6),
              child: Text(
                '+91',
                style: TextStyle(color: Colors.black),
              ),
            ),
            focusedBorder: border,
            border: border,
            enabledBorder: border,
            filled: true),
      ),
    );
  }
}
