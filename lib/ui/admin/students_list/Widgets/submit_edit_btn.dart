import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';

class SubmitEditStudentBtn extends HookWidget {
  SubmitEditStudentBtn({required this.student});
  final Student student;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    return TextButton(
        onPressed: () async {
          if (provider.editStudentKey.currentState!.validate()) {
            await provider.editStudent(student);
            Get.back();
            showSnackbar('Sucess!', 'Student has been edited');
          } else {
            showSnackbar('Please fill all the fields',
                'All Fields must be filled to procced');
          }
        },
        style: buttonStyle,
        child: SizedBox(
          height: 40,
          child: !provider.isLoading!
              ? Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
        ));
  }
}
