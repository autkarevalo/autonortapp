import 'package:autonort/features/shared/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityRepoProvider = Provider<ConnectivityRepositoriesImpl>((ref) {
  return ConnectivityRepositoriesImpl();
});

final hasNetworkProvider = FutureProvider<bool>((ref) async {
  final repo = ref.read(connectivityRepoProvider);
  return repo.checkNetwork().then((r) => r.fold((_) => false, (ok) => ok));
});
