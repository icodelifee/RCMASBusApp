import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';
import 'package:uuid/uuid.dart';

final busesProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(fireStoreRepositoryProvider).getAllBus());

final busViewProvider = ChangeNotifierProvider.autoDispose(
    (ref) => BusesViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class BusesViewModel extends ChangeNotifier {
  BusesViewModel({required this.repo});
  final FireStoreRepository repo;

  final formKey = GlobalKey<FormState>();

  TextEditingController? busNumber;
  TextEditingController? licenseNumber;
  TextEditingController? insurance;
  TextEditingController? pollution;
  TextEditingController? fitness;
  TextEditingController? tax;
  TextEditingController? permit;

  // mutables

  Bus? bus;
  DateTime? pollutionDate;
  DateTime? insuranceDate;
  DateTime? fitnessDate;
  DateTime? taxDate;
  DateTime? permitDate;
  Driver? driver;

  Future<void> addBus() async {
    final data = {
      'bus_id': Uuid().v4(),
      'bus_no': busNumber!.text,
      'bus_license_no': licenseNumber!.text,
      'pollution': pollutionDate,
      'insurance': insuranceDate,
      'fitness': fitnessDate,
      'tax': taxDate,
      'permit': permitDate,
      'driver_id': driver!.driverId
    };
    await repo.addBus(data);
  }

  Future<void> editBus() async {
    final data = {
      'bus_no': busNumber!.text,
      'bus_license_no': licenseNumber!.text,
      'pollution': pollutionDate,
      'insurance': insuranceDate,
      'fitness': fitnessDate,
      'tax': taxDate,
      'permit': permitDate,
      'driver_id': driver!.driverId
    };
    await repo.editBus(data, bus!.docId!);
  }

  Future<Driver> getDriver(String id) async {
    final drivers = await repo.getAllDrivers();
    return drivers.firstWhere((element) => element.driverId == id);
  }
}
