import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/auth_changes_provider.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/ui/admin/home/home_page.dart';
import 'package:rcmasbusapp/ui/components/loading_page.dart';
import 'package:rcmasbusapp/ui/login/login_page.dart';
import 'package:rcmasbusapp/ui/home/home_page.dart';
import 'package:rcmasbusapp/ui/registration/registration_page.dart';
import 'package:rcmasbusapp/ui/registration/registration_payment_page.dart';

final userFetchProvider = FutureProvider.autoDispose(
    (ref) async => await ref.watch(fireStoreRepositoryProvider).getLoginUser());

class RouteLocator extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authChangeProvider = useProvider(authChangesProvider);
    return authChangeProvider.when(
        data: (User? user) {
          if (user == null) {
            return LoginPage();
          } else {
            final userProvider = useProvider(userFetchProvider);
            return userProvider.when(
                data: (data) {
                  if (data.userType == 'A') {
                    return AdminHomePage();
                  } else {
                    if (data.regComplete ?? false) {
                      if (data.payComplete ?? false) {
                        return HomePage();
                      } else {
                        return RegistrationPaymentPage();
                      }
                    } else {
                      return RegistrationPage(user: data);
                    }
                  }
                },
                loading: () => LoadingPage(),
                error: (_, __) => LoadingPage());
          }
        },
        loading: () => LoadingPage(),
        error: (_, __) => LoadingPage());
  }
}
