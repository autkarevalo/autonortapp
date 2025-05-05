import 'package:autonort/features/modules/menu/dominio/dominio.dart';
import 'package:autonort/features/modules/menu/infraestructura/infraestructura.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuRepositoryProvider = Provider<MenuRepositorio>((ref) {
  return MenuRepositoryImpl();
});
