import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
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
}
