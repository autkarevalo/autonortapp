import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';
import 'package:autonort/features/modules/viligancia/infraestructura/infraestructura.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ingresosalidavhRepositoryProvider =
    Provider<VigilanciaRepositorio>((ref) {
  return VigilanciaRepositoryImpl();
});
