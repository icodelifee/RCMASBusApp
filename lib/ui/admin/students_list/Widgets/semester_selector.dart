import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';

class StudentSemesterSelector extends HookWidget {
  final List<String> semesters = ['I', 'II', 'III', 'IV', 'V', 'VI'];
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
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
      value: provider.semester,
      decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          fillColor: AppColors.textInputFillColor,
          filled: true),
    );
  }
}
