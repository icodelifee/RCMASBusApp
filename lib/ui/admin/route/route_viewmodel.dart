import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';
import 'package:uuid/uuid.dart';

final routeProvider = ChangeNotifierProvider.autoDispose(
    (ref) => RouteViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class RouteViewModel extends ChangeNotifier {
  RouteViewModel({required this.repo});
  final FireStoreRepository repo;

  TextEditingController? routeName;
  TextEditingController? routeLoc;

  Future<void> addRoute() async {
    await repo.addRoute({
      'route_name': routeName!.text,
      'route_location': routeLoc!.text,
      'route_id': Uuid().v4()
    });
  }

  Future<void> editRoute(Map<String, dynamic> route) async {
    final data = <String, dynamic>{};
    data['route_id'] = route['route_id'];
    data['route_name'] = routeName!.text;
    data['route_location'] = routeLoc!.text;
    await repo.editRoute(data, route['doc']);
  }
}
