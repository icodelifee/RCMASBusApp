import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/provider/firebase_auth_provider.dart';
import 'package:rcmasbusapp/data/remote/firestore_data_source.dart';
import 'package:rcmasbusapp/data/remote/firestore_data_source_impl.dart';

final fireStoreDataSourceProvider = Provider<FireStore>(
    (ref) => FireStoreImpl(auth: ref.read(firebaseAuthProvider)));
