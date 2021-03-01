import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/firestore_data_source_provider.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository.dart';
import 'package:rcmasbusapp/data/repository/firestore_repository_impl.dart';

final fireStoreRepositoryProvider = Provider<FireStoreRepository>((ref) =>
    FireStoreRepositoryImpl(
        fireStoreDataSource: ref.read((fireStoreDataSourceProvider))));
