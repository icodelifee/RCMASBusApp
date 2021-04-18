import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/ui/admin/students_list/edit_student.dart';
import 'package:rcmasbusapp/ui/admin/students_list/view_student.dart';
import 'package:rcmasbusapp/ui/components/avatar_icon.dart';

class StudentDetailsCard extends StatelessWidget {
  const StudentDetailsCard(
      {Key? key, required this.student, required this.noEdit})
      : super(key: key);
  final Student student;
  final bool noEdit;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(20),
          child: ListTile(
            leading: AvatarIcon(
                firstName: student.firstName!, lastName: student.lastName!),
            title: Text(
              '${student.firstName!} ${student.lastName!}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text('${student.rollNumber} | ${student.course}'),
            onTap: () => Get.to(() => ViewStudent(student: student)),
            trailing: !noEdit
                ? IconButton(
                    onPressed: () =>
                        Get.to(() => EditStudent(student: student)),
                    icon: Icon(Icons.edit),
                  )
                : null,
          )),
    );
  }
}
