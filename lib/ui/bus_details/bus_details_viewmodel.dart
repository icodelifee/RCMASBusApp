import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final busDetailsViewProvider = ChangeNotifierProvider(
    (ref) => BusDetailsViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class BusDetailsViewModel extends ChangeNotifier {
  BusDetailsViewModel({required this.repo});
  final FireStoreRepository repo;

  Future<Driver>? driver;

  Future<Driver> getDriver(String id) {
    return repo.getDriver(id);
  }
}
