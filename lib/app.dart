import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/ui/login/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RCMAS Bus App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      defaultTransition: Transition.cupertino,
      home: LoginPage(),
    );
  }
}
