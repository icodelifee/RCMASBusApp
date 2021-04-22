import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/auth_changes_provider.dart';
import 'package:rcmasbusapp/data/provider/connection_provider.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/ui/admin/home/home_page.dart';
import 'package:rcmasbusapp/ui/components/internet_error_page.dart';
import 'package:rcmasbusapp/ui/components/loading_page.dart';
import 'package:rcmasbusapp/ui/login/login_page.dart';
import 'package:rcmasbusapp/ui/home/home_page.dart';
import 'package:rcmasbusapp/ui/registration/registration_page.dart';
import 'package:rcmasbusapp/ui/registration/registration_payment_page.dart';

class RouteLocator extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fetchUser = context.read(fireStoreRepositoryProvider).getLoginUser;
    final connection = useProvider(connectionProvider!);
    final authChangeProvider = useProvider(authChangesProvider);
    return connection.when(
        data: (ConnectivityResult val) {
          if (val != ConnectivityResult.none) {
            return authChangeProvider.data!.when(
                data: (User? user) {
                  if (user == null) {
                    return LoginPage();
                  } else {
                    final userFuture = useMemoized(fetchUser);
                    final loginUser = useFuture(userFuture, initialData: null);
                    if (loginUser.hasData) {
                      if (loginUser.data!.userType == 'A') {
                        return AdminHomePage();
                      } else {
                        if (loginUser.data!.regComplete ?? false) {
                          if (loginUser.data!.payComplete ?? false) {
                            return HomePage();
                          } else {
                            return RegistrationPaymentPage();
                          }
                        } else {
                          return RegistrationPage(user: loginUser.data);
                        }
                      }
                    } else {
                      return LoadingPage();
                    }
                  }
                },
                loading: () => LoadingPage(),
                error: (_, __) => LoadingPage());
          } else {
            // TODO will add lottie animations
            return InternetErrorPage();
          }
        },
        error: (Object error, StackTrace? stackTrace) {
          return InternetErrorPage();
        },
        loading: () => LoadingPage());
  }
}
