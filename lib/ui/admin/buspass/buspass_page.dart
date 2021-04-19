import 'package:flutter/material.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buspass/approved_buspass_page.dart';
import 'package:rcmasbusapp/ui/admin/buspass/unapproved_buspass_page.dart';

class BusPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Bus Passes'),
            bottom: TabBar(
              indicatorColor: AppColors.secondaryColor,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(Icons.approval),
                  text: 'Approved',
                ),
                Tab(
                  icon: Icon(Icons.not_interested_sharp),
                  text: 'Unapproved',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [ApprovedBusPassPage(), UnApprovedBusPassPage()],
          )),
    );
  }
}
