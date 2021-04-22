import 'package:flutter/material.dart';
import 'package:rcmasbusapp/data/model/route.dart' as r;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final newRoutesProvider = FutureProvider.autoDispose(
    (ref) async => await ref.watch(fireStoreRepositoryProvider).getAllRoutes());

final changeRouteProvider = ChangeNotifierProvider.autoDispose((ref) =>
    ChangeRouteViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class ChangeRouteViewModel extends ChangeNotifier {
  ChangeRouteViewModel({required this.repo});
  final FireStoreRepository repo;

  final key = GlobalKey<FormState>();
  r.Route? _newRoute;
  Stop? _newStop;

  Stop? get newStop => _newStop;
  r.Route? get newRoute => _newRoute;

  set newRoute(r.Route? newRoute) {
    _newRoute = newRoute;
    notifyListeners();
  }

  set newStop(Stop? newStop) {
    _newStop = newStop;
    notifyListeners();
  }

  Future<void> changeRoute() async {}
}
