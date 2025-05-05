import 'package:autonort/features/modules/menu/dominio/dominio.dart';
import '../infraestructura.dart';

class MenuRepositoryImpl extends MenuRepositorio {
  final MenuDatasource menuSource;

  MenuRepositoryImpl({MenuDatasource? menuSource})
      : menuSource = menuSource ?? MenuDatasourceImpl();

  @override
  Future<List<Menu>> menugeneral(
      String codempresa, String idusuario, String aplicativo) {
    return menuSource.menugeneral(codempresa, idusuario, aplicativo);
  }
}
