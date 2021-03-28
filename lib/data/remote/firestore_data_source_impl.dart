import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/remote/firestore_data_source.dart';

class FireStoreImpl implements FireStore {
  FireStoreImpl({required auth}) : _auth = auth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth;
  // final Logger _logger = Logger();
  @override
  Future<bool> checkUserEntry(String phone) async {
    final qs = await firestore
        .collection('login')
        .where('phone', isEqualTo: phone)
        .get();
    return qs.docs.isNotEmpty;
  }

  @override
  Future<LoginUser> getLoginUser() async {
    final qs = await firestore
        .collection('login')
        .where('phone',
            isEqualTo: _auth.currentUser!.phoneNumber!.replaceAll('+', ''))
        .get();
    final user = LoginUser.fromJson(qs.docs.first.data()!, qs.docs.first.id);
    return user;
  }

  @override
  Future getBusRoutes() async {
    final qs = await firestore.collection('routes').get();
    return qs.docs.map((e) {
      final data = e.data();
      data!.putIfAbsent('doc', () => e.id);
      return data;
    }).toList();
  }

  @override
  Future<List<Map>> getBusStops(String? route) async {
    if (route == null) return [];
    final qs = await firestore
        .collection('routes')
        .doc(route)
        .collection('stops')
        .get();
    return qs.docs.map((e) {
      final data = e.data();
      data!.putIfAbsent('doc', () => e.id);
      return data;
    }).toList();
  }

  @override
  Future<void> saveUserData(Map<String, dynamic> data) async {
    await firestore.collection('students').add(data);
    await firestore
        .collection('login')
        .where('roll_no', isEqualTo: data['roll_no'])
        .get()
        .then((value) async {
      final id = value.docs.first.id;
      await firestore
          .collection('login')
          .doc(id)
          .update({'reg_complete': true});
    });
  }

  @override
  Future<void> savePayment(String payCode) async {
    // await firestore.collection('students').a
  }
}
