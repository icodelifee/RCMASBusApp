import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/auth_data_source_provider.dart';
import 'package:rcmasbusapp/data/provider/firebase_auth_provider.dart';

final authChangesProvider =
    StreamProvider((ref) => ref.watch(authDataSourceProvider).authStateChanges);
