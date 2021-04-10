import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/course_selector.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/disabled_text_field.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/email_text_field.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/registration_appbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/semester_selector.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';
import 'Widgets/next_btn.dart';

class RegistrationPage extends HookWidget {
  RegistrationPage({required user}) : _user = user;
  final LoginUser? _user;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(registrationPageViewModelProvider);
    provider.email = useTextEditingController();
    return Scaffold(
      appBar: RegistrationAppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: provider.formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Gap(10),
              TextFieldLabel(label: 'First name'),
              DisabledTextField(hint: 'First name', text: _user!.firstName),
              Gap(15),
              TextFieldLabel(label: 'Last name'),
              DisabledTextField(hint: 'Last name', text: _user!.lastName),
              Gap(15),
              TextFieldLabel(label: 'Roll number'),
              DisabledTextField(hint: 'Roll number', text: _user!.rollNumber),
              Gap(15),
              TextFieldLabel(label: 'Phone'),
              DisabledTextField(hint: 'Phone number', text: _user!.phone),
              Gap(15),
              TextFieldLabel(label: 'Email *'),
              EmailTextField(),
              Gap(15),
              TextFieldLabel(label: 'Course *'),
              CourseSelector(),
              Gap(15),
              TextFieldLabel(label: 'Semester *'),
              SemesterSelector(),
              Gap(15),
              NextButton(
                user: _user!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
