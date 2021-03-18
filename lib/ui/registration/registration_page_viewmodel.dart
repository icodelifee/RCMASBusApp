import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final registationPageViewModelProvider = ChangeNotifierProvider((ref) =>
    RegistrationPageViewModel(
        fireStore: ref.read(fireStoreRepositoryProvider)));

class RegistrationPageViewModel extends ChangeNotifier {
  RegistrationPageViewModel({required fireStore}) : _fireStore = fireStore;
  final FireStoreRepository _fireStore;

  Future<void> saveUserData() async {}
}
