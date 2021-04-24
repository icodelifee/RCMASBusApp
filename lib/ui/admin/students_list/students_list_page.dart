import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/students_list/Widgets/student_details_card.dart';
import 'package:rcmasbusapp/ui/admin/students_list/add_student.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/students_list/unregistered_students.dart';
import 'package:rcmasbusapp/ui/components/no_data.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

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
      body: Container(
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
                    return Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            padding: EdgeInsets.only(top: 10),
                            itemBuilder: (BuildContext context, int index) {
                              return StudentDetailsCard(
                                student: snapshot.data![index],
                                noEdit: false,
                              );
                            }),
                      ),
                    );
                  } else {
                    return NoData();
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
    );
  }
}
