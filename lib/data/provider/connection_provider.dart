import 'package:connectivity/connectivity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final AutoDisposeStreamProvider<ConnectivityResult>? connectionProvider = StreamProvider.autoDispose((ref) {
  final con = Connectivity().onConnectivityChanged;
  return con;
});
