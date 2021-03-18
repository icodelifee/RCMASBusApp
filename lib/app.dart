import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/route_locator.dart';
import 'package:rcmasbusapp/ui/login/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RCMAS Bus App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Circular Std',
          cursorColor: AppColors.buttonColor,
          buttonTheme: ButtonThemeData(
            buttonColor: AppColors.buttonColor,
          ),
          buttonColor: AppColors.buttonColor),
      defaultTransition: Transition.cupertino,
      home: RouteLocator(),
    );
  }
}
