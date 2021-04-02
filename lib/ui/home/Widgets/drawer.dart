import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';

class DrawerWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final pass = useProvider(busPassProvider);
    return pass.when(
        data: (value) => value.isApproved!
            ? Drawer(
                child: Column(
                  children: [
                    Spacer(),
                    Divider(),
                    ListTile(
                      onTap: () {
                        context.read(loginViewModelProvider).signOut();
                      },
                      title: Text(
                        'Sign out',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              )
            : SizedBox(),
        loading: () => SizedBox(),
        error: (_, __) => SizedBox());
  }
}
