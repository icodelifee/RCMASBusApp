import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/provider/connection_provider.dart';
import 'package:rcmasbusapp/route_locator.dart';
import 'package:rcmasbusapp/ui/components/internet_error_page.dart';
import 'package:rcmasbusapp/ui/components/loading_page.dart';

class App extends HookWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final connection = useProvider(connectionProvider!);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RCMAS Bus App',
        // darkTheme: ThemeData(
        //     brightness: Brightness.dark,
        //     primaryColor: AppColors.accentColor,
        //     accentColor: AppColors.accentColor,
        //     backgroundColor: Color(0xFF121212),
        //     scaffoldBackgroundColor: Color(0xFF121212),
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
        //     fontFamily: 'Circular Std',
        //     textSelectionTheme: TextSelectionThemeData(
        //       cursorColor: AppColors.buttonColor,
        //     ),
        //     buttonTheme: ButtonThemeData(
        //       buttonColor: AppColors.buttonColor,
        //     ),
        //     buttonColor: AppColors.buttonColor),
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
        home: connection.when(
            data: (ConnectivityResult val) {
              switch (val) {
                case ConnectivityResult.mobile:
                  return RouteLocator();
                case ConnectivityResult.wifi:
                  return RouteLocator();
                case ConnectivityResult.none:
                  return InternetErrorPage();
              }
            },
            error: (_, __) => InternetErrorPage(),
            loading: () => LoadingPage()));
  }
}
