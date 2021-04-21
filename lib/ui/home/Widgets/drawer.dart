import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/ui/components/avatar_icon.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';

class DrawerWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pass = useProvider(busPassProvider);
    final user = userContainer.resolve<LoginUser>();
    return user.userType == 'S'
        ? pass.when(
            data: (value) =>
                value.isApproved! ? drawer(context, user) : SizedBox(),
            loading: () => SizedBox(),
            error: (_, __) => SizedBox())
        : drawer(context, user);
  }

  Drawer drawer(BuildContext context, LoginUser user) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
              currentAccountPicture: AvatarIcon(
                  firstName: user.firstName!, lastName: user.lastName!),
              accountEmail: Text(user.phone!),
              accountName: Text('${user.firstName!} ${user.lastName!}')),
          Spacer(),
          // Divider(),
          // ListTile(
          //     title: Text('Change Theme'),
          //     onTap: () => Get.changeTheme(
          //         Get.isDarkMode ? ThemeData.light() : ThemeData.dark())),
          Divider(),
          ListTile(
            onTap: () {
              context.read(loginViewModelProvider).signOut();
              userContainer.clear();
            },
            title: Text(
              'Sign out',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
