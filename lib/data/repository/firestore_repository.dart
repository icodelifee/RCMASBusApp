import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/route.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';

abstract class FireStoreRepository {
  Future<bool> checkUserEntry(String phone);
  Future getBusRoutes();
  Future<LoginUser> getLoginUser();
  Future<List<Map<String, dynamic>>> getBusStops(String? route);
  Future<void> saveUserData(Map<String, dynamic> data);
  Future<void> savePayment(String payCode);
  Future<void> generateBusPass(Map<String, dynamic> data);
  Future<Stream<DocumentSnapshot>> getBusPassStream();
  Future<BusPass> getBusPass();
  Future<YourBus> yourBusData();
  Future<Bus> getBus(String id);
  Future<Route> getRoutes(String id);
  Future<Map<String, dynamic>> getInformation();
}
