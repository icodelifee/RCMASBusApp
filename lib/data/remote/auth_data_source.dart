import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthDataSource {
  Stream<User> get authStateChanges;

  User getUser();

  Future<void> signIn(String phone, BuildContext context);

  Future<void> signOut();

  Future<void> submitOTP(String smsCode, String verificationId);
}
