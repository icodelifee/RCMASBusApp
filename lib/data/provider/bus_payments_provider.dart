import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/containers/user_container.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';

// ignore: top_level_function_literal_block
final paymentsProvider = FutureProvider((ref) async {
  final user = userContainer.resolve<LoginUser>();
  return await ref
      .watch(fireStoreRepositoryProvider)
      .getStudentPayments(user.rollNumber!);
});
