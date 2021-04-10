import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/route_locator.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RCMAS Bus App',
      theme: ThemeData(
          primaryColor: AppColors.accentColor,
          accentColor: AppColors.accentColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Circular Std',
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.buttonColor,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: AppColors.buttonColor,
          ),
          buttonColor: AppColors.buttonColor),
      defaultTransition: Transition.cupertino,
      home: RouteLocator(),
    );
  }
}
