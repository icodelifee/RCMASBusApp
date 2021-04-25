import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/change_route.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/payment.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/data/model/route.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';

abstract class FireStore {
  Future<bool> checkUserEntry(String phone);
  Future<LoginUser> getLoginUser();
  Future<List<Stop>> getBusStops(String? route);
  Future<void> saveUserData(Map<String, dynamic> data);

  Future<Stream<DocumentSnapshot>> getBusPassStream();
  Future<Map<String, dynamic>> getInformation();
  Future<Driver> getDriver(String id);

  // payments
  Future<List<Payment>> getStudentPayments(String id);
  Future<void> savePayment(String payCode);
  Future<Payment> getStudentPayment(String pay_id);

  // renewals
  Future<void> saveRenewal(Map<String, dynamic> data);
  Future<Renewal> getRenewal(String rollNo, String passId);
  Future<List<Renewal>> getAllRenewals();
  Future<void> approveRenewal(Map<String, dynamic> data);
  Future<List<BusPass>> getAllNotRenewedPass();
  // student
  Future<List<Student>> getStudents(int? year, String? name);
  Future<Student> getStudent(String rollNo);
  Future<void> addStudent(Map<String, dynamic> data);
  Future<void> editStudent(Map<String, dynamic> data, String docId);
  Future<List<LoginUser>> getUnregisteredStudents();

  // route
  Future<Route> getRoutes(String id);
  Future getBusRoutes();
  Future<List<Route>> getAllRoutes();
  Future<void> addRoute(Map<String, dynamic> route);
  Future<void> editRoute(Map<String, dynamic> route, String docId);
  Future<void> deleteRoute(String routeId);
  Future<void> changeRoute(Route route, Stop stop);
  Future<ChangeRoute> getStudentChangeRoute();
  Future<List<ChangeRoute>> getAllChangeRoutes();
  Future<void> submitRouteChangePaycode(String payCode, String docId);
  Future<void> approveBusRouteChange(Map<String, dynamic> data);
  Future<void> cancelBusRouteChange(String docId);

  // stop
  Future<List<Stop>> getAllStops();
  Future<void> addStop(Map<String, dynamic> stop, String routeDocId);
  Future<void> editStop(
      Map<String, dynamic> stop, String routeDocId, String stopDocId);
  Future<void> deleteStop(String stopId, String routeId);

  // bus pass
  Future<void> approveBusPass(
      Map<String, dynamic> pass, String docId, String busId);
  Future<void> generateBusPass(Map<String, dynamic> data);
  Future<BusPass> getStudentBusPass(String passId);
  Future<YourBus> getStudentYourBusData(String passId);
  Future<BusPass> getBusPass();

  // bus
  Future<List<Bus>> getAllBus();
  Future<YourBus> yourBusData();
  Future<Bus> getBus(String id);
  Future<void> addBus(Map<String, dynamic> bus);
  Future<void> editBus(Map<String, dynamic> bus, String docId);
  Future<List<Student>> getAllBusStudents(String busId);
  Future<List<BusPass>> getAllBusPass();

  // drivers
  Future<List<Driver>> getAllDrivers();
  Future<void> addDriver(Map<String, dynamic> driver);
  Future<void> editDriver(Map<String, dynamic> driver, String docId);

  Future<void> updateInformation(String data);
  Future<void> toggleInformation(bool val);
  Stream<DocumentSnapshot> getInformationStream();
}
