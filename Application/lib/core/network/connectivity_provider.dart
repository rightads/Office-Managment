import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@Riverpod(keepAlive: true)
Connectivity connectivity(Ref ref) => Connectivity();

@riverpod
Stream<List<ConnectivityResult>> connectivityChanges(Ref ref) {
  return ref.watch(connectivityProvider).onConnectivityChanged;
}
