import 'package:autonort/features/home/dominio/dominio.dart';
import 'package:autonort/features/home/infraestructura/infraestructura.dart';

class HomeRepositoryImpl extends HomeRepositories {
  final HomeDatasource homeSource;

  HomeRepositoryImpl({HomeDatasource? homeSource})
      : homeSource = homeSource ?? HomeDatasourceImpl();

  @override
  Future<Home> tutorial(String codempreda) {
    return homeSource.tutorial(codempreda);
  }
}
