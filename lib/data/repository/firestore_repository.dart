import 'package:rcmasbusapp/data/model/login_user.dart';

abstract class FireStoreRepository {
  Future<bool> checkUserEntry(String phone);
  Future<LoginUser> getLoginUser();
}
