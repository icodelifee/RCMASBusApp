import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/stop.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';
import 'package:uuid/uuid.dart';

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
  Map<String, dynamic>? routeMap;
  Stop? _stopMap;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? get stopDocId => _stopDocId;
  Stop? get stopMap => _stopMap;
  String? get routeDocId => _routeDocId;

  set stopDocId(String? stopDocId) {
    _stopDocId = stopDocId;
    notifyListeners();
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set stopMap(Stop? stopMap) {
    _stopMap = stopMap;
    notifyListeners();
  }

  set routeDocId(String? routeDocId) {
    _routeDocId = routeDocId;
    notifyListeners();
  }

  Future<List<Stop>> getStops() async {
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

  Future<void> generateBusPass() async {
    final user = userContainer.resolve<LoginUser>();
    final data = {
      'route_id': routeMap!['route_id'],
      'stop_id': stopMap!.stopId!,
      'pass_id': Uuid().v4(),
      'roll_no': user.rollNumber,
      'timestamp': DateTime.now().toLocal(),
      'is_approved': false,
      'payment_complete': false
    };
    await _fireStore.generateBusPass(data);
  }

  Future<void> completePayment() async {
    await _fireStore.savePayment(paycode!.text);
  }
}
