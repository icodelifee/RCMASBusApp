import 'package:rcmasbusapp/data/model/login_user.dart';

abstract class FireStoreRepository {
  Future<bool> checkUserEntry(String phone);
  Future getBusRoutes();
  Future<LoginUser> getLoginUser();
  Future<List<Map<String, dynamic>>> getBusStops(String? route);
  Future<void> saveUserData(Map<String, dynamic> data);
  Future<void> savePayment(String payCode);
  Future<void> generateBusPass(Map<String, dynamic> data);
}
