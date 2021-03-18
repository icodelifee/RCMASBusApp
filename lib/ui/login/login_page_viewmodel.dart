import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/auth_repository_provider.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/auth_repository.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) =>
    LoginViewModel(
        repository: ref.read(authRepositoryProvider),
        fireStoreRepo: ref.read(fireStoreRepositoryProvider)));

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required repository, required fireStoreRepo})
      : _repository = repository,
        _fireStore = fireStoreRepo;

  final AuthRepository _repository;
  final FireStoreRepository _fireStore;

  String? verificationId;
  String? status;

  void updateVerificationId(String verId) {
    verificationId = verId;
    notifyListeners();
  }

  void updateStatus(String message) {
    status = message;
    notifyListeners();
  }

  Future<void> signIn(String phone, BuildContext context) {
    // passing in context for provider to update verfication id and status
    // wil switch to provider reference or keys later
    return _repository.signIn(phone, context);
  }

  Future<void> submitOTP(String smsCode) {
    return _repository.submitOTP(smsCode, verificationId);
  }

  Future<bool> checkUserEntry(String phone) {
    return _fireStore.checkUserEntry('91' + phone);
  }

  Future<void> signOut() {
    return _repository.signOut();
  }
}
