import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/data/remote/firestore_data_source.dart';
import 'package:uuid/uuid.dart';

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
    userContainer.registerInstance<LoginUser>(user);
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
  Future<List<Map<String, dynamic>>> getBusStops(String? route) async {
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
    data.putIfAbsent('student_id', () => Uuid().v4());
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
    final user = userContainer.resolve<LoginUser>();
    // final student = await getStudent(user.rollNumber!);
    final loginDocRef = firestore.collection('login').doc(user.docId);
    final paymentId = Uuid().v4();
    await firestore.collection('payments').add({
      'payment_code': payCode,
      'payment_date': DateTime.now().toLocal(),
      'payment_id': paymentId,
      'roll_no': user.rollNumber,
    });
    await loginDocRef.update({'pay_complete': true});
    final passSnapshot = await firestore
        .collection('buspass')
        .where('roll_no', isEqualTo: user.rollNumber)
        .where('is_payment_complete', isEqualTo: false)
        .get();
    final passId = passSnapshot.docs.first.id;
    await firestore
        .collection('buspass')
        .doc(passId)
        .update({'is_payment_completed': true, 'payment_id': paymentId});
  }

  @override
  Future<Student> getStudent(String rollNo) async {
    final snapshot = await firestore
        .collection('students')
        .where('roll_no', isEqualTo: rollNo)
        .get();
    return Student.fromJson(
        snapshot.docs.first.data()!, snapshot.docs.first.id);
  }

  @override
  Future<void> generateBusPass(Map<String, dynamic> data) async {
    await firestore.collection('buspass').add(data);
    return;
  }
}
