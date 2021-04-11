import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_viewmodel.dart';

class UnregisteredStudents extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(studentListProvider);
    final students =
        useFuture(provider.getUnregisteredUsers(), initialData: <LoginUser>[]);
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Unregistered Students List',
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: students.hasData
              ? ListView.builder(
                  itemCount: students.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      shape: roundedRectangleBorder,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(20),
                        title: Text(
                          '${students.data![index].firstName!} ${students.data![index].lastName!}',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(5),
                            Text(
                                'Roll Number : ${students.data![index].rollNumber!}'),
                            Gap(5),
                            Text('Phone : ${students.data![index].phone!}'),
                            Gap(5),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No Students Found!'),
                )),
    );
  }
}
