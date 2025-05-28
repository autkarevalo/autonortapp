import 'package:autonort/features/home/dominio/dominio.dart';
import 'package:autonort/features/home/infraestructura/infraestructura.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider<HomeRepositories>((ref) {
  return HomeRepositoryImpl(homeSource: HomeDatasourceImpl());
});
