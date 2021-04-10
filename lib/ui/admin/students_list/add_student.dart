import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class AddStudentPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final key = useProvider(studentListProvider).addStudentKey;
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Add Student',
      ),
      body: Container(
        height: Get.height,
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
                // Spacer(),
                Gap(50),
                SubmitAddStudentBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitAddStudentBtn extends HookWidget {
  const SubmitAddStudentBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    return TextButton(
        onPressed: () async {
          if (provider.addStudentKey.currentState!.validate()) {
            await provider.addStudent();
            Get.back();
            showSnackbar('Sucess!', 'New Student Has Been Added.');
          } else {
            showSnackbar('Please fill all the fields',
                'All Fields must be filled to procced');
          }
        },
        style: buttonStyle,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              'Submit',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

class RollNumberTextField extends HookWidget {
  const RollNumberTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    provider.rollNo = useTextEditingController();
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter roll number';
        }
        return null;
      },
      controller: provider.rollNo,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Roll number'),
    );
  }
}

class PhoneNumberTextField extends HookWidget {
  const PhoneNumberTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    provider.phone = useTextEditingController();
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter phone';
        } else if (value.length < 10 || value.length > 10) {
          return 'Please enter correct phone number';
        }
        return null;
      },
      controller: provider.phone,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Phone'),
    );
  }
}

class LastNameTextField extends HookWidget {
  const LastNameTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    provider.lastName = useTextEditingController();
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter last name';
        }
        return null;
      },
      controller: provider.lastName,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Last Name'),
    );
  }
}

class FirstNameTextField extends HookWidget {
  const FirstNameTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    provider.firstName = useTextEditingController();
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter first name';
        }
        return null;
      },
      controller: provider.firstName,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'First Name'),
    );
  }
}
