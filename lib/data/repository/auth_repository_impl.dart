import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rcmasbusapp/data/remote/auth_data_source.dart';
import 'package:rcmasbusapp/data/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDataSource authDataSource})
      : _dataSource = authDataSource;

  final AuthDataSource _dataSource;

  @override
  User? fetchUser() {
    return _dataSource.getUser();
  }

  @override
  Future<void> signIn(String phone, BuildContext ctx) {
    return _dataSource.signIn(phone, ctx);
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }

  @override
  Future<void> submitOTP(String smsCode, String? verificationId) {
    return _dataSource.submitOTP(smsCode, verificationId);
  }
}
