import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/students_list/add_student.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/students_list/unregistered_students.dart';
import 'package:rcmasbusapp/ui/components/avatar_icon.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

import 'edit_student.dart';

class StudentsListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);

    return Scaffold(
      appBar: AdminAppBar(
        title: 'Students List',
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addstud',
        onPressed: () => Get.to(() => AddStudentPage()),
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter student name to search';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          provider.searchText = val;
                        },
                        decoration: InputDecoration(
                            border: border,
                            suffixIcon: Icon(Icons.search),
                            focusedBorder: border,
                            enabledBorder: border,
                            filled: true,
                            fillColor: AppColors.textInputFillColor,
                            hintText: 'Search Students'),
                      ),
                    ),
                    Gap(10),
                    SizedBox(
                      width: Get.width / 3.4,
                      height: 60,
                      child: DropdownButtonFormField<int>(
                        isDense: true,
                        onChanged: (int? val) {
                          // studentProvider.
                          provider.searchYear = val;
                        },
                        items: List.generate(
                            6,
                            (index) => DropdownMenuItem<int>(
                                value: DateTime.now().year - index,
                                child: Text(
                                    (DateTime.now().year - index).toString()))),
                        decoration: InputDecoration(
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border,
                            hintText: 'Year',
                            fillColor: AppColors.textInputFillColor,
                            filled: true),
                      ),
                    )
                  ]),
              Gap(10),
              ElevatedButton(
                  onPressed: () => Get.to(() => UnregisteredStudents()),
                  style: buttonStyle,
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Unregistered Students',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  )),
              FutureBuilder(
                future: provider.getStudents(
                    provider.searchYear ?? 0, provider.searchText ?? ''),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Student>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          padding: EdgeInsets.only(top: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: ListTile(
                                    leading: AvatarIcon(
                                        firstName:
                                            snapshot.data![index].firstName!,
                                        lastName:
                                            snapshot.data![index].lastName!),
                                    title: Text(
                                      '${snapshot.data![index].firstName!} ${snapshot.data![index].lastName!}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text(
                                        '${snapshot.data![index].rollNumber} | ${snapshot.data![index].course}'),
                                    trailing: IconButton(
                                      onPressed: () => Get.to(() => EditStudent(
                                          student: snapshot.data![index])),
                                      icon: Icon(Icons.edit),
                                    ),
                                  )),
                            );
                          });
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text('No Students Found'),
                        ),
                      );
                    }
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: CustomIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
