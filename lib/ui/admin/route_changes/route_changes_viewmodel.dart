import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final routeChangeListProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(fireStoreRepositoryProvider).getAllChangeRoutes());


class RouteChangeViewModel extends ChangeNotifier {
  RouteChangeViewModel({required this.repo});
  final FireStoreRepository repo;
}
