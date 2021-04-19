import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/payment.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';
import 'package:rcmasbusapp/data/model/route.dart';
import 'package:rcmasbusapp/data/remote/firestore_data_source.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

// TODO: need to add error handlers
class FireStoreRepositoryImpl implements FireStoreRepository {
  FireStoreRepositoryImpl({required FireStore fireStoreDataSource})
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

  @override
  Future getBusRoutes() {
    return _fireStoreDataSource.getBusRoutes();
  }

  @override
  Future<List<Map<String, dynamic>>> getBusStops(String? route) {
    return _fireStoreDataSource.getBusStops(route);
  }

  @override
  Future<void> saveUserData(Map<String, dynamic> data) {
    return _fireStoreDataSource.saveUserData(data);
  }

  @override
  Future<void> savePayment(String payCode) {
    return _fireStoreDataSource.savePayment(payCode);
  }

  @override
  Future<void> generateBusPass(Map<String, dynamic> data) {
    return _fireStoreDataSource.generateBusPass(data);
  }

  @override
  Future<Stream<DocumentSnapshot>> getBusPassStream() {
    return _fireStoreDataSource.getBusPassStream();
  }

  @override
  Future<BusPass> getBusPass() {
    return _fireStoreDataSource.getBusPass();
  }

  @override
  Future<Bus> getBus(String id) {
    return _fireStoreDataSource.getBus(id);
  }

  @override
  Future<Route> getRoutes(String id) {
    return _fireStoreDataSource.getRoutes(id);
  }

  @override
  Future<YourBus> yourBusData() {
    return _fireStoreDataSource.yourBusData();
  }

  @override
  Future<Map<String, dynamic>> getInformation() {
    return _fireStoreDataSource.getInformation();
  }

  @override
  Future<Student> getStudent(String rollNo) {
    return _fireStoreDataSource.getStudent(rollNo);
  }

  @override
  Future<Driver> getDriver(String id) {
    return _fireStoreDataSource.getDriver(id);
  }

  @override
  Future<List<Payment>> getStudentPayments(String id) {
    return _fireStoreDataSource.getStudentPayments(id);
  }

  @override
  Future<void> saveRenewal(Map<String, dynamic> data) {
    return _fireStoreDataSource.saveRenewal(data);
  }

  @override
  Future<Renewal> getRenewal(String rollNo, String passId) {
    return _fireStoreDataSource.getRenewal(rollNo, passId);
  }

  @override
  Future<List<Student>> getStudents(int? year, String? name) {
    return _fireStoreDataSource.getStudents(year, name);
  }

  @override
  Future<void> addStudent(Map<String, dynamic> data) {
    return _fireStoreDataSource.addStudent(data);
  }

  @override
  Future<void> editStudent(Map<String, dynamic> data, String docId) {
    return _fireStoreDataSource.editStudent(data, docId);
  }

  @override
  Future<List<LoginUser>> getUnregisteredStudents() {
    return _fireStoreDataSource.getUnregisteredStudents();
  }

  @override
  Future<void> addRoute(Map<String, dynamic> route) {
    return _fireStoreDataSource.addRoute(route);
  }

  @override
  Future<List<BusPass>> getAllBusPass() {
    return _fireStoreDataSource.getAllBusPass();
  }

  @override
  Future<void> editRoute(Map<String, dynamic> route, String docId) {
    return _fireStoreDataSource.editRoute(route, docId);
  }

  @override
  Future<List<Stop>> getAllStops() {
    return _fireStoreDataSource.getAllStops();
  }

  @override
  Future<void> addStop(Map<String, dynamic> stop, String routeDocId) {
    return _fireStoreDataSource.addStop(stop, routeDocId);
  }

  @override
  Future<void> editStop(
      Map<String, dynamic> stop, String routeDocId, String stopDocId) {
    return _fireStoreDataSource.editStop(stop, routeDocId, stopDocId);
  }

  @override
  Future<void> deleteStop(String stopId, String routeId) {
    return _fireStoreDataSource.deleteStop(stopId, routeId);
  }

  @override
  Future<void> deleteRoute(String routeId) {
    return _fireStoreDataSource.deleteRoute(routeId);
  }

  @override
  Future<void> approveBusPass(
      Map<String, dynamic> pass, String docId, String busId) {
    return _fireStoreDataSource.approveBusPass(pass, docId, busId);
  }

  @override
  Future<List<Bus>> getAllBus() {
    return _fireStoreDataSource.getAllBus();
  }

  @override
  Future<List<Driver>> getAllDrivers() {
    return _fireStoreDataSource.getAllDrivers();
  }

  @override
  Future<void> addDriver(Map<String, dynamic> driver) {
    return _fireStoreDataSource.addDriver(driver);
  }

  @override
  Future<void> editDriver(Map<String, dynamic> driver, String docId) {
    return _fireStoreDataSource.editDriver(driver, docId);
  }

  @override
  Future<void> addBus(Map<String, dynamic> bus) {
    return _fireStoreDataSource.addBus(bus);
  }

  @override
  Future<void> editBus(Map<String, dynamic> bus, String docId) {
    return _fireStoreDataSource.editBus(bus, docId);
  }

  @override
  Future<List<Renewal>> getAllRenewals() {
    return _fireStoreDataSource.getAllRenewals();
  }

  @override
  Future<void> approveRenewal(Map<String, dynamic> data) {
    return _fireStoreDataSource.approveRenewal(data);
  }

  @override
  Future<List<Student>> getAllBusStudents(String busId) {
    return _fireStoreDataSource.getAllBusStudents(busId);
  }

  @override
  Future<YourBus> getStudentYourBusData(String passId) {
    return _fireStoreDataSource.getStudentYourBusData(passId);
  }

  @override
  Future<List<BusPass>> getAllNotRenewedPass() {
    return _fireStoreDataSource.getAllNotRenewedPass();
  }
}
