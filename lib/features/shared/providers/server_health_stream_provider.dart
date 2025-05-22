import 'package:autonort/features/shared/dominio/dominio.dart';
import 'package:autonort/features/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Cada 30 s hace ping al servidor y emite:
///  - true si OK
///  - false si caído
/// Además emite inmediatamente un true al suscribirse.
final serverHealthStreamProvider = StreamProvider<bool>((ref) {
  final ServerRepository repo = ref.read(serverRepoProvider);

  // Generator que primero lanza un true, y luego cada 30 s hace el ping
  Stream<bool> healthStream() async* {
    // 1) Valor inicial
    yield true;

    // 2) Cada 30 s lanza un ping
    await for (final _ in Stream.periodic(const Duration(seconds: 30))) {
      final result = await repo.pingServer();
      yield result.fold((_) => false, (ok) => ok);
    }
  }

  return healthStream();
});