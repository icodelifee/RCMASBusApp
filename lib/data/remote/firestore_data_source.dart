import 'package:rcmasbusapp/data/model/login_user.dart';

abstract class FireStore {
  Future<bool> checkUserEntry(String phone);
  Future<LoginUser> getLoginUser();
}
