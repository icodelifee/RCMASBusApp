import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/route.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';
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
    final student = await getStudent(user.rollNumber!);
    final loginDocRef = firestore.collection('login').doc(user.docId);
    final paymentId = Uuid().v4();

    //get buspass
    final passSnapshot = await firestore
        .collection('buspass')
        .where('roll_no', isEqualTo: user.rollNumber)
        .where('is_payment_complete', isEqualTo: false)
        .get();

    // get bus pass id to update
    final passId = passSnapshot.docs.first.id;
    final busPassId = passSnapshot.docs.first.data()!['pass_id'];

    // add payments
    await firestore.collection('payments').add({
      'payment_code': payCode,
      'payment_date': DateTime.now().toLocal(),
      'payment_id': paymentId,
      'pass_id': busPassId,
      'roll_no': user.rollNumber,
    });

    //update login db
    await loginDocRef.update({'pay_complete': true});

    //update bus pass
    await firestore
        .collection('buspass')
        .doc(passId)
        .update({'is_payment_complete': true, 'payment_id': paymentId});

    // update student
    await firestore
        .collection('students')
        .doc(student.docId)
        .update({'bus_pass': busPassId});
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

  @override
  Future<Stream<DocumentSnapshot>> getBusPassStream() async {
    final busPass = await getBusPass();
    return firestore.collection('buspass').doc(busPass.docId).snapshots();
  }

  @override
  Future<BusPass> getBusPass() async {
    final user = userContainer.resolve<LoginUser>();
    final student = await getStudent(user.rollNumber!);
    final buspass = await firestore
        .collection('buspass')
        .where('pass_id', isEqualTo: student.bus_pass)
        .get();
    return BusPass.fromJson(buspass.docs.first.data()!, buspass.docs.first.id);
  }

  @override
  Future<YourBus> yourBusData() async {
    final busPass = await getBusPass();
    final bus = await getBus(busPass.busId!);
    final route = await getRoutes(busPass.routeId!);
    return YourBus(bus: bus, route: route, busPass: busPass);
  }

  @override
  Future<Bus> getBus(String id) async {
    final snapshot = await firestore
        .collection('buses')
        .where('bus_id', isEqualTo: id)
        .get();
    return Bus.fromJson(snapshot.docs.first.data()!, snapshot.docs.first.id);
  }

  @override
  Future<Route> getRoutes(String id) async {
    final routesRef = firestore.collection('routes');
    final snapshot = await routesRef.where('route_id', isEqualTo: id).get();
    final routeId = snapshot.docs.first.id;
    final stopSnapshot = await routesRef.doc(routeId).collection('stops').get();
    final route =
        Route.fromJson(snapshot.docs.first.data()!, stopSnapshot.docs, routeId);
    return route;
  }

  @override
  Future<Map<String, dynamic>> getInformation() async {
    final snapshot =
        await firestore.collection('homepage').doc('information').get();
    return snapshot.data()!;
  }
}
