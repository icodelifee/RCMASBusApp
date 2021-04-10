import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';
import 'auth_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({required FirebaseAuth auth}) : _auth = auth;

  static final Logger _logger = Logger();
  final FirebaseAuth _auth;
  late BuildContext ctx;

  final PhoneCodeAutoRetrievalTimeout _codeAutoRetrievalTimeout =
      (String verificationId) {
    _logger.d('Code Time Out');
  };

  void _verificationFailed(FirebaseAuthException authException) {
    var status = authException.message;
    _logger.d(status);
    if (authException.message!.contains('not authorized')) {
      status = 'Something has gone wrong, please try later';
    } else if (authException.message!.contains('Network')) {
      status = 'Please check your internet connection and try again';
    } else {
      status = 'Something has gone wrong, please try later';
    }
    ctx.read(loginViewModelProvider).updateStatus(status);
  }

  final PhoneVerificationCompleted _verificationComplete =
      (PhoneAuthCredential creds) async {
    await FirebaseAuth.instance.signInWithCredential(creds);
    _logger.d('Logged In');
  };

  @override
  Future<void> signIn(String phone, BuildContext context) async {
    ctx = context;
    return FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phone,
        verificationCompleted: _verificationComplete,
        verificationFailed: _verificationFailed,
        codeSent: (String verificationId, [int? forceResendingToken]) async {
          _logger.d('Code Sent');
          context
              .read(loginViewModelProvider)
              .updateVerificationId(verificationId);
        },
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  @override
  User? getUser() {
    return _auth.currentUser;
  }

  @override
  Future<void> submitOTP(String smsCode, String? verificationId) async {
    final phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: smsCode) as PhoneAuthCredential;
    await _auth.signInWithCredential(phoneAuthCredential);
  }

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
