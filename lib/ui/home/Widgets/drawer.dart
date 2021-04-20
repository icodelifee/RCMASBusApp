import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';
import 'package:rcmasbusapp/ui/login/login_page.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';

class DrawerWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pass = useProvider(busPassProvider);
    final user = userContainer.resolve<LoginUser>();
    return user.userType == 'S'
        ? pass.when(
            data: (value) => value.isApproved! ? drawer(context) : SizedBox(),
            loading: () => SizedBox(),
            error: (_, __) => SizedBox())
        : drawer(context);
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Spacer(),
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
