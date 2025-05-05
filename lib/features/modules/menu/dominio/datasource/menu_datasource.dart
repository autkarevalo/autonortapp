import '../entidades/menu.dart';

abstract class MenuDatasource {
  Future<List<Menu>> menugeneral(
      String codempresa, String idusuario, String aplicativo);
}
