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
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors.accentColor,
          accentColor: AppColors.accentColor,
          backgroundColor: Color(0xFF121212),
          scaffoldBackgroundColor: Color(0xFF121212),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Circular Std',
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.buttonColor,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: AppColors.buttonColor,
          ),
          buttonColor: AppColors.buttonColor),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: AppColors.accentColor,
          accentColor: AppColors.accentColor,
          backgroundColor: Color(0xFFF3F2F0),
          scaffoldBackgroundColor: Color(0xFFF3F2F0),
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
