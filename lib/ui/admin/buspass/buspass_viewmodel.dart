import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final busPassViewProvider = ChangeNotifierProvider.autoDispose(
    (ref) => BusPassViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class BusPassViewModel extends ChangeNotifier {
  BusPassViewModel({required this.repo});
  final FireStoreRepository repo;

  Future<List<BusPass>> getAllBusPass() {
    return repo.getAllBusPass();
  }
}
