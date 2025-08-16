import 'package:autonort/features/modules/taller/dominio/dominio.dart';
import 'package:autonort/features/modules/taller/infraestructura/infraestructura.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final horastecnicosRepositoryProvider = Provider<TallerRepositorio>((ref) {
  return TallerRepositoryImpl();
});
