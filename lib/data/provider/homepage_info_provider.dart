import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firestore_repository_provider.dart';

final informationProvider = FutureProvider((ref) async =>
    await ref.watch(fireStoreRepositoryProvider).getInformation());

final informationStreamProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(fireStoreRepositoryProvider).getInformationStream());
