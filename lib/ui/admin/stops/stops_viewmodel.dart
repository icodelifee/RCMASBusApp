import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';
import 'package:uuid/uuid.dart';

final stopsProvider = ChangeNotifierProvider.autoDispose(
    (ref) => StopsViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class StopsViewModel extends ChangeNotifier {
  StopsViewModel({required this.repo});
  final FireStoreRepository repo;

  // keys
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //controllers
  TextEditingController? stopName;
  TextEditingController? stopLoc;
  TextEditingController? timeCtrl;

  // mutables
  DateTime? time;

  Future<List<Stop>> getStops(String route) {
    return repo.getBusStops(route);
  }

  Future<void> addStop(String routeId) async {
    await repo.addStop({
      'stop_name': stopName!.text,
      'stop_location': stopLoc!.text,
      'arrival_time': time,
      'stop_id': Uuid().v4()
    }, routeId);
  }

  Future<void> deleteStop(String stopDocId, String routeDocId) async {
    await repo.deleteStop(stopDocId, routeDocId);
  }

  Future<void> editStop(Map<String, dynamic> stop, String routeId) async {
    final data = <String, dynamic>{};
    data['stop_id'] = stop['stop_id'];
    data['stop_name'] = stopName!.text;
    data['stop_location'] = stopLoc!.text;
    data['arrival_time'] = time;
    await repo.editStop(data, routeId, stop['doc']);
  }
}
