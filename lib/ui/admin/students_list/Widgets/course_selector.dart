import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';

class StudentCourseSelector extends HookWidget {
  final List<String> courses = [
    'BCA',
    'BCOM Model I Computer Application',
    'BCOM Model I Finance and Taxation',
    'BCOM Model II Computer Application',
    'BCOM Model II Finance and Taxation',
    'BCOM Model II Marketing',
    'BCOM Model II Logistics Management',
    'BA Animation',
    'MA Graphics Design',
    'BBA',
    'MCom Finance and Application',
    'BA English'
  ];
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    return DropdownButtonFormField(
      validator: (value) {
        if (value == null) {
          return 'Please select a course';
        }
        return null;
      },
      hint: Text('Select course'),
      items: courses
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (String? val) {
        provider.course = val;
      },
      value: provider.course,
      decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          fillColor: AppColors.textInputFillColor,
          filled: true),
    );
  }
}
