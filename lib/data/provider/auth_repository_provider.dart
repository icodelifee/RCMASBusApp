import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/auth_data_source_provider.dart';
import 'package:rcmasbusapp/data/repository/auth_repository.dart';
import 'package:rcmasbusapp/data/repository/auth_repository_impl.dart';

final authRepositoryProvider =Provider<AuthRepository>((ref) => AuthRepositoryImpl(
        authDataSource: ref.read(authDataSourceProvider)));
