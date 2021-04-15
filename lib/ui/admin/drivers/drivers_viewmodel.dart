import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/driver.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';
import 'package:uuid/uuid.dart';

final driversProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(fireStoreRepositoryProvider).getAllDrivers());

final driversViewProvider = ChangeNotifierProvider.autoDispose(
    (ref) => DriversViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

class DriversViewModel extends ChangeNotifier {
  DriversViewModel({required this.repo});
  final FireStoreRepository repo;

  // keys
  final formKey = GlobalKey<FormState>();

  // controllers
  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? phoneNumber;
  TextEditingController? licenseNumber;
  TextEditingController? expiryDate;

  // mutables
  DateTime? licenseExpiryDate;

  Future<void> addDriver() async {
    final driver = {
      'first_name': firstName!.text,
      'last_name': lastName!.text,
      'driver_id': Uuid().v4(),
      'license_no': licenseNumber!.text,
      'phone': '91' + phoneNumber!.text,
      'license_expiry_date': licenseExpiryDate
    };
    await repo.addDriver(driver);
  }

  Future<void> editDriver(Driver driver) async {
    final data = {
      'first_name': firstName!.text,
      'last_name': lastName!.text,
      'driver_id': Uuid().v4(),
      'license_no': licenseNumber!.text,
      'phone': phoneNumber!.text,
      'license_expiry_date': licenseExpiryDate
    };
    await repo.editDriver(data, driver.docId!);
  }
}
