import 'package:flutter/cupertino.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/remote/firestore_data_source.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

class FireStoreRepositoryImpl implements FireStoreRepository {
  FireStoreRepositoryImpl({@required FireStore fireStoreDataSource})
      : _fireStoreDataSource = fireStoreDataSource;

  final FireStore _fireStoreDataSource;

  @override
  Future<bool> checkUserEntry(String phone) {
    return _fireStoreDataSource.checkUserEntry(phone);
  }

  @override
  Future<LoginUser> getLoginUser() {
    return _fireStoreDataSource.getLoginUser();
  }
}
