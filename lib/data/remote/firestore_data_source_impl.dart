import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/remote/firestore_data_source.dart';

class FireStoreImpl implements FireStore {
  FireStoreImpl({required auth}) : _auth = auth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth;
  final Logger _logger = Logger();
  @override
  Future<bool> checkUserEntry(String phone) async {
    final qs = await firestore
        .collection('login')
        .where('phone', isEqualTo: phone)
        .get();
    return qs.docs.isNotEmpty;
  }

  @override
  Future<LoginUser> getLoginUser() async {
    final qs = await firestore
        .collection('login')
        .where('phone',
            isEqualTo: _auth.currentUser!.phoneNumber!.replaceAll('+', ''))
        .get();
    final user = LoginUser.fromJson(qs.docs.first.data()!);
    return user;
  }
}
