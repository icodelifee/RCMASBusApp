import 'package:flutter/material.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_page.dart';
import 'package:rcmasbusapp/ui/admin/drivers/drivers_page.dart';
import 'package:rcmasbusapp/ui/admin/home/Widgets/homepage_listtile.dart';
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
              HomePageListTile(title: 'Students', route: StudentsListPage()),
              HomePageListTile(title: 'Routes', route: RouteListPage()),
              HomePageListTile(title: 'Bus Pass', route: BusPassPage()),
              HomePageListTile(title: 'Drivers', route: DriversPage())
            ],
          )),
    );
  }
}
