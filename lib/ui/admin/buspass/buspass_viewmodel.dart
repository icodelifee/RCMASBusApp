import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final busPassViewProvider = ChangeNotifierProvider.autoDispose(
    (ref) => BusPassViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

final busFutureProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(fireStoreRepositoryProvider).getAllBus());

class BusPassViewModel extends ChangeNotifier {
  BusPassViewModel({required this.repo});
  final FireStoreRepository repo;

  Future<List<BusPass>> getAllBusPass() {
    return repo.getAllBusPass();
  }

  Future<void> approveBusPass(Bus bus, DateTime time, String docId) async {
    final pass = <String, dynamic>{};
    pass['is_approved'] = true;
    pass['renewal_date'] = time;
    pass['bus_id'] = bus.busId;
    await repo.approveBusPass(pass, docId, bus.docId!);
  }
}
