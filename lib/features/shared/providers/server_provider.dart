import 'package:autonort/features/shared/dominio/dominio.dart';
import 'package:autonort/features/shared/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serverRepoProvider =
    Provider<ServerRepository>((_) => ServerRepositoriesImpl());

final pingServerProvider = FutureProvider<bool>((ref) async {
  final repo = ref.read(serverRepoProvider);
  return repo.pingServer().then((e) => e.fold((_) => false, (ok) => ok));
});
