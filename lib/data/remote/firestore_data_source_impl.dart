import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuzzywuzzy/applicable.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/payment.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/data/model/route.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
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
        .where('payment_complete', isEqualTo: false)
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
        .where('pass_id', isEqualTo: student.busPass)
        .get();
    return BusPass.fromJson(buspass.docs.first.data()!, buspass.docs.first.id,
        student: student);
  }

  @override
  Future<YourBus> yourBusData() async {
    final busPass = await getBusPass();
    if (busPass.busId == null) {
      throw Exception();
    }
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

  @override
  Future<Driver> getDriver(String id) async {
    final snapshot = await firestore
        .collection('drivers')
        .where('driver_id', isEqualTo: id)
        .get();
    return Driver.fromJson(snapshot.docs.first.data()!, snapshot.docs.first.id);
  }

  @override
  Future<List<Payment>> getStudentPayments(String id) async {
    final snapshot = await firestore
        .collection('payments')
        .where('roll_no', isEqualTo: id)
        .get();

    return snapshot.docs.map((e) => Payment.fromJson(e.data()!)).toList();
  }

  @override
  Future<void> saveRenewal(Map<String, dynamic> data) async {
    final paymentId = Uuid().v4();
    // add payment
    await firestore.collection('payments').add({
      'payment_code': data['payment_code'],
      'payment_date': DateTime.now().toLocal(),
      'payment_id': paymentId,
      'pass_id': data['pass_id'],
      'roll_no': data['roll_no'],
    });

    await firestore.collection('renewals').add({
      'renewal_id': Uuid().v4(),
      'is_approved': false,
      'renewal_date': DateTime.now().toLocal(),
      'payment_id': paymentId,
      'pass_id': data['pass_id'],
      'roll_no': data['roll_no'],
    });
  }

  @override
  Future<Renewal> getRenewal(String rollNo, String passId) async {
    final snapshot = await firestore
        .collection('renewals')
        .where('pass_id', isEqualTo: passId)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return Renewal.fromJson(
          snapshot.docs.first.data()!, snapshot.docs.first.id);
    } else {
      return Renewal();
    }
  }

  @override
  Future<List<Student>> getStudents(int? year, String? name) async {
    final filteredStudents = <Student>[];
    final snapshot = await firestore.collection('students').get();
    final students =
        snapshot.docs.map((e) => Student.fromJson(e.data()!, e.id)).toList();

    if (year == 0 && name != '') {
      // when no year and only search textut
      final list = extractAll(
          query: name!,
          choices: students,
          cutoff: 40,
          getter: (Student student) => student.firstName!);
      return list.map((e) => e.choice).toList();
    } else if (year != 0 && name == '') {
      // when only year and no text
      await Future.forEach(students, (Student student) async {
        final busPassId = student.busPass;
        final busPassSnapshot = await firestore
            .collection('buspass')
            .where('pass_id', isEqualTo: busPassId)
            .get();
        final pass = BusPass.fromJson(
            busPassSnapshot.docs.first.data()!, busPassSnapshot.docs.first.id);
        print(pass.timestamp!.toDate().year == year);
        if (pass.timestamp!.toDate().year == year) {
          filteredStudents.add(student);
        }
      });
      return filteredStudents;
    } else if (year == 0 && name == '') {
      return students;
    } else {
      // when both parameters have value
      await Future.forEach(students, (Student student) async {
        final busPassId = student.busPass;
        final busPassSnapshot = await firestore
            .collection('buspass')
            .where('pass_id', isEqualTo: busPassId)
            .get();
        final pass = BusPass.fromJson(
            busPassSnapshot.docs.first.data()!, busPassSnapshot.docs.first.id);
        print(pass.timestamp!.toDate().year == year);
        if (pass.timestamp!.toDate().year == year) {
          filteredStudents.add(student);
        }
        final list = extractAll(
            query: name!,
            choices: filteredStudents,
            cutoff: 10,
            getter: (Student student) => student.firstName!);
        return list.map((e) => e.choice).toList();
      });
      return filteredStudents;
    }
  }

  @override
  Future<void> addStudent(Map<String, dynamic> data) async {
    await firestore.collection('login').add({
      'pay_complete': false,
      'reg_complete': false,
      'user_type': 'S',
      'first_name': data['first_name'],
      'last_name': data['last_name'],
      'phone': '91' + data['phone'],
      'roll_no': data['roll_no']
    });
    return;
  }

  @override
  Future<void> editStudent(Map<String, dynamic> data, String docId) async {
    await firestore.collection('students').doc(docId).update(data);
    return;
  }

  @override
  Future<List<LoginUser>> getUnregisteredStudents() async {
    final snapshot = await firestore
        .collection('login')
        .where('reg_complete', isEqualTo: false)
        .where('user_type', isEqualTo: 'S')
        .get();
    return snapshot.docs
        .map((e) => LoginUser.fromJson(e.data()!, e.id))
        .toList();
  }

  @override
  Future<void> addRoute(Map<String, dynamic> route) async {
    await firestore.collection('routes').add(route);
    return;
  }

  @override
  Future<List<BusPass>> getAllBusPass() async {
    final snapshot = await firestore.collection('buspass').get();
    final passes =
        snapshot.docs.map((e) => BusPass.fromJson(e.data()!, e.id)).toList();
    return passes;
  }

  @override
  Future<void> editRoute(Map<String, dynamic> route, String docId) async {
    await firestore.collection('routes').doc(docId).update(route);
    return;
  }

  @override
  Future<List<Stop>> getAllStops() async {
    return [];
    // Unimplemented method
    // final snapshot = await firestore.collection('s')
  }

  @override
  Future<void> addStop(Map<String, dynamic> stop, String routeId) async {
    await firestore
        .collection('routes')
        .doc(routeId)
        .collection('stops')
        .add(stop);
    return;
  }

  @override
  Future<void> editStop(
      Map<String, dynamic> stop, String routeId, String stopId) async {
    await firestore
        .collection('routes')
        .doc(routeId)
        .collection('stops')
        .doc(stopId)
        .update(stop);
    return;
  }

  @override
  Future<void> deleteStop(String stopId, String routeId) async {
    await firestore
        .collection('routes')
        .doc(routeId)
        .collection('stops')
        .doc(stopId)
        .delete();
    return;
  }

  @override
  Future<void> deleteRoute(String routeId) async {
    await firestore.collection('routes').doc(routeId).delete();
    return;
  }
}
