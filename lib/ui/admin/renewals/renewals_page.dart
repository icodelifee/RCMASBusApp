import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'Widgets/approved_renewals.dart';
import 'Widgets/not_approved_renewals.dart';

class RenewalsPage extends HookWidget {
  RenewalsPage({Key? key}) : super(key: key);
  final pages = [
    ApprovedRenewals(),
    NotApprovedRenewals(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Renewals List'),
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: AppColors.secondaryColor,
              tabs: [
                Tab(
                  icon: Icon(Icons.approval),
                  text: 'Approved',
                ),
                Tab(
                  icon: Icon(Icons.highlight_off_rounded),
                  text: 'Not Approved',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: pages,
          )),
    );
  }
}
