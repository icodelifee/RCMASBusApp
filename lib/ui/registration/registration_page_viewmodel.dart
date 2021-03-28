import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final registrationPageViewModelProvider = ChangeNotifierProvider((ref) =>
    RegistrationPageViewModel(
        fireStore: ref.read(fireStoreRepositoryProvider)));

final routesProvider = FutureProvider.autoDispose((ref) async {
  return await ref.read(fireStoreRepositoryProvider).getBusRoutes();
});

class RegistrationPageViewModel extends ChangeNotifier {
  RegistrationPageViewModel({required fireStore}) : _fireStore = fireStore;
  final FireStoreRepository _fireStore;
  final formKey = GlobalKey<FormState>();

  // mutable
  String? course;
  String? semester;
  TextEditingController? email;
  TextEditingController? paycode;
  String? _routeDocId;
  String? _stopDocId;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  String? get stopDocId => _stopDocId;

  // ignore: unnecessary_getters_setters
  set stopDocId(String? stopDocId) => _stopDocId = stopDocId;

  String? get routeDocId => _routeDocId;

  set routeDocId(String? routeDocId) {
    _routeDocId = routeDocId;
    notifyListeners();
  }

  Future<List<Map>> getStops() async {
    return _fireStore.getBusStops(routeDocId);
  }

  Future<void> saveUserData(LoginUser user) async {
    final data = {
      'first_name': user.firstName,
      'last_name': user.lastName,
      'phone': user.phone,
      'roll_no': user.rollNumber,
      'email': email!.text,
      'course': course,
      'semester': semester,
    };
    await _fireStore.saveUserData(data);
    isLoading = false;
  }

  Future<void> completePayment() async{

    // aw
  }
}
