import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final payBusFeeProvider = ChangeNotifierProvider(
    (ref) => PayBusFeeViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class PayBusFeeViewModel extends ChangeNotifier {
  PayBusFeeViewModel({required this.repo});
  final FireStoreRepository repo;

  final user = userContainer.resolve<LoginUser>();
  TextEditingController? payCode;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<Renewal> getRenewal(String passId) async {
    return repo.getRenewal(user.rollNumber!, passId);
  }

  Future<void> saveRenewal(String passId) async {
    isLoading = true;
    final data = {
      'pass_id': passId,
      'roll_no': user.rollNumber,
      'payment_code': payCode!.text
    };
    await repo.saveRenewal(data);
    isLoading = false;
  }
}
