import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';

class SemesterSelector extends HookWidget {
  final List<String> semesters = ['I', 'II', 'III', 'IV', 'V', 'VI'];
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(registrationPageViewModelProvider);
    return DropdownButtonFormField(
      validator: (value) {
        if (value == null) {
          return 'Please select a semester';
        }
        return null;
      },
      hint: Text('Select semester'),
      items: semesters
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (String? val) {
        provider.semester = val;
      },
      decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          fillColor: AppColors.textInputFillColor,
          filled: true),
    );
  }
}
