import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/payment.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final renewalsProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(fireStoreRepositoryProvider).getAllRenewals());

final renewalViewProvider = ChangeNotifierProvider.autoDispose(
    (ref) => RenewalsViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class RenewalsViewModel extends ChangeNotifier {
  RenewalsViewModel({required this.repo});
  final FireStoreRepository repo;

  Future<void> approveRenewal(DateTime date, Renewal renewal) async {
    final data = <String, dynamic>{
      'docId': renewal.docId,
      'pass_id': renewal.pass!.docId,
      'payment_id': renewal.paymentId,
      'renewal_date': date
    };
    await repo.approveRenewal(data);
  }
}
