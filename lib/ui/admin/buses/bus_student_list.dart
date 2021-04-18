import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/students_list/Widgets/student_details_card.dart';
import 'package:rcmasbusapp/ui/components/error_text.dart';
import 'package:rcmasbusapp/ui/components/no_data.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class BusStudentsList extends HookWidget {
  const BusStudentsList({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busStudentsProvider(id));
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Bus Students List',
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: provider.when(
              data: (List<Student> students) {
                if (students.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: students.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StudentDetailsCard(
                          student: students[index], noEdit: true);
                    },
                  );
                } else {
                  return NoData();
                }
              },
              loading: () => CustomIndicator(),
              error: (err, stack) => ErrorText())),
    );
  }
}
