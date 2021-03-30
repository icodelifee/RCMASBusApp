import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/student.dart';

abstract class FireStore {
  Future<bool> checkUserEntry(String phone);
  Future<LoginUser> getLoginUser();
  Future getBusRoutes();
  Future<List<Map>> getBusStops(String? route);
  Future<void> saveUserData(Map<String, dynamic> data);
  Future<void> savePayment(String payCode);
  Future<Student> getStudent(String rollNo);
}
