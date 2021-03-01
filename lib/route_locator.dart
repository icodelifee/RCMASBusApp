import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/auth_changes_provider.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/ui/login/login_page.dart';
import 'package:rcmasbusapp/ui/home/home_page.dart';
import 'package:rcmasbusapp/ui/registration/registration_page.dart';

class RouteLocator extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fetchUser = context.read(fireStoreRepositoryProvider).getLoginUser;
    final authChangeProvider = useProvider(authChangesProvider);
    return authChangeProvider.data.when(data: (User user) {
      if (user == null) {
        return LoginPage();
      } else {
        final userFuture = useMemoized(fetchUser);
        final loginUser = useFuture(userFuture);
        if (loginUser.hasData) {
          if (loginUser.data.regComplete ?? false) {
            return HomePage();
          } else {
            return RegistrationPage();
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    }, loading: () {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }, error: (_, __) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
