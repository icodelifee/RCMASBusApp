import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthRepository {
  User? fetchUser();
  Future<void> signIn(String phone, BuildContext ctx);
  Future<void> signOut();
  Future<void> submitOTP(String smsCode, String? verificationId);
}
