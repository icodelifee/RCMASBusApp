import 'package:flutter/material.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/bus_pass_listview.dart';

class BusPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AdminAppBar(
          title: 'Bus Passes ',
        ),
        body: Container(padding: EdgeInsets.all(20), child: BusPassListView()));
  }
}
