import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/auth_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/auth_repository.dart';

final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>(
    (ref) => LoginViewModel(repository: ref.read(authRepositoryProvider)));

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({@required repository}) : _repository = repository;

  final AuthRepository _repository;

  String verificationId;
  String status;

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

  Future<void> signOut() {
    return _repository.signOut();
  }
}
