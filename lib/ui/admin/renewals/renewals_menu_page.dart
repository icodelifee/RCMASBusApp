import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/renewals/not_renewed_page.dart';
import 'package:rcmasbusapp/ui/admin/renewals/renewals_page.dart';

class RenewalsMenuPage extends StatelessWidget {
  const RenewalsMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Renewals',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          _menuCard('All Renewals', RenewalsPage()),
          _menuCard('Not Renewed', NotRenewed())
        ]),
      ),
    );
  }

  Container _menuCard(String text, Widget route) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      child: Card(
        elevation: 1.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Get.to(route);
          },
          borderRadius: circularBorder,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            padding: EdgeInsets.all(20),
            height: 80.0,
            width: 150.0,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
