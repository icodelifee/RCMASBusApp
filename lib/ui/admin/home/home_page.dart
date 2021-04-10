import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_page.dart';
import 'package:rcmasbusapp/ui/admin/route/route_page.dart';
import 'package:rcmasbusapp/ui/admin/students_list/students_list_page.dart';
import 'package:rcmasbusapp/ui/home/Widgets/drawer.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Admin Panel'),
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              StudentListTile(),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () => Get.to(RouteListPage()),
                  borderRadius: circularBorder,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 80.0,
                    width: 150.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Routes',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF44B679)),
                        ),
                        Gap(6),
                        Text('List',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () => Get.to(() => BusPassPage()),
                  borderRadius: circularBorder,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 80.0,
                    width: 150.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Bus Pass',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF44B679)),
                        ),
                        Gap(6),
                        Text('List',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class StudentListTile extends StatelessWidget {
  const StudentListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => Get.to(StudentsListPage()),
        borderRadius: circularBorder,
        child: Container(
          padding: EdgeInsets.all(20),
          height: 80.0,
          width: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Students',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44B679)),
              ),
              Gap(6),
              Text('List',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
