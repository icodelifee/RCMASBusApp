import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/students_list/Widgets/course_selector.dart';
import 'package:rcmasbusapp/ui/admin/students_list/Widgets/semester_selector.dart';
import 'package:rcmasbusapp/ui/admin/students_list/Widgets/submit_edit_btn.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

import 'add_student.dart';

class EditStudent extends HookWidget {
  EditStudent({required this.student});
  final Student student;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    final key = provider.editStudentKey;
    Future.delayed(const Duration(seconds: 1), () {
      provider.firstName!.text = student.firstName!;
      provider.lastName!.text = student.lastName!;
      provider.phone!.text = student.phone!.replaceRange(0, 2, '');
      provider.rollNo!.text = student.rollNumber!;
      provider.email!.text = student.email!;
      provider.course = student.course;
      provider.semester = student.semester;
    });
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Edit Student',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldLabel(label: 'First Name *'),
                FirstNameTextField(),
                Gap(15),
                TextFieldLabel(label: 'Last Name *'),
                LastNameTextField(),
                Gap(15),
                TextFieldLabel(label: 'Phone *'),
                PhoneNumberTextField(),
                Gap(15),
                TextFieldLabel(label: 'Roll Number *'),
                RollNumberTextField(),
                Gap(15),
                TextFieldLabel(
                  label: 'Email',
                ),
                EmailTextField(),
                Gap(15),
                TextFieldLabel(label: 'Course *'),
                StudentCourseSelector(),
                Gap(15),
                TextFieldLabel(label: 'Semester *'),
                StudentSemesterSelector(),
                Gap(50),
                SubmitEditStudentBtn(student: student)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends HookWidget {
  const EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    provider.email = useTextEditingController();
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email';
        }
        return null;
      },
      controller: provider.email,
      keyboardType: TextInputType.phone,
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
