import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/payment.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/data/model/route.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';

abstract class FireStore {
  Future<bool> checkUserEntry(String phone);
  Future<LoginUser> getLoginUser();
  Future getBusRoutes();
  Future<List<Map<String, dynamic>>> getBusStops(String? route);
  Future<void> saveUserData(Map<String, dynamic> data);
  Future<void> savePayment(String payCode);
  Future<Student> getStudent(String rollNo);
  Future<void> generateBusPass(Map<String, dynamic> data);
  Future<BusPass> getBusPass();
  Future<Stream<DocumentSnapshot>> getBusPassStream();
  Future<YourBus> yourBusData();
  Future<Bus> getBus(String id);
  Future<Route> getRoutes(String id);
  Future<Map<String, dynamic>> getInformation();
  Future<Driver> getDriver(String id);
  Future<List<Payment>> getStudentPayments(String id);
  Future<void> saveRenewal(Map<String, dynamic> data);
  Future<Renewal> getRenewal(String rollNo, String passId);
  Future<List<Student>> getStudents(int? year, String? name);
  Future<void> addStudent(Map<String, dynamic> data);
  Future<void> editStudent(Map<String, dynamic> data, String docId);
  Future<List<LoginUser>> getUnregisteredStudents();
  Future<void> addRoute(Map<String, dynamic> route);
  Future<void> editRoute(Map<String, dynamic> route, String docId);
  Future<List<BusPass>> getAllBusPass();
}
