import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';

class RegistrationPage extends HookWidget {
  RegistrationPage({@required user}) : _user = user;
  final LoginUser _user;
  final List<String> semesters = ['I', 'II', 'III', 'IV', 'V', 'VI'];
  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController();
    final course = useTextEditingController();
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          shrinkWrap: true,
          children: [
            Gap(10),
            textFieldLabel('First name'),
            disabledTextField('First name', _user.firstName),
            Gap(15),
            textFieldLabel('Last name'),
            disabledTextField('Last name', _user.lastName),
            Gap(15),
            textFieldLabel('Roll number'),
            disabledTextField('Roll number', _user.rollNumber),
            Gap(15),
            textFieldLabel('Phone'),
            disabledTextField('Phone number', _user.phone),
            Gap(15),
            textFieldLabel('Email *'),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  border: border,
                  focusedBorder: border,
                  enabledBorder: border,
                  filled: true,
                  fillColor: AppColors.textInputFillColor,
                  hintText: 'Email'),
            ),
            Gap(15),
            textFieldLabel('Course *'),
            TextField(
              controller: course,
              decoration: InputDecoration(
                  border: border,
                  focusedBorder: border,
                  enabledBorder: border,
                  filled: true,
                  fillColor: AppColors.textInputFillColor,
                  hintText: 'Course'),
            ),
            Gap(15),
            textFieldLabel('Semester *'),
            semesterSelector(),
            Gap(15),
            nextButton()
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> semesterSelector() {
    return DropdownButtonFormField(
      hint: Text('Select semester'),
      items: semesters
          .map((e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ))
          .toList(),
      onChanged: (val) {},
      decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          fillColor: AppColors.textInputFillColor,
          filled: true),
    );
  }

  TextField disabledTextField(String hint, String text) {
    return TextField(
      controller: TextEditingController(text: text ?? ''),
      decoration: InputDecoration(
          border: border,
          enabled: false,
          focusedBorder: border,
          disabledBorder: border,
          enabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: hint),
    );
  }

  FlatButton nextButton() {
    return FlatButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
      color: AppColors.buttonColor,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Registration',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Padding textFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 5),
      child: Text(
        text,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
    );
  }
}
