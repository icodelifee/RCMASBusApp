import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final homePageProvider = ChangeNotifierProvider.autoDispose(
    (ref) => HomePageViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

final busPassProvider = FutureProvider.autoDispose<BusPass>(
    (ref) async => await ref.watch(fireStoreRepositoryProvider).getBusPass());

final yourBusProvider = FutureProvider.autoDispose<YourBus>(
    (ref) async => await ref.watch(fireStoreRepositoryProvider).yourBusData());

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel({required this.repo});
  final FireStoreRepository repo;
}
