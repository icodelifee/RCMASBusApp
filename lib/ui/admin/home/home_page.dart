import 'package:flutter/material.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_page.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_page.dart';
import 'package:rcmasbusapp/ui/admin/drivers/drivers_page.dart';
import 'package:rcmasbusapp/ui/admin/home/Widgets/homepage_information.dart';
import 'package:rcmasbusapp/ui/admin/home/Widgets/homepage_listtile.dart';
import 'package:rcmasbusapp/ui/admin/renewals/renewals_menu_page.dart';
import 'package:rcmasbusapp/ui/admin/route/route_page.dart';
import 'package:rcmasbusapp/ui/admin/route_changes/route_changes.dart';
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
              HomepageInformation(),
              HomePageListTile(
                title: 'Students',
                route: StudentsListPage(),
                image: 'assets/student.png',
              ),
              HomePageListTile(
                title: 'Routes',
                route: RouteListPage(),
                image: 'assets/route.png',
              ),
              HomePageListTile(
                title: 'Bus Pass',
                route: BusPassPage(),
                image: 'assets/bus-ticket.png',
              ),
              HomePageListTile(
                title: 'Drivers',
                route: DriversPage(),
                image: 'assets/driver.png',
              ),
              HomePageListTile(
                title: 'Buses',
                route: BusesPage(),
                image: 'assets/bus.png',
              ),
              HomePageListTile(
                title: 'Renewals',
                route: RenewalsMenuPage(),
                image: 'assets/renewal.png',
              ),
              HomePageListTile(
                title: 'Route Changes',
                route: RouteChangesPage(),
                image: 'assets/change.png',
              )
            ],
          )),
    );
  }
}
