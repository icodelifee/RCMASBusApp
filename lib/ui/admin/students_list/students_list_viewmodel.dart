import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/model/student.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';

final studentListProvider = ChangeNotifierProvider.autoDispose((ref) =>
    StudentsListViewModel(repo: ref.watch(fireStoreRepositoryProvider)));

final studentListFuture = FutureProviderFamily(
    (ref, Map<String, dynamic> data) async => await ref
        .watch(fireStoreRepositoryProvider)
        .getStudents(data['year'] as int?, data['text'] as String?));

class StudentsListViewModel extends ChangeNotifier {
  StudentsListViewModel({required this.repo});
  final FireStoreRepository repo;

  final addStudentKey = GlobalKey<FormState>();
  final editStudentKey = GlobalKey<FormState>();

  // controllers
  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? phone;
  TextEditingController? rollNo;
  TextEditingController? email;
  // mutables
  String? _searchText;
  int? _searchYear;
  bool? _isLoading = false;

  bool? get isLoading => _isLoading;
  int? get searchYear => _searchYear;
  String? get searchText => _searchText;

  set searchYear(int? searchYear) {
    _searchYear = searchYear;
    notifyListeners();
  }

  set isLoading(bool? isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set searchText(String? searchText) {
    _searchText = searchText;
    notifyListeners();
  }

  Future<List<Student>> getStudents(int? year, String? text) {
    return repo.getStudents(year, text);
  }

  Future<List<LoginUser>> getUnregisteredUsers() {
    return repo.getUnregisteredStudents();
  }

  Future<void> addStudent() async {
    final data = <String, dynamic>{};
    data['roll_no'] = rollNo!.text;
    data['first_name'] = firstName!.text;
    data['last_name'] = lastName!.text;
    data['phone'] = phone!.text;
    await repo.addStudent(data);
  }

  Future<void> editStudent(Student student) async {
    isLoading = true;
    final data = <String, dynamic>{};
    data['first_name'] = firstName!.text;
    data['last_name'] = lastName!.text;
    data['phone'] ='91'+ phone!.text;
    data['roll_no'] = rollNo!.text;
    data['email'] = email!.text;
    await repo.editStudent(data, student.docId!);
    isLoading = false;
  }
}
