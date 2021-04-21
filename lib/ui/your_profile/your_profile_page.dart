import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/student_provider.dart';
import 'package:rcmasbusapp/ui/components/app_bar.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/disabled_text_field.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class YourProfilePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final studentprovider = useProvider(studentProvider);
    return Scaffold(
        appBar: UAppBar(
          title: 'Profile Details',
        ),
        body: studentprovider.when(
            data: (student) => Container(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    TextFieldLabel(label: 'First Name'),
                    DisabledTextField(
                        hint: 'First Name', text: student.firstName),
                    Gap(10),
                    TextFieldLabel(label: 'Last Name'),
                    DisabledTextField(
                        hint: 'First Name', text: student.lastName),
                    Gap(10),
                    TextFieldLabel(label: 'Email'),
                    DisabledTextField(hint: 'Email', text: student.email),
                    Gap(10),
                    TextFieldLabel(label: 'Phone'),
                    DisabledTextField(hint: 'Phone', text: student.phone),
                    Gap(10),
                    TextFieldLabel(label: 'Roll Number'),
                    DisabledTextField(
                        hint: 'Roll Number', text: student.rollNumber),
                    Gap(10),
                    TextFieldLabel(label: 'Course'),
                    DisabledTextField(hint: 'Course', text: student.course),
                    Gap(10),
                    TextFieldLabel(label: 'Semester'),
                    DisabledTextField(hint: 'Semester', text: student.semester),
                  ],
                )),
            loading: () => CustomIndicator(),
            error: (err, stack) {
              showSnackbar(err.toString(), stack.toString());
              return SizedBox();
            }));
  }
}
